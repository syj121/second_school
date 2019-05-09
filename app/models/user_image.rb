class UserImage < ApplicationRecord
  belongs_to :user
  #文件
  mount_uploader :image_url, ImageUploader

end
