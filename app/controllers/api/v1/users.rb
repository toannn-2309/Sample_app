module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      before{authenticate_user!}

      prefix "api"
      version "v1", using: :path # chi ding version cua API
      format :json # chi su dung dinh dang JSON

      resource :users do # su dung user routes
        desc "Return all users"
        get "", root: :users do # GET  |  /api/:version/users(.json)
          present User.all, with: API::Entities::User
        end

        desc "Return a user"
        params{requires :id, type: String, desc: "ID of the user"}
        get ":id", root: "user" do # GET  |  /api/:version/users/:id(.json)
          user = User.find params[:id]
          present user, with: API::Entities::User
        end
      end
    end
  end
end
