class Parser
  def initialize(exam_id, code = nil, language = nil)
    @exam_id = exam_id
    @code = code
    @language = language
  end

  def generator
    hash = {}

    hash[:title] = "Exam kind: #{code}"
    hash[:webhook_submit_url] = "#{ENV['HOST']}/results/?exam_id=#{@exam_id}"
    hash[:fields] = []
    raw_questions.each do |r_question|
      img_url = ExamImage.find_by(dgt_url: r_question["urlImagen"]).try(:storage_url)
      t_question = {
        type: "multiple_choice",
        question: r_question["enunciado"],
        choices: []
      }

      if img_url.present?
        t_question[:description] = "![Image](#{img_url.gsub("http:", "")})"
      end


      r_question["respuestas"].each do |r_label|
        t_question[:choices] << {label: r_label["contenido"], valid: r_label["correcta"]}
      end

      hash[:fields] << t_question
    end
    hash
  end

  def save_typeform
    f = File.new('typeform.json', 'a')
    f.write generator.to_json
    f.close
  end


  def raw_questions
    raw["cuestionario"]["preguntas"]
  end

  def code
    raw["cuestionario"]["codTipoCuest"]
  end

  def raw
    @raw ||= JSON.parse(Scraper.get_exam(@code, @language).body)
  end
end
