class Exam < ActiveRecord::Base
  CODES = %w{B LVA LCM A1 AM C D EC EB BTP BC CI CXI C7 BC-R}
  LNGS = %w{1 2 3 4 5 6}

  serialize :metadata, Hash
  serialize :answers, Array
  serialize :typeform_data, Hash
  serialize :mapped, Hash


  def magic!
    magic_hash = {}
    typeform_data["fields"].each do |field|
      question_id = field["id"]
      question = field["question"]
      choices = metadata[:fields].detect{|x| x[:question] == question}[:choices]
      valid_label = choices.detect{|x| x[:valid]}[:label]
      magic_hash[question_id] =  valid_label
    end

    self.mapped = magic_hash
  end


  def correct_answers
    right = 0
    answers.each do |answer|
      answer_id = answer[:field_id].to_i
      correct_label = mapped[answer_id]

      if answer[:data][:value][:label] == correct_label
        right += 1
      end
    end
    right
  end
end
