class Invite < ActiveRecord::Base

  belongs_to :target_invite_users, class_name: 'User', foreign_key: 'target_user_id'
  belongs_to :invite_user, class_name: 'User', foreign_key: 'user_id'

  after_commit :inset_data, only: [:create]

  def inset_data
    if self.user.try(:role).try(:name) == 'teacher'
      #如果推荐人是教师则给老师的返现记录添加一条但是金额为0,仅仅为了客户端显示
      self.user.cash_managers.create(target_user: self.target_user)
    elsif self.user.try(:role).try(:name) == 'parent'
      self.user.credit_managers.create(target_user: self.target_user)
    end

  end

end
