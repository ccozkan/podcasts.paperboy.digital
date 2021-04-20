FactoryBot.define do
  factory :episode do
    audio_url { "https://url_of_episode_audio.mp3" }
    title { "Cool Episode" }
    summary { "Stuff covered on this cool episode" }
    external_id { 'abc123' }
    published_at { Time.current - 3.day }
  end
end
