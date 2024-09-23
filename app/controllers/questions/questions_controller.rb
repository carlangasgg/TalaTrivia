class Questions::QuestionsController < ApplicationController
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_question, only: [:show, :update, :destroy, :add_question_to_trivia, :remove_question_to_trivia]
	before_action :set_trivium, only: [:create, :add_question_to_trivia, :remove_question_to_trivia]

	def index
		@questions = Question.all
		render json: QuestionSerializer.new(@questions).serializable_hash[:data]
	end

	def show
		render json: QuestionSerializer.new(@question)
	end

	def create
		@question = Question.new(question_params)
    @question.trivium_id = @trivium.id
		if @question.save
			render json: QuestionSerializer.new(@question).serializable_hash[:data][:attributes], status: :created 
		else
			render json: @question.errors, status: :unprocessable_entity
		end
	end

	def update
		if @question.update(question_params)
			render json: QuestionSerializer.new(@question).serializable_hash[:data][:attributes]
		else
			render json: @question.errors, status: :unprocessable_entity
		end
	end

	def destroy
		if @question.destroy! 
			render json: { message: 'Question successfully deleted' }, status: :ok
		else
			render json: { error: 'Failed to delete question' }, status: :unprocessable_entity
		end
	end

  def add_question_to_trivia
    if @trivia.questions << @question
      render json: { message: "Question #{@question.name} has been added to trivia #{ @trivium.name }!" }, status: :ok
    else
      render json: { error: "Failed to add question #{@question.name} to trivia." }, status: :unprocessable_entity
    end
  
  rescue ActiveRecord::RecordNotUnique
		render json: { message: "Question #{@question.name} is already on trivia #{ @trivium.name }" }, status: :ok
  end

	def remove_question_to_trivia
    if @trivia.questions.destroy(@question)
			render json: { message: "Question #{@question.name} has been removed from trivia #{ @trivium.name }!" }, status: :ok
    else
			render json: { error: "Failed to remove question #{@question.name} to trivia" }, status: :unprocessable_entity
    end
	end

	private
	
	def authorize_admin
		unless current_user.has_role?('admin')
		  render json: { error: 'Unauthorized'}, status: :unauthorized
		end
	end

	def set_question
    @question = Question.find_by(uid: params[:id])
	rescue ActiveRecord::RecordNotFound
    render json: { error: 'Question not found' }, status: :not_found
	end

  def set_trivium
    uid = params[:uid]
    uid = params[:question][:trivium_id] if params[:question][:trivium_id].present?

    @trivium = Trivium.find_by(uid: uid)
	
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Trivium not found' }, status: :not_found
  end

	def question_params
		params.require(:question).permit(:name, :description, :score, :trivium_id)
	end
end
