class Questions::OptionsController < ApplicationController
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_option, only: [:show, :update, :destroy]
	before_action :set_question, only: [:create]

	def index
		@options = QuestionOption.all
		render json: OptionSerializer.new(@options).serializable_hash[:data]
	end

	def show
		render json: OptionSerializer.new(@option)
	end

	def create
		@option = QuestionOption.new(option_params)
    @option.question_id = @question.id
		if @option.save
			render json: OptionSerializer.new(@option).serializable_hash[:data][:attributes], status: :created 
		else
			render json: @option.errors, status: :unprocessable_entity
		end
	end

	def update
		if @option.update(option_params)
			render json: OptionSerializer.new(@option).serializable_hash[:data][:attributes]
		else
			render json: @option.errors, status: :unprocessable_entity
		end
	end

	def destroy
		if @option.destroy! 
			render json: { message: 'Option successfully deleted' }, status: :ok
		else
			render json: { error: 'Failed to delete option' }, status: :unprocessable_entity
		end
	end

  def show_questions
    
  end

	private
	
	def authorize_admin
		unless current_user.has_role?('admin')
		  render json: { error: 'Unauthorized'}, status: :unauthorized
		end
	end

	def set_option
    @option = QuestionOption.find_by(uid: params[:id])
	rescue ActiveRecord::RecordNotFound
    render json: { error: 'Option not found' }, status: :not_found
	end

  def set_question
    uid = params[:uid]
    uid = params[:option][:question_id] if params[:option][:question_id].present?

    @question = Question.find_by(uid: uid)
	
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Trivium not found' }, status: :not_found
  end

	def option_params
		params.require(:option).permit(:name, :correct_option, :question_id)
	end
end
