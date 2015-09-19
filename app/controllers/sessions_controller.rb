class SessionsController < ApplicationController

  def create
    @session = Session.create
    render json: { id: @session.id}
  end

  def end
    @session = Session.find_by(id: params[:session_id], end_time: nil).update(end_time: DateTime.now)
    render nothing: true
  end

end