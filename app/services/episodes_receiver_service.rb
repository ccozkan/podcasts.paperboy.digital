require "feedbag"
require "feedjira"

class EpisodesReceiverService
  class UrlIsNotFeed < StandardError; end

  def initialize(rss_url)
    @rss_url = rss_url
  end

  def call
    response = RequestMakerService.new(@rss_url).call
    return response unless response.success?

    raise UrlIsNotFeed unless verify_rss_url

    result = handle_successfull_response(response)
  rescue StandardError => e
    ServiceResponse.new(error: e)
  else
    ServiceResponse.new(payload: result)
  end

  private

    def handle_successfull_response(response)
      xml = response.payload.body
      episodes = parse_xml(xml)
      format_episodes(episodes)
    end

    def parse_xml(xml)
      Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS).entries.sort_by(&:published).reverse
    end

    def verify_rss_url
      Feedbag.feed? @rss_url
    end

    def format_episodes(episodes)
      results = []
      episodes.each do |e|
        result = { 'audio_url': e.enclosure_url,
                   'external_id': e.entry_id,
                   'published_at': e.published,
                   'duration': format_duration(e.itunes_duration),
                   'title': e.title,
                   'summary': e.summary,
                 }
        next unless valid?(result)

        results << result
      end
      results
    end

    def valid?(hash)
      return false if hash.except(:duration, :summary).value? nil

      true
    end

    def format_duration(duration)
      unless duration&.include?(":")
        t = duration.to_i
        Time.at(t).utc.strftime("%H:%M:%S")
      end
    end
end
