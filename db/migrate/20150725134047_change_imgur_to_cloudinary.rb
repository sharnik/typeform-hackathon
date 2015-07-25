class ChangeImgurToCloudinary < ActiveRecord::Migration
  def change
    rename_column :exam_images, :imgur_url, :storage_url
  end
end
