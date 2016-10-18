module Entities
  class Work < Grape::Entity
    expose :id, :content, :style, :comment_count,:start_time, :end_time
    expose :teacher,   :students,  using: ::Entities::SimpleUser
    expose :grade_team_classes,    using: ::Entities::GradeTeamClass
    expose :articles,              using: ::Entities::SimpleArticle
    expose :work_attachments,      using: ::Entities::Attachment
  end

  class HashWork < Grape::Entity
    expose (:time) { |object| object[0] }
    expose (:size) { |object| object[1].size}
    expose :records, using: Entities::Record do |object|
        object[1]
      end
  end
end
