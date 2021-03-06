# 作业 属于 老师 （某个具体的作业由老师布置）
# 作业 -> 布置给多个班级
# 作业 -> 包含多个文章
class HomeWork < ApplicationRecord

  # validation
  validates :teacher_id, presence: true

  # associations
  belongs_to :teacher

  has_many :class_works, foreign_key: :work_id, class_name: 'ClassWork', dependent: :destroy
  has_many :classes, through: :class_works, source: 'org_class'

  has_many :article_works, foreign_key: :work_id, class_name: 'ArticleWork', dependent: :destroy
  has_many :articles, through: :article_works

  has_one :notification, as: :targetable, class_name: 'NewNotification'
  has_many :student_works, foreign_key: :work_id, class_name: 'StudentWork'

  # delegate
  delegate :name, :desc, :avatar, to: :teacher, prefix: :teacher, allow_nil: true # teacher_name

  def state(user = User.current)
    state = student_works.find_by(student_id: user.id).state
  end

  def title
    articles.first.try(:title)
  end
end
