# frozen_string_literal: true

class FeedSearcherService
  def initialize(query)
    @query = ActiveSupport::Inflector.transliterate(query)
  end

  def call
    url = "https://itunes.apple.com/search?term=#{@query}&entity=podcast"
    response = RequestMakerService.new(url).call
    format_response(response.payload) if response.success?
  end

  private

  def format_response(response)
    results = []
    response = JSON.parse(response)
    response['results'].each do |r|
      result = { 'rss_url': r['feedUrl'],
                 'pic_url': r['artworkUrl600'],
                 'provider': r['artistName'],
                 'name': r['trackName'],
                 'external_id': r['collectionId'].to_s,
                 'genres': r['genres'].delete('Podcasts') && r['genres'].join(' ~ '),
                 'release_date': r['releaseDate'].split('T').first
                 }
      results << result
    end
    results
  end
end
