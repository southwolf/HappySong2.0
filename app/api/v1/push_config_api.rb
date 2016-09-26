module V1
  class PushConfigAPi < Grape::API
    namspace :push_config do
      desc "关闭接受指定消息"
      params do
        requires :token,  type: String, desc: "用户登录令牌"
        requires :notify, type: Integer, desc: "消息类型自己传ID [新粉丝: 1, 评论: 2, 喜欢: 3]"
      end
      post '/colse' do
        authenticate!
        notify = params[:notify]
        case notify
        when 1
          current_user.add_push_action(PushAction.find_by(action: 'follow'))
        when 2
          current_user.add_push_action(PushAction.find_by(action:'comment'),PushAction.find_by(action: 'reply'))
        when 3
          current_user.add_push_action(PushAction.find_by(action:'like'))
        end

        present :message, "更新成功"
      end


      desc "检查是否关闭指定消息"
      params do
        requires :token,  type: String, desc: "用户登录令牌"
      end
      post '/check' do
        authenticate!
        result = {
          follow: false,
          comment: false,
          like: false
        }
        if current_user.push_actions.present?
          current_user.push_actions.each do |push_action|
            puts push_action.action
            case push_action.action
            when "follow"
              result.merge!({follow:true})
            when "comment","reply"
              result.merge!({comment: true})
            when "like"
              result.merge!({comment: true})
            end
          end
        end
        present result
      end


      desc "开启接受指定消息"
      params do
        requires :token,  type: String, desc: "用户登录令牌"
        requires :notify, type: Integer, desc: "消息类型自己传ID [新粉丝: 1, 评论: 2, 喜欢: 3]"
      end
      post '/open' do
        authenticate!
        notify = params[:notify]
        case notify
        when 1
          current_user.remove_push_action(PushAction.find_by(action: 'follow'))
        when 2
          current_user.remove_push_action(PushAction.find_by(action:'comment'),PushAction.find_by(action: 'reply'))
        when 3
          current_user.remove_push_action(PushAction.find_by(action:'like'))
        end
      end
      present :message, "更新成功"

    end
  end
end
