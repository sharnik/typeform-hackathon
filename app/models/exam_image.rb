class ExamImage < ActiveRecord::Base
  validates :dgt_url, :imgur_url, presence: true

  def self.process url
    image = find_by dgt_url: url
    return true if image

    image = new dgt_url: url
    image.save
  end

  def upload
    #Cloudinary::Uploader.upload dgt_full_url
  end

  def dgt_full_url
    'https://sedeapl.dgt.gob.es/WEB_EXAM_AUTO/ServletImagen?nameImagen=' + dgt_url
  end
end

