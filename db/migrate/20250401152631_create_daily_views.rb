class CreateDailyViews < ActiveRecord::Migration[7.2]
  def change
    create_table :daily_views do |t|
      t.date :day
      t.references :view_template, null: false, foreign_key: true
      t.references :base_template, null: true, foreign_key: true

      t.timestamps
    end
  end
end
