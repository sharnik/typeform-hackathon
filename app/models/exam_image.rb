require 'imgur'

class ExamImage < ActiveRecord::Base
  validates :dgt_url, :imgur_url, presence: true

  def self.process url
    image = find_by dgt_url: url
    return true if image

    image = new dgt_url: url
    image.download_to_temp
    image.upload_to_imgur
    image.save
  end

  def download_to_temp
    File.open("my_file.jpg", "wb") do |f|
      f.write HTTParty.get(dgt_full_url dgt_url).parsed_response
    end
  end

  def upload_to_imgur
    client = Imgur.new client_id
    image = Imgur::LocalImage.new 'my_file.jpg', title: 'foo'
    p image
    uploaded = client.upload image
    p uploaded
    self.imgur_url = uploaded.link
  end

  def client_id
    ENV['IMGUR_CLIENT_ID']
  end

  def dgt_full_url url
    'https://sedeapl.dgt.gob.es/WEB_EXAM_AUTO/ServletImagen?nameImagen=' + url
  end
end

