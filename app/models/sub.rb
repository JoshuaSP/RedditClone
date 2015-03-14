# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  moderator_id :integer          not null
#  name         :string           not null
#  description  :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates_presence_of :moderator_id, :name
  validates_uniqueness_of :name

  belongs_to(
    :moderator,
    class_name: :User,
    foreign_key: :moderator_id,
    primary_key: :id,
    inverse_of: :subs
  )

  has_many :post_subs, dependent: :destroy, inverse_of: :sub
  has_many :posts, through: :post_subs, inverse_of: :subs
end
