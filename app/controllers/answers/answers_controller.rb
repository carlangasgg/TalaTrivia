class Answers::AnswersController < ApplicationController
  before_action :set_trivium, only: [:show_answers, :scoreboard]

	def submit
    options_selected =  options_params.map{ |x| x.values[0] }
    options_ids = QuestionOption.where(uid: options_selected).ids
    options_ids.each do |opt|
      answer = Answer.create!(user_id: current_user.id, question_option_id: opt)
    end
    render json: "Gracias por su participación en esta trivia <3"
	end

  def show_answers
    trivium = current_user.trivia.find_by(uid: @trivium.uid)
    answers = current_user.answers.joins(question_option: :question)
                                  .where(questions: { id: trivium.question_ids })
                                  .select('questions.name AS question_name,
                                           questions.description AS question_description,
                                           question_options.name AS option_selected,
                                           CASE WHEN question_options.correct_option THEN questions.score ELSE 0 END AS question_score')
    
    total_score = answers.sum(&:question_score)

    render json: {
      data: AnswerSerializer.new(answers).serializable_hash[:data],
      meta: { total_score: total_score }
    }
  end

  def scoreboard
    results = Answer.joins(user: :trivia, question_option: :question)
                .where(questions: { id: @trivium.question_ids })
                .select('users.name AS user_name',
                        'SUM(CASE WHEN question_options.correct_option THEN questions.score ELSE 0 END) AS total_score')
                .group('users.id', 'users.name')
                .order('total_score DESC')
                    
    render json: results
  end

  private
	
	def authorize_admin
		unless current_user.has_role?('admin')
		  render json: { error: 'Unauthorized'}, status: :unauthorized
		end
	end

	def set_option
    @option = QuestionOption.find_by(uid: params[:uid])
	rescue ActiveRecord::RecordNotFound
    render json: { error: 'Option not found' }, status: :not_found
	end

  def set_answer
    @answer = Answer.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Answer not found' }, status: :not_found
  end

  def options_params
    params.require(:answers).map do |answer|
      answer.permit(:answer)
    end
  end

  def set_trivium
    @trivium = Trivium.find_by(uid: params[:uid])
	rescue ActiveRecord::RecordNotFound
    render json: { error: 'Trivium not found' }, status: :not_found
	end
end
