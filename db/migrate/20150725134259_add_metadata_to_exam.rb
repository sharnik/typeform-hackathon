class AddMetadataToExam < ActiveRecord::Migration
  def change
    add_column :exams, :metadata, :text
  end
end
