class Nation < ApplicationRecord

  enum tag: { province: 1, city: 2, country: 3 }

  # scopes
  scope :cities, -> { where(tag: tags[:city]) }
  scope :counties, -> { where(tag: tags[:country]) }

  # associations
  belongs_to :parent, class_name: 'Nation', foreign_key: :parent_id
  has_many :children, class_name: 'Nation', foreign_key: :parent_id
  has_many :schools, class_name: 'Org::School', foreign_key: :nation_id

  # instance methods
  # def fullname
  #   return name if  self.province?
  #   return (parent.name + name) if self.city?
  #   return (parent.parent.name + parent.name + name) if self.country?
  # end

  # 用在显示学校名称的时候使用
  def name_with_city
    (parent.name + name) if self.country?
  end
end
