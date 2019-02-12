class Background::UsersController < ApplicationController

	before_action :get_user, except: [:index, :new, :create]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(params[:user].permit!)
		redirect_to action: :index, notice: @user.error_msg
	end

	def edit
	end

	def update
		@user.update(params[:user].permit!)
		redirect_to action: :index
	end

	def show
	end

	def destroy
		@user.destroy
	end

	private
	def get_user
		@user = User.find(params[:id])
	end

end