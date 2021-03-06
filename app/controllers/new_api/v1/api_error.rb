# 1xxx: Authentication errors
# 2xxx: HTTP params validation errors
# 3xxx: Authorization errors
# 4xxx: Domain errors
# 9xxx: Other errors

module NewApi
  module V1
    class ApiError < StandardError
      attr :code, :text, :status

      def initialize(opts = {})
        @code = opts.fetch(:code, 2000)
        @text = opts.fetch(:text, '')
        @status = opts.fetch(:status, 400)
      end
    end

    class MissingAuthTokenError < ApiError
      def initialize
        super code: 1001, text: 'Authentication token is required', status: 401
      end
    end

    class RecordNotFound < ApiError
      def initialize
        super code: 1101, text: "Record not found.", status: 404
      end
    end

    class NationNotFound < ApiError
      def initialize
        super code: 1102, text: "Nation not found.", status: 404
      end
    end

    class SchoolNotFound < ApiError
      def initialize
        super code: 1103, text: "School not found.", status: 404
      end
    end

    class ClassNotFound < ApiError
      def initialize
        super code: 1104, text: "Class not found.", status: 404
      end
    end

    class TeacherNotFound < ApiError
      def initialize
        super code: 1105, text: "Teacher not found.", status: 404
      end
    end

    class StudentNotFound < ApiError
      def initialize
        super code: 1106, text: "Student not found.", status: 404
      end
    end

    class HomeWorkNotFound < ApiError
      def initialize
        super code: 1107, text: "HomeWork not found.", status: 404
      end
    end

    class StudentWorkNotFound < ApiError
      def initialize
        super code: 1108, text: "StudentWork not found", status: 404
      end
    end

    class MissingClassCodeError < ApiError
      def initialize
        super code: 1201, text: 'Missing Class Code', status: 400
      end
    end

    class RecordNotCreate < ApiError
      def initialize
        super code: 2001, text: 'Record Created Error', status: 400
      end
    end

    class RecordWorkNotCreate < ApiError
      def initialize
        super code: 2002, text: 'RecordWork Created Error, check article_ids & class_ids', status: 400
      end
    end

    class DynamicWorkNotCreate < ApiError
      def initialize
        super code: 2003, text: 'DynamicWork Created Error, check files & class_ids', status: 400
      end
    end

    class DoDynamicWorkNotCreate < ApiError
      def initialize
        super code: 2004, text: 'DoDynamicWork Created Error, check params', status: 400
      end
    end

    class DoRecordWorkNotCreate < ApiError
      def initialize
        super code: 2005, text: 'DoRecordWork Created Error, check params', status: 400
      end
    end

    class InvalidTeacherAuthorizationError < ApiError
      def initialize
        super code: 3001, text: "Teacher Authorization error.", status: 401
      end
    end

    class StudentWorkHasBeenUploaded < ApiError
      def initialize
        super code: 5001, text: "Student Work Has Been Uploaded.", status: 400
      end
    end
  end
end
