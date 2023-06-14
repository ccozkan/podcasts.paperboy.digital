class FeedPeekerWorker
  include Sidekiq::Worker

  def perform()
    sleep 5

    puts 'selams'
  end
end
