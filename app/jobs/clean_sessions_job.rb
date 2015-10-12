class CleanSessionsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    sessions = Session.where(end_time: nil).where('created_at < ?', 6.minutes.ago)
    sessions.each do |session|
      feeling = session.feelings.last
      if feeling.nil?
        session.destroy
      elsif feeling.created_at < 6.minutes.ago
        session.update(end_time: feeling.created_at)
      end
    end
  end
end
