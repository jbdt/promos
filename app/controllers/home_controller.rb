class HomeController < ApplicationController
  def index
    daily_view = DailyView.find_by(day: Date.today)

    daily_view.try(:increment_views_for_today)

    @view_template = daily_view.try(:view_template)
    @base_template = daily_view.try(:base_template)
  end

  def daily_view_preview
    daily_view = DailyView.find_by(id: params[:id])

    @view_template = daily_view.view_template
    @base_template = daily_view.base_template

    render :index
  end

  def view_template_preview
    @view_template = ViewTemplate.find_by(id: params[:id])

    render :index
  end

  def base_template_preview
    @base_template = BaseTemplate.find_by(id: params[:id])

    render :index
  end
end
