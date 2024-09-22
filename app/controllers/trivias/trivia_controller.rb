class Trivias::TriviaController < ApplicationController
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_category, only: [:show, :update, :destroy]

	def index
		@trivia = Trivium.all
    render json: @trivia
	end

	def show
		render json: @trivium
	end

	def create
		@trivium = Trivium.new(trivium_params)
		if @trivium.save
			render json: @trivium, status: :created 
		else
			render json: @trivium.errors, status: :unprocessable_entity
		end
	end

	def update
		if @category.update(trivium_params)
			render json: @trivium
		else
			render json: @trivium.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@trivium.destroy!
		head :no_content
	end

  def start
    render json: { message: 'Im here' }
  end

	private

	def set_trivium
    @trivium = Trivium.find(params[:id])		
	end

	def trivium_params
		params.require(:trivium).permit(:name, :description)
	end
end
