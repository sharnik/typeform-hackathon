require 'create_form_service'

class ExamsController < ApplicationController

  def show
    @exam = Exam.find(params[:id])
  end

  def new
    @exam = Exam.new
  end

  def create
    @exam = Exam.new(exam_params)
    if @exam.valid? && url = CreateFormService.new.post
      @exam.url = url
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
