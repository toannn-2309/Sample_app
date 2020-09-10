class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content image).freeze

  belongs_to :user
  has_one_attached :image

  validates :user_id, :content, presence: true
  validates :content, length: {maximum: Settings.post.length}
  validates :image, content_type: {in: Settings.post.file_image,
                                   message: I18n.t("post.noti.format_post")},
                  size: {less_than: Settings.post.size.megabytes,
                         message: I18n.t("post.noti.size_post")}

  delegate :name, to: :user, prefix: true

  scope :order_post, ->{order created_at: :desc}

  def display_image
    image.variant resize_to_limit: [Settings.post.m_size, Settings.post.m_size]
  end
end
