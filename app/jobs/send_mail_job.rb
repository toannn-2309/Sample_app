class SendMailJob < ApplicationJob
  queue_as :default

  # retry_on ActiveRecord::RecordInvalid
  # retry_on ActiveRecord::RecordInvalid, wait: 5.seconds, attempts: 3

  def perform user
    @user = user
    user.send_activation_email
    raise ActiveRecord::RecordInvalid
  end
end







# class SendMailJob < ApplicationJob
  # queue_as :default

  # before_enqueue :call_back
  # after_perform :call_back

  # discard_on ActiveRecord::RecordInvalid

  # retry_on ActiveRecord::RecordInvalid

  # retry_on ActiveRecord::RecordInvalid, wait: 5.seconds, attempts: 3

  # def perform user
  #   ActiveRecord::Base.transaction do
  #     @user = user
  #     @user.send_activation_email
  #     raise ActiveRecord::RecordInvalid
  #   end

  # rescue ActiveRecord::RecordInvalid
  #   puts "loi roi do"
  # end

  # private

  # def call_back
  #   byebug
  # end
# end


# class SendMailJob < ApplicationJob
#   queue_as :default

#   retry_on ActiveRecord::RecordInvalid

#   def perform user
#     @user = user
#     @user.send_activation_email
#     raise ActiveRecord::RecordInvalid
#   end
# end
