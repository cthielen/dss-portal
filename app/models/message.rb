class Message < ActiveRecord::Base
  attr_accessible :description, :guid, :published, :title

  def syncgo
    uri = URI.parse("https://messenger.dss.ucdavis.edu/messages/open.rss")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE # read into this
    @response = http.request(Net::HTTP::Get.new(uri.request_uri))
    puts @response.body
  end
end
