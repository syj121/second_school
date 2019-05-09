class CreateUserImages < ActiveRecord::Migration[5.2]
  def change
    create_table :user_images do |t|
      t.references :user, foreign_key: true
      t.string :image_url, comment: "用户图片地址"
      t.string :image_type, comment: "用户图片分类，如：head_portrait头像"
      t.boolean :usable, default: true, comment: "是否正在使用"
      t.timestamps
    end
  end
end
