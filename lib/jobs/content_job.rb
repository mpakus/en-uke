class ContentJob
  def parse(link)
    require 'readability'
    require 'open-uri'
    url     = normalize(link.url)
    content = Content.where(url: url).first
    if content.nil?
      source  = open(link.url).read
      content = Content.create(text: Readability::Document.new(source).content, url: url)
      content.save
    end
    link.content = content
    link.save
  rescue => e
    puts e.message
  end
  handle_asynchronously :parse

  protected
  def normalize(url)
    url.strip.gsub(/\Ahttp(s*):\/*/, '').gsub(/\Aw{3,}\./, '').gsub(/\/\Z/, '')
  end
end
