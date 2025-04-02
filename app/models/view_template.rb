# == Schema Information
#
# Table name: view_templates
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ViewTemplate < ApplicationRecord
  has_many_attached :images
  has_many :daily_views

  validates :name, uniqueness: true, presence: true
end
