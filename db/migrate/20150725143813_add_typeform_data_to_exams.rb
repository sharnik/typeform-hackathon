class AddTypeformDataToExams < ActiveRecord::Migration
  def change
    add_column :exams, :typeform_data, :text
  end
end
