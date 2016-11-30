class Teacher < User

  # associations
  has_many :classes, class_name: 'Org::Class', foreign_key: :teacher_id

  # instance methods
  def dismiss_class(class_name) # 解散班级
  end


end
