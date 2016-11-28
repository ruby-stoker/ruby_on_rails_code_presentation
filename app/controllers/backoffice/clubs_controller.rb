module Backoffice
  class ClubsController < ApplicationController
    before_action :find_club, only: %i(show edit update destroy)

    before_action :new_club, only: %i(new create)

    def index
      @clubs = Club.all
    end

    def new
    end

    def create
      @club.assign_attributes(club_params.merge(created_by: current_user.id))
      if @club.save
        redirect_to backoffice_club_path(@club.id)
      else
        render :new
      end
    end

    def show
    end

    def destroy
      @club.destroy
    end

    def edit
    end

    def update
      redirect_to backoffice_club_path(@club.id) if @club.update_attributes(club_params)
    end

    private

    def club_params
      params.require(:club).permit(:name, :subdomain, :about)
    end

    def find_club
      @club = Club.find(params[:id])
    end

    def new_club
      @club = Club.new
    end
  end
end
