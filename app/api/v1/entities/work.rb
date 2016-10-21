module Entities
  class Work < Grape::Entity
    expose :id, :content, :style, :comments_count,:start_time, :end_time
    expose :user,   :students,     using: ::Entities::User
    expose :grade_team_classes,    using: ::Entities::GradeTeamClass
    expose :articles,              using: ::Entities::SimpleArticle
    expose :work_attachments,      using: ::Entities::Attachment
  end

  class SimpleWork < Grape::Entity
    expose :id, :content, :style, :comments_count,:start_time, :end_time
    expose :articles,              using: ::Entities::SimpleArticle
    expose :work_attachments,      using: ::Entities::Attachment
  end

  class FuckWork < Work
    unexpose :articles,  :work_attachments,  :grade_team_classes
  end
  class HashWork < Grape::Entity
    expose (:time) { |object| object[0] }
    expose (:size) { |object| object[1].size}
    expose :works, using: Entities::SimpleWork do |object|
        object[1]
      end
  end
end
