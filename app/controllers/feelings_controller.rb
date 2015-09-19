class FeelingsController < ApplicationController

  def create
    session = Session.find(params[:session_id])
    session_finished = !session.end_time.nil?
    last_feeling = session.feelings.last

    if session_finished || (session.created_at < 5.minutes.ago && last_feeling.nil?)
      if !session_finished
        session.destroy
      end
      @session = Session.create.id
      Feeling.create(text: params[:text], session_id: params[:session_id])
    elsif last_feeling.nil? || last_feeling.created_at > 5.minutes.ago
      Feeling.create(text: params[:text], session_id: params[:session_id])
      @session = params[:session_id].to_i
    else
      session.update(end_time: last_feeling.created_at)
      @session = Session.create.id
      Feeling.create(text: params[:text], session_id: @session)
    end
    render json: { id: @session }
  end

end



