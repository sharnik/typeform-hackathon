require 'parser'

class CreateFormService

  ENDPOINT = 'https://api.typeform.io'

  def initialize
    @typeform_hash = {}
    @raw_hash = JSON.parse(json)
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

    json = JSON.parse(res.body)

    json["links"].detect{|x| x["rel"] == "form_render" }["href"]
  end

  def typeform_attributes
    Parser.new.generator
  end

  def example
    File.open('good_typeform.json').read
  end

  def prepare
    @typeform_hash[:title] = "Examen tipo..."
  end

  def json
    File.open('dgt.json').read
  end
end
