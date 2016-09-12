module V1
  class TeamClassesApi < Grape::API
    resources :team_classes do
      desc "根据班级码查找对应班级"
      params do
        requires :code, type: String, desc: '班级码'
      end
      get do
        code = params[:code].to_s
        grade_team_class = GradeTeamClass.find_by(code: code)
        if grade_team_class.nil?
          error!("没有找到对应记录,请检查你的班级码是否输入正确", 404)
        else
         present  grade_team_class, with: ::Entities::GrapeTeamClass
        end
      end

      desc "查询所有班级【老师】"
      params do
        requires :token, type: String, desc: "访问令牌"
      end
      get '/all' do
        authenticate!
        grade_team_classes = current_user.grade_team_classes
        present grade_team_classes, with: ::Entities::GradeTeamClass
      end

      desc "查班级学生"
      params do
        requires :grade_team_class_id, type: Integer, desc: "班级Id"
      end
      get '/students' do
        grade_team_class_id = params[:grade_team_class_id]
        grade_team_class = GrapeTeamClass.find(grade_team_class_id)

        students = grade_team_class.students
        present students, with: ::Entities::User
      end

      desc "添加班级【老师】"
      params do
        requires :token,         type: String,  desc: '访问令牌'
        requires :school_id,     type: Integer, desc: '学校ID'
        requires :grade_id,      type: Integer, desc: '年级ID'
        requires :team_class_id, type: Integer, desc: '班级ID'
      end
      post '/add' do
        authenticate!
        school_id        = params[:school_id]
        grade_id         = params[:grade_id]
        team_class_id    = params[:team_class_id]
        grade_team_class = current_user.grade_team_classes.build(
                              school_id: school_id,
                              grade_id: grade_id,
                              team_class_id: team_class_id
                            )
        if grade_team_class.save!
          present grade_team_class, with: ::Entities::GradeTeamClass
        else
          if grade_team_class.errors.messages[:teacher_id].present?
            error!({ message: "班级已经存在"}, 403)
          else
            error!({message: "错误"}, 500)
          end
        end
      end

      desc "加入班级【学生】"
      params  do
        requires :token,               type: String,  desc: '访问token'
        requires :grade_team_class_id, type: Integer, desc: "年级班级ID"
      end

      post '/join' do
       authenticate!
       grade_team_class_id = params[:grade_team_class_id]
       if current_user.update(grade_team_class_id: grade_team_class_id)
         present :message, "加入班级成功！"
       else
         error!({ error: "失败"}, 500)
       end
      end
    end
  end
end
