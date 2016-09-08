module Entities
  class User < Grape::Entity
    expose :id, :uid, :phone, :code, :auth_token
    # expose (:vip) {|object| object.vip? }
    expose (:avatar) { |object| ENV['QINIUPREFIX']+object.avatar}
    expose (:vip) { |object| object.vip?}
    expose (:bg_image) { |object| ENV['QINIUPREFIX']+object.bg_image_url}
    expose(:name) do |object|
      if object.name.blank?
        ""
      else
        object.name
      end
    end
    expose(:age) do |object|
      if object.age.blank?
        ""
      else
        object.age
      end
    end
    expose(:desc) do |object|
      if object.desc.blank?
        ""
      else
        object.desc
      end
    end

    expose(:sex) do |object|
      if object.sex.blank?
        ""
      else
        object.sex
      end
    end
    expose :role, using: ::Entities::Role

    expose (:points) do |object|
      0
    end
    expose (:school_full_name) do |object, options|
      school   = object.grade_team_classes.first.try(:school)
      district = school.try(:district)
      city     = district.try(:city)

      if school.present? && district.present? && city.present?
        "#{city.try(:name)}#{district.try(:name)}#{school.try(:name)}"
      else
        ""
      end
    end
    expose :url
    def url
      "http://host/users/show/#{object.id}"
    end
    expose :invite_url do |object|
      "http://120.26.118.28/invites?code=#{object.code}"
    end
  end

  class SimpleUser < Grape::Entity
    expose :id, :uid,:phone, :name
  end

  class MyProfile < Grape::Entity
    expose :id, :uid, :phone, :name, :sex, :age, :desc
    expose (:vip) { |object| object.vip?}
    # expose (:children), using: Entities::User, if: -> (parent, options){ parent.role.try(:name) == "parent"}

    # expose (:parent),   using: Entities::User, if: -> (child, options) { child.role.try(:name) == "student" }

    expose (:bg_image) { |object| ENV['QINIUPREFIX']+object.bg_image_url}

    expose (:points) do |object|
      0
    end

    expose (:grade_team_classes) do |user|
      grade_team_class = user.try(:grade_team_class)
      if grade_team_class.present?
        grade = grade_team_class.try(:grade).try(:name)
        team_class = grade_team_class.try(:team_class).try(:name)
      "#{grade}#{team_class}"
      else
       " "
      end
    end
    expose :expire_time, if: ->(object, options){ object.member.present?} do |object|
      object.member.expire_time.to_i
    end
    expose :invite_url do |object|
      "http://120.26.118.28/invites?code=#{object.code}"
    end

    expose(:avatar) { |user| ENV['QINIUPREFIX']+user.avatar}
    expose (:followers_count)  { |user| user.followers.size }
    expose (:followings_count) { |user| user.followings.size }
    expose (:classmates_count) { |user| user.classmates.size}
  end
  class HashUser < Grape::Entity
    expose (:time) { |object| object[0]}
    expose (:size) { |object| object[1].size}
    expose :users, using: Entities::User do |object|
      object[1]
    end
  end
end
