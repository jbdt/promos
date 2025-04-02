class AddViewsCountToDailyViews < ActiveRecord::Migration[6.0]
  def change
    add_column :daily_views, :views_count, :integer, default: 0
  end
end
