class ExamsController < ApplicationController

  def show
    @exam = Exam.find(params[:id])
  end

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.save
      cfs = CreateFormService.new(@exam.id)
      cfs.post

      @exam.url = cfs.url
      @exam.metadata = cfs.typeform_attributes
      @exam.typeform_data = cfs.body
      @exam.magic!
      @exam.save
      redirect_to exam_path(@exam)
    else
      render 'new'
    end
  end

  private

  def exam_params
    params.require(:exam).permit(:code, :lng)
  end
end
