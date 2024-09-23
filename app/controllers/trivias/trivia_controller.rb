class Trivias::TriviaController < ApplicationController
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_trivium, only: [:show, :update, :destroy]

	def index
		@trivia = Trivium.all
		render json: TriviumSerializer.new(@trivia).serializable_hash[:data]
	end

	def show
		render json: TriviumSerializer.new(@trivium)
	end

	def create
		@trivium = Trivium.new(trivium_params)
		if @trivium.save
			render json: TriviumSerializer.new(@trivium).serializable_hash[:data][:attributes], status: :created 
		else
			render json: @trivium.errors, status: :unprocessable_entity
		end
	end

	def update
		if @trivium.update(trivium_params)
			render json: TriviumSerializer.new(@trivium).serializable_hash[:data][:attributes]
		else
			render json: @trivium.errors, status: :unprocessable_entity
		end
	end

	def destroy
		if @trivium.destroy! 
			render json: { message: 'Product successfully deleted' }, status: :ok
		else
			render json: { error: 'Failed to delete product' }, status: :unprocessable_entity
		end
	end

  def start
    render json: { message: 'Im here' }
  end

	private
	
	def authorize_admin
		unless current_user.has_role?('admin')
		  render json: { error: 'Unauthorized'}, status: :unauthorized
		end
	end

	def set_trivium
    @trivium = Trivium.find_by(uid: params[:id])
	rescue ActiveRecord::RecordNotFound
    render json: { error: 'Product not found' }, status: :not_found
	end

	def trivium_params
		params.require(:trivium).permit(:name, :description)
	end
end
