require 'parser'

class CreateFormService

  ENDPOINT = 'https://api.typeform.io'

  def initialize(exam_id)
    @exam_id = exam_id
    @body = {}

    @typeform_attributes = Parser.new(@exam_id).generator
  end

  def post
    conn = Faraday.new(:url => ENDPOINT) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    res = conn.post do |req|
      req.url '/v0.3/forms'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-API-TOKEN'] = ENV['API_KEY']

      req.body = typeform_attributes.to_json
    end

    @body = JSON.parse(res.body)
  end

  def body
    @body
  end

  def url
    body["links"].detect{|x| x["rel"] == "form_render" }["href"]
  end

  def typeform_attributes
    @typeform_attributes
  end
end
