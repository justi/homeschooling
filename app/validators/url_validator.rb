require 'net/http'
require 'net/https'
require 'uri'

class UrlValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    url = value

    # Regex code by 'Arsenic' from http://snippets.dzone.com/posts/show/3654
    if url =~ /^
    (    (https?):\/\/                            )?
    (    [a-z\d]+([\-\.][a-z\d]+)*\.[a-z]{2,6}    )
         (
           (:
         (      \d{1,5}                           )
            )?
    (        \/.*                                 )?
         )?
    $/ix
      url = "http#{'s' if $7 == '81'}://#{url}" unless $1
    else
      record.errors[attribute] << 'Not a valid URL'
    end

    if options[:verify]
      begin
        url_response = RedirectFollower.new(url).resolve
        url = url_response.url if options[:verify] == [:resolve_redirects]
      rescue RedirectFollower::TooManyRedirects
        record.errors[attribute] << 'URL is redirecting too many times'
      rescue RedirectFollower::Error
        record.errors[attribute] << "can't verify url"
      end
    end

    if options[:update]
      value.replace url
    end
  end
end

# Code below written by John Nunemaker
# See blog post at http://railstips.org/blog/archives/2009/03/04/following-redirects-with-nethttp/
class RedirectFollower
  class Error < StandardError; end
  class TooManyRedirects < Error; end

  attr_accessor :url, :body, :redirect_limit, :response

  def initialize(url, limit=5)
    @url, @redirect_limit = url, limit
    logger.level = Logger::INFO
  end

  def logger
    @logger ||= Logger.new(STDOUT)
  end

  def resolve
    raise TooManyRedirects if redirect_limit < 0

    http_check
    
    # begin
    #   logger.info "redirect limit: #{redirect_limit}"
    #   logger.info "response code: #{response.code}"
    #   logger.debug "response body: #{response.body}"
    # rescue 
    #   raise Error
    # end

    if response.kind_of?(Net::HTTPRedirection)
      self.url = redirect_url
      self.redirect_limit -= 1

      # logger.info "redirect found, headed to #{url}"
      resolve
    end

    self.body = response.body
    self
  end

  def http_check
    if url =~ /http:/ix
      begin
        self.response = Net::HTTP.get_response(URI.parse(url))
      rescue
        raise Error
      end
    end
    #rozwiazanie z http://www.rubyinside.com/nethttp-cheat-sheet-2940.html
    if url =~ /https:/ix
      begin
        http = Net::HTTP.new(URI.parse(url).host, URI.parse(url).port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        self.response = http.request(Net::HTTP::Get.new(URI.parse(url).request_uri))
      rescue
        raise Error
      end
    end
  end

  def redirect_url
    if response['location'].nil?
      response.body.match(/<a href=\"([^>]+)\">/i)[1]
    else
      response['location']
    end
  end
end