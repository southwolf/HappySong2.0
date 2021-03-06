# authenticate 老师登录 | 传入 work_id
module NewApi
  module V1
    class Classes::UnfinishedStudentsController < Classes::BaseController

      before_action :authenticate # 老师必须登录

      def index
        load_class
        load_work
        student_works = @home_work.student_works.includes(:student).where(student_id: @class.students.pluck(:id)).unfinished
        render json:
          student_works, status: 200, root: 'students', adapter: :json
      end

      private
      def load_work
        @home_work = HomeWork.find_by(id: params[:work_id])
        raise HomeWorkNotFound unless @home_work
      end
    end
  end
end
