class EpisodesRetrieverService
  def initialize(rss_url)
    @rss_url = rss_url
  end

  def call
    response = RequestMakerService.new(@rss_url).call

    if response.success?
      xml = response.payload.body
      episodes = Feedjira.parse(xml, parser: Feedjira::Parser::ITunesRSS)
                   .entries.sort_by(&:published).reverse!
      format_response(episodes)
    end
  end

  private

  def format_response(response)
    results = []
    response.each do |e|
      result = { 'audio_url': e.enclosure_url,
                 'external_id': e.entry_id,
                 'published_at': e.published,
                 'title': e.title,
                 'summary': e.summary
               }
      results << result
    end
    results
  end
end
