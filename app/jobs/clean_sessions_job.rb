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

job = Sidekiq::Cron::Job.find('Clean Sessions every 30min')
job.destroy if job
Sidekiq::Cron::Job.create( name: 'Clean Sessions every 30min',
                           cron: '* */10 * * *', 
                           klass: 'CleanSessionsJob')
