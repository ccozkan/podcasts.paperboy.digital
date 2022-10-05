require 'feedbag'
require 'feedjira'

class EpisodesReceiverService

  def initialize(rss_url)
    @rss_url = rss_url
  end

  def call
    response = RequestMakerService.new(@rss_url).call

  #   return response unless response.success?

  # rescue StandartError => e
  # else
  # end


    if response.success?
      begin
        xml = response.payload.body
        episodes = parse_response(xml)

        raise UrlIsNotFeed unless verify_rss_url

        data = format_response(episodes)

      rescue StandardError => e
        OpenStruct.new({ success?: false, error: e })
      else
        OpenStruct.new({ success?: true, payload: data })
      end
    else
      response
    end
  end

  class UrlIsNotFeed < StandardError; end

  private

  def parse_response(xml)
    Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS).entries.sort_by(&:published).reverse
  end

  def verify_rss_url
    Feedbag.feed? @rss_url
  end

  def format_response(response)
    results = []
    response.each do |e|
      result = { 'audio_url': e.enclosure_url,
                 'external_id': e.entry_id,
                 'published_at': e.published,
                 'title': e.title,
               }
      next if result.values.include?(nil)

      results << result
    end
    results
  end
end
