namespace :messenger do
  desc 'Synchronizes messages to dss-messenger RSS feed'
  task :sync => :environment do
    puts "MESSENGER SYNC RAKE START"
    m = Message.new
    m.sync()
    # code goes here
  end
end

