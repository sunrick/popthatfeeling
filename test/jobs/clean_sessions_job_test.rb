require 'test_helper'

class CleanSessionsJobTest < ActiveJob::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'delete an old session with feelings' do
    session = Session.create(created_at: 8.minutes.ago)
    feeling = Feeling.create( session_id: session.id, created_at: 7.minutes.ago )
    CleanSessionsJob.perform_now
    assert Session.find(session.id).end_time == feeling.created_at
  end

  test 'delete an empty session that is older than 6 minutes' do
    session_old = Session.create(created_at: 8.minutes.ago)
    session_new = Session.create(created_at: 3.minutes.ago)
    CleanSessionsJob.perform_now
    refute Session.find_by(id: session_old.id)
    assert Session.find(session_new.id)
  end
end
