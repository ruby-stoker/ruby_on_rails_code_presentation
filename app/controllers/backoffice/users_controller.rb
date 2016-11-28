module Backoffice
  class UsersController < ApplicationController
    before_action :find_club, only: %i(destroy edit set_moderator show update)

    before_action :new_user, only: %i(create new)

    def index
      @club_list = Club.all.each_with_object({}) { |club, hash| hash[club.id] = club.subdomain }
      @users = params[:filter].present? ? User.club_ids(params[:filter]) : User.all
    end

    def new
    end

    def create
      @user.update_attributes(user_params.merge(role: :admin))
      if @user.save
        redirect_to action: 'show', id: @user.id
      else
        render :new
      end
    end

    def show
    end

    def edit
    end

    def destroy
      @user.destroy
    end

    def set_moderator
      redirect_to action: 'index' if @user.update_attributes(role: :moderator)
    end

    def update
      redirect_to action: 'show', id: @user.id if @user.update_attributes(user_params)
    end

    private

    def find_user
      @user = User.find(params[:id])
    end

    def new_user
      @user = User.new
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :club_id, :password)
    end
  end
end
