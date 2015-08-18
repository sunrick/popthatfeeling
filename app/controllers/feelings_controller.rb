class FeelingsController < ApplicationController

  def create
    Feeling.create(text: params[:text])
    render nothing: true
  end
end