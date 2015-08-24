class FeelingsController < ApplicationController

  def create
    if params[:text].downcase != "click me"
      Feeling.create(text: params[:text], session_id: params[:session_id])
    end
    render nothing: true
  end

end