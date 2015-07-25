class ResultsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    @exam = Exam.find(params[:id])
  end

  def create
    @exam = Exam.find(params[:exam_id])
    @exam.answers = params[:answers]
    @exam.save
    render text: 'ok'
  end
end
