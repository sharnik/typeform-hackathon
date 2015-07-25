class Parser
  def initialize
    @filename = 'dgt.json'
  end

  def generator
    hash = {}

    hash[:title] = "Exam kind: #{code}"
    hash[:fields] = []
    raw_questions.each do |r_question|
      t_question = {
        type: "multiple_choice",
        question: r_question["enunciado"],
        choices: []
      }

      r_question["respuestas"].each do |r_label|
        t_question[:choices] << {label: r_label["contenido"]}
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
    @raw ||= JSON.parse(Scraper.get_exam.body)
  end

  def raw_file
    @raw_file ||= File.open(@filename).read
  end
end