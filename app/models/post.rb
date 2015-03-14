# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  author_id  :integer          not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates_presence_of :title, :author_id, :subs

  has_many :post_subs, dependent: :destroy, inverse_of: :post
  has_many :subs, through: :post_subs, inverse_of: :posts

  belongs_to(
    :author,
    foreign_key: :author_id,
    class_name: :User,
    inverse_of: :posts
  )

  has_many :comments, inverse_of: :post, dependent: :destroy

  def comments_by_parent_id
    @cpid = Hash.new { |h,k| h[k] = [] }
    comments.each do |comment|
      @cpid[comment.parent_id] << comment
    end
    @cpid
  end
end
