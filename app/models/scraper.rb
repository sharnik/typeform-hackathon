require 'httparty'

class Scraper
  class << self

    def get_exam
      session = set_session
      set_exam_data session
      get_questions session
    end

    private

    def set_session
      response = HTTParty.get 'https://sedeapl.dgt.gob.es/WEB_EXAM_AUTO/service/TiposExamenesServlet'
      response.headers['set-cookie'].split('; ').first
    end

    def set_exam_data cookie
      response = HTTParty.post 'https://sedeapl.dgt.gob.es/WEB_EXAM_AUTO/service/VerificarExamenServlet',
        headers: {
          'Cookie' => cookie,
          'Accept' => 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
        },
        body: { tipoCuest: 'B', idioma: '1' }
      puts "\n\n\nSetting exam data:"
      p response
    end

    def get_questions session
      questions = HTTParty.get 'https://sedeapl.dgt.gob.es/WEB_EXAM_AUTO/service/RecuperarAspiranteServlet',
        headers: {'Cookie' => session}
      puts "\n\n\nGetting questions:"
      p questions
    end

  end
end
