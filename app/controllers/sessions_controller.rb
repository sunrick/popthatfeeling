class SessionsController < ApplicationController

  def create
    @session = Session.create
    render json: { id: @session.id}
  end

  def end
    @session = Session.find(params[:session_id]).update(end_time: DateTime.now)
    render nothing: true
  end

end