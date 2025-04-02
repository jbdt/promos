# == Schema Information
#
# Table name: daily_views
#
#  id               :bigint           not null, primary key
#  day              :date
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  base_template_id :bigint
#  view_template_id :bigint           not null
#
# Indexes
#
#  index_daily_views_on_base_template_id  (base_template_id)
#  index_daily_views_on_view_template_id  (view_template_id)
#
# Foreign Keys
#
#  fk_rails_...  (base_template_id => base_templates.id)
#  fk_rails_...  (view_template_id => view_templates.id)
#
class DailyView < ApplicationRecord
  belongs_to :view_template
  belongs_to :base_template

  validates :day, presence: true
end
