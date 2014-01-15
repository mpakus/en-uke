# require 'open-uri'
# require 'open_uri_redirections'

namespace :links do
  desc "Retrieve information"
  task :info => :environment do
    # Link.where(title: nil).find_each do |link|
    #   begin
    #     html = open(link.url, :allow_redirections => :all)
    #     page = Nokogiri::HTML(html)
    #     link.title = page.css('title')[0].text
    #     link.save
    #   rescue  => ex
    #     puts "Missing url #{link.url}"
    #   end
    # end
  end

end
