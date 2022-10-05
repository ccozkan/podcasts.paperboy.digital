require 'feedbag'
require 'feedjira'

class EpisodesReceiverService

  def initialize(rss_url)
    @rss_url = rss_url
  end

  def call
    response = RequestMakerService.new(@rss_url).call
    return response unless response.success?
    raise UrlIsNotFeed unless verify_rss_url

    data = handle_successfull_response(response)
  rescue StandardError => e
    OpenStruct.new({ success?: false, error: e })
  else
    OpenStruct.new({ success?: true, payload: data })
  end

  class UrlIsNotFeed < StandardError; end

  private

  def handle_successfull_response(response)
    xml = response.payload.body
    episodes = parse_response(xml)
    format_response(episodes)
  end

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
