class ApplicationController < ActionController::Base
  before_filter CASClient::Frameworks::Rails::Filter
  before_filter :set_current_user
  protect_from_forgery
  require 'declarative_authorization/maintenance'
  include Authorization::Maintenance

  def current_user
    without_access_control do
      Person.includes(:application_assignments).find_or_create_by_loginid(session[:cas_user])
    end
  end
  
  def set_current_user
    Authorization.current_user = current_user
  end
  
  # Handling errors
  class RmUnreachable < StandardError; end
  rescue_from RmUnreachable, :with => :render_rm_unreachable

  def render_rm_unreachable
    respond_to do |format| 
      format.html { render :template => "errors/tech_difficulties", :status => 500, :layout => "error" } 
    end
    true
  end
    
  def currentMessages
    require 'rexml/document'

    # read dss-messeenger rss feed for 'most recent messages''
    uri = URI.parse("https://messenger.dss.ucdavis.edu/messages/open.rss")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
    response = http.request(Net::HTTP::Get.new(uri.request_uri))
    xml_data = response.body
    doc = REXML::Document.new(xml_data)
    titles = []
    links = []

    messages = Array.new
    message = Hash.new
    # populate messages array
    doc.elements.each('rss/channel/item') do |ele|
       title = ele.elements['title'].text
       description = ele.elements['description'].text
       published = ele.elements['pubDate'].text
       guid = ele.elements['guid'].text
       
       message['title'] = title
       message['description'] = description
       message['published'] = published
       message['guid'] = guid
       messages << message
    end
    messages
  end
end
