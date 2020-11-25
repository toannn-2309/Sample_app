module API
  module V1
    class Microposts < Grape::API
      include API::V1::Defaults

      before{authenticate_user!}

      prefix "api"
      version "v1", using: :path
      format :json

      resource :microposts do
        desc "Return all micropost for user"
        get "", root: :microposts do
          microposts = @current_user.microposts
          present microposts
        end

        desc "User create micropost"
        params do
          requires :content, type: String, desc: "Content of the micropost"
        end
        post do
          if params[:content].present?
            micropost = @current_user.microposts.build content: params[:content]
            present micropost if micropost.save!
          else
            error!("Content can't be blank", 400)
          end
        end
      end

      resource :microposts do # Metrics/BlockLength: Block has too many lines.
        desc "User destroy micropost"
        params do
          requires :id, type: String, desc: "ID of the micropost"
        end
        delete ":id" do
          micropost = @current_user.microposts.find_by id: params[:id]
          if micropost.present?
            present @current_user.microposts if micropost.destroy
          else
            error!("Micropost does not exist", 404)
          end
        end
      end
    end
  end
end
