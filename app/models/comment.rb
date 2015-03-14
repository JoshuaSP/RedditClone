# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  parent_id  :integer
#  post_id    :integer          not null
#  author_id  :integer          not null
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base
  validates :post_id, :author_id, :content, presence: true
  validate :is_child_of_correct_post
  after_initialize :set_post

  belongs_to :post, inverse_of: :comments
  belongs_to(
    :author,
    class_name: :User,
    foreign_key: :author_id
  )
  belongs_to(
    :parent_comment,
    class_name: :Comment,
    foreign_key: :parent_id
  )
  has_many(
    :child_comments,
    class_name: :Comment,
    foreign_key: :parent_id
  )

  def is_child_of_correct_post
    parent_comment.nil? || post == parent_comment.post
  end

  def set_post
    if parent_comment
      self.post_id = parent_comment.post_id
    end
  end
end
