class StatsController < ApplicationController

  def current_sessions
    @sessions = Session.where(end_time: nil).count
    render json: { count: @sessions}
  end

  def total_sessions
    @sessions = Session.count
    render json: { count: @sessions}
  end

  def sessions_today
    @sessions = Session.where('created_at >= ?', Time.zone.now.beginning_of_day).count
    render json: { count: @sessions}
  end

  def sessions_month
    @sessions = Session.where('created_at >= ?', Time.zone.now.send.beginning_of_month).count
    render json: { count: @sessions}
  end

  def sessions_year
    @sessions = Session.where('created_at >= ?', Time.zone.now.send.beginning_of_year).count
    render json: { count: @sessions}
  end

  def total_feelings
    @feelings = Feeling.count
    render json: { count: @sessions}
  end

  def feelings_today
    @sessions = Feeling.where('created_at >= ?', Time.zone.now.beginning_of_day).count
    render json: { count: @sessions}
  end

  def feelings_month
    @sessions = Feeling.where('created_at >= ?', Time.zone.now.send.beginning_of_month).count
    render json: { count: @sessions}
  end

  def feelings_year
    @sessions = Feeling.where('created_at >= ?', Time.zone.now.send.beginning_of_year).count
    render json: { count: @sessions}
  end

end