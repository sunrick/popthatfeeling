class SessionsController < ApplicationController

  def create
    @session = Session.create
    render json: { id: @session.id}
  end

  def end
    @session = Session.find_by(id: params[:session_id], end_time: nil)
    @feeling = @session.feelings.last
    if @feeling.nil?
      @session.destroy
    else
      @session.update(end_time: @feeling.created_at)
    end
    render nothing: true
  end

end