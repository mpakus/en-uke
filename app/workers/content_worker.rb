class ContentWorker
  include Sidekiq::Worker

  def perform(url, link_id)
    require 'readability'
    require 'open-uri'
    # url     = normalize(url)
    content = Content.where(url: url).first
    if content.nil?
      source  = open(url).read
      content = Content.create(text: Readability::Document.new(source).content, url: url)
      content.save
    end
    link = Link.find(link_id)
    link.update_attributes(content: content)
  rescue => e
    puts e.message
  end

  protected
  def normalize(url)
    url.strip.gsub(/\Ahttp(s*):\/*/, '').gsub(/\Aw{3,}\./, '').gsub(/\/\Z/, '')
  end
end
