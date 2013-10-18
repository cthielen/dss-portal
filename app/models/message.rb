class Message < ActiveRecord::Base
  attr_accessible :description, :guid, :published, :title

  def sync
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

    # wipe messages database cache
    Message.destroy_all

    # repopulate messages database
    doc.elements.each('rss/channel/item') do |ele|
       title = ele.elements['title'].text
       description = ele.elements['description'].text
       published = ele.elements['pubDate'].text
       guid = ele.elements['guid'].text
       
       message = Message.find_or_create_by_guid(guid)
       message.title = title
       message.description = description
       message.published = published
       message.save
    end
  end
end
