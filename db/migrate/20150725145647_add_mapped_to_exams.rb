class AddMappedToExams < ActiveRecord::Migration
  def change
    add_column :exams, :mapped, :text
  end
end
