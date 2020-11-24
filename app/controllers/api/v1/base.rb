module API
  module V1
    class Base < Grape::API
      mount V1::Users # Khai bao duong dan
      mount V1::Auth
      mount V1::Microposts
      # mount API::V1::AnotherResource
    end
  end
end
