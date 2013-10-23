class ApplicationAssignmentsController < ApplicationController
  filter_resource_access
  respond_to :html, :json
  
  def index
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Loaded application assignments index (main page)."
    
    @messages = Rails.cache.fetch("algo", expires_in: 3.minutes) { fetch_messenger_rss }
    current_user.refresh!
    @current_user = current_user
  end

  def destroy
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Destroying bookmark #{params[:id]} ..."
    
    @bookmark_app = ApplicationAssignment.find(params[:id])
    @bookmark_app.destroy
    
    respond_with @bookmark_app
  end

  def update
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Updating bookmark #{params[:id]} ..."
    
    @assignment = ApplicationAssignment.find(params[:id])
    @assignment.update_attributes(params[:application_assignment])
    
    respond_with @assignment
  end

  def create
    logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Creating assignment ..."

    @assignment = ApplicationAssignment.new(params[:application_assignment])

    respond_to do |format|
      if @assignment.save
        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Assignment created."
        format.json { render json: @assignment, status: :created, location: @assignment }
      else
        logger.info "#{current_user.log_identifier}@#{request.remote_ip}: Assignment creation failed."
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def fetch_messenger_rss
    require 'rexml/document'
    
    # Read DSS Messenger RSS feed for active messages
    uri = URI.parse("https://messenger.dss.ucdavis.edu/messages/open.rss")
    
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # this has to go
    
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    doc = REXML::Document.new(response.body)
    
    messages = []
    
    doc.elements.each('rss/channel/item') do |ele|
      message = Hash.new
      
      messages << {
        'title' => ele.elements['title'].text,
        'description' => ele.elements['description'].text,
        'published' => ele.elements['pubDate'].text,
        'guid' => ele.elements['guid'].text
      }
    end
    
    return messages
  end
end
