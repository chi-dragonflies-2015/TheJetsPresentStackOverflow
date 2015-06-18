require 'nokogiri'
require 'net/http'
require 'uri'



class Page

  attr_accessor :url


  def initialize(url)
    @url = url
  end

  def length
    text = page.search('*').map{|everything| everything.inner_text}
    text.join('').gsub("\n",'').gsub(/\s{1}\s*/, ' ').strip.length
  end

  def titles
    titles = page.search('.question-hyperlink').map do |title|
      title.inner_text
    end
  end

  def to_s
    puts "Title: #{title}"
    puts "Content Length: #{length} characters"
    puts "External Links:"
    links.each.with_index do |link, index|
      puts "#{index+1}. #{link}"
    end
  end

  private

  def fetch!
    if response.code == "200"
      response.body
    elsif response.code == "301"
      Page.new(response.header['location']).fetch!
    else
      "Error"
    end

  end

  def request
    Net::HTTP::Get.new(uri.request_uri)
  end

  def uri
    URI.parse(url)
  end

  def response
    http.request(request)
  end

  def http

    Net::HTTP.new(uri.host, uri.port)
  end

  def page
    Nokogiri::HTML(fetch!)
  end


end

page = Page.new("http://stackoverflow.com/")
puts page.titles
