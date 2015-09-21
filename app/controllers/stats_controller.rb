class StatsController < ApplicationController
  # Useful if you need to convert time into string in controller
  include ActionView::Helpers::DateHelper

  def feelings_today
    @sessions = Feeling.where('created_at >= ?', 24.hours.ago).count
    render json: { count: @sessions}
  end

  def stats
    periods = ['day', 'week', 'month']
    @stats = periods.inject([]) do |memo, period|
      memo << get_stats(period)
    end
  end

  private

  def get_stats(period)
    sessions = Session.where('created_at >= ?', Time.zone.now.send("#{period}s_ago",1))
                      .where.not(end_time: nil)
    feelings = Feeling.joins(:session).where('sessions.created_at >= ?', Time.zone.now.send("#{period}s_ago",1))
                      .where.not(sessions: {end_time: nil}).count
    
    # session stats
    s_count = sessions.count
    s_time =  sessions.sum('extract(epoch from end_time - created_at)').to_i
    # s_average = distance_of_time_in_words(s_time / s_count)
    s_time = distance_of_time_in_words(s_time)

    # feeling stats
    f_count = feelings

    results = { text: text_helper(period),
                s_count: s_count, 
                s_time: s_time, 
                # s_average: s_average,
                f_count: f_count,
                # f_average: f_count / s_count 
              }
  end

  def text_helper(period)
    if period == "day"
      result = "In the past 24 hours"
    elsif period == "week"
      result = "In the past 7 days"
    elsif period == "month"
      result = "In the past 30 days"
    end
    result
  end

end