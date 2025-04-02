# == Schema Information
#
# Table name: base_templates
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class BaseTemplate < ApplicationRecord
  has_many :daily_views
  has_many_attached :images

  validates :name, uniqueness: true, presence: true
end
