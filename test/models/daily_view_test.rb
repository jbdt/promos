# == Schema Information
#
# Table name: daily_views
#
#  id               :bigint           not null, primary key
#  day              :date
#  views_count      :integer          default(0)
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
require "test_helper"

class DailyViewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
