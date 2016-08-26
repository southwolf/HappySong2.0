class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user
  #回复
  has_many   :replys, class_name: "Comment", foreign_key: 'root_id'
  belongs_to :root,   class_name: "Comment"
  has_many   :notifications, as: :targetable

  validates :content, presence: true
  
  after_commit :push_comment_notify

  def push_comment_notify
    Notification.create(
      :notification_type => 'Comment',
      :user_id => self.user.id,
      :targetable_id => self.commentable_id,
      :targetable_type => self.commentable_type
    )
  end

end
