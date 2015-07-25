class Scraper
  class << self

    def get_exam
      session = set_session
      set_exam_data session
      questions = get_questions session

      get_images questions
      questions
    end

    private

    def set_session
      response = HTTParty.get 'https://sedeapl.dgt.gob.es/WEB_EXAM_AUTO/service/TiposExamenesServlet'
      response.headers['set-cookie'].split('; ').first
    end

    def set_exam_data cookie
      HTTParty.post 'https://sedeapl.dgt.gob.es/WEB_EXAM_AUTO/service/VerificarExamenServlet',
        headers: {
          'Cookie' => cookie,
        },
        body: { tipoCuest: 'B', idioma: '1' }
    end

    def get_questions session
      HTTParty.get 'https://sedeapl.dgt.gob.es/WEB_EXAM_AUTO/service/RecuperarAspiranteServlet',
        headers: {'Cookie' => session}
    end

    def get_images questions
      questions['cuestionario']['preguntas'].each do |question|
        ExamImage.process question['urlImagen']
      end
    end

  end
end
