class AddAnswersToExams < ActiveRecord::Migration
  def change
    add_column :exams, :answers, :text
  end
end
