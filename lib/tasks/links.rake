# require 'open-uri'
# require 'open_uri_redirections'

namespace :links do
  desc "Retrieve links information"
  task :get_content => :environment do
    Link.where(content: nil).each do |link|
      link.get_content!
    end
  end

end
