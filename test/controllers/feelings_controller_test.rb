class FeelingsControllerTest < ActionController::TestCase

  # create method

  test "should delete session if no feelings and older than 5 minutes, and create new session" do
    post :create, session_id: sessions(:session_six_min).id
    assert_nil Session.find_by(id: sessions(:session_six_min).id)
    body = JSON.parse(response.body)
    assert_not_equal sessions(:session_six_min).id, body["id"]
  end

  test "should return a different id if session has already been finished" do
     post :create, session_id: sessions(:session_finished).id
     body = JSON.parse(response.body)
     assert_not_equal sessions(:session_finished).id, body["id"]
  end

  test "a session with no feelings and less than five minutes old should get new feeling" do
    post :create, session_id: sessions(:session_new_no_feelings).id
    body = JSON.parse(response.body)
    assert_equal sessions(:session_new_no_feelings).id, body["id"]
    assert_equal 1, sessions(:session_new_no_feelings).feelings.count
  end

  test "a session with no end_time and a feeling created in the past 5 minutes should add feeling" do
    post :create, session_id: sessions(:session_tired).id
    body = JSON.parse(response.body)
    assert_equal sessions(:session_tired).id, body["id"]
    assert_equal 2, sessions(:session_tired).feelings.count
  end

  test "a session with no end_time and the last feeling being older than 5 minutes should create new session and end other session" do
    post :create, session_id: sessions(:session_old_tired).id
    body = JSON.parse(response.body)
    assert_not_equal sessions(:session_old_tired).id, body["id"]
    assert_not_nil Session.find(sessions(:session_old_tired).id).end_time
    assert_equal 1, sessions(:session_old_tired).feelings.count
  end


end