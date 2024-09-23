class Trivias::TriviaController < ApplicationController
  before_action :authorize_admin, only: [:create, :update, :destroy]
  before_action :set_trivium, only: [:show, :update, :destroy, :add_user_to_trivia, :remove_user_to_trivia, :players_trivia]
	before_action :set_user, only: [:add_user_to_trivia, :remove_user_to_trivia]

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
			render json: { message: 'Trivium successfully deleted' }, status: :ok
		else
			render json: { error: 'Failed to delete trivium' }, status: :unprocessable_entity
		end
	end

  def start
    render json: { message: 'Im here' }
  end

	def players
		@players = User.players
		render json: UserSerializer.new(@players).serializable_hash[:data]
	end

	def players_trivia
		@players = @trivium.users.players
		render json: UserSerializer.new(@players).serializable_hash[:data]
	end


  def add_user_to_trivia
    if @user.trivia << @trivium
      render json: { message: "User #{@user.email} is now on trivia #{ @trivium.name }!" }, status: :ok
    else
      render json: { error: "Failed to add user #{@user.email} to trivia." }, status: :unprocessable_entity
    end
  
  rescue ActiveRecord::RecordNotUnique
		render json: { message: "User #{@user.email} is already on trivia #{ @trivium.name }." }, status: :ok
  end

	def remove_user_to_trivia
    if @user.trivia.destroy(@trivium)
			render json: { message: "User #{@user.email} has left trivia #{ @trivium.name }!" }, status: :ok
    else
			render json: { error: "Failed to remove user #{@user.email} to trivia." }, status: :unprocessable_entity
    end
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
    render json: { error: 'Trivium not found' }, status: :not_found
	end

	def set_user
    @user = User.find_by(uid: params[:uid])
	rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
	end

	def trivium_params
		params.require(:trivium).permit(:name, :description)
	end
end
