class FeelingsController < ApplicationController

  def create
    if params[:text].downcase != "click me"
      Feeling.create(text: params[:text])
      render nothing: true
    else
      render nothing: true
    end
  end

end