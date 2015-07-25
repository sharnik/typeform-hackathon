class CreateImages < ActiveRecord::Migration
  def change
    create_table :exam_images do |t|
      t.string :dgt_url, index: true
      t.string :imgur_url
    end
  end
end
