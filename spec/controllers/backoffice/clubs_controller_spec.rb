require 'rails_helper'

RSpec.describe Backoffice::ClubsController, type: :controller do
  include AuthHelper

  let(:club) { create :club }
  let(:admin) { create :user, role: 'admin', club_id: nil }

  before do
    request.host = 'backoffice.test.host'
    login_user(admin)
  end

  describe 'clubs check' do
    context 'GET #index' do
      it 'return clubs array' do
        club
        get :index, params: { use_route: :backoffice }
        expect(assigns(:clubs)).to eq([club])
      end
    end

    context 'GET #show' do
      it 'assign requested club' do
        get :show, params: { use_route: :backoffice,
                             id: club.id }
        expect(assigns(:club)).to eq(club)
      end
    end

    context 'GET #new' do
      it 'should render template' do
        get :new, params: { use_route: :backoffice }
        expect(response).to render_template(:new)
      end
    end

    context 'POST #create' do
      it 'should create new club' do
        post :create, params: { use_route: :backoffice,
                                club: attributes_for(:club) }
        expect(Club.count).to eq 1
      end

      it 'should redirect to new' do
        post :create, params: { use_route: :backoffice,
                                club: attributes_for(:club, subdomain: club.subdomain) }
        expect(Club.count).to eq 1
        expect(response).to render_template(:new)
      end
    end

    context 'PUT #update' do
      it 'update club' do
        put :update, params: { use_route: :backoffice,
                               club: attributes_for(:club, name: 'new name'),
                               id: club.id }
        expect(Club.count).to eq 1
        club.reload
        expect(club.name).to eq 'new name'
      end
    end

    context 'GET #edit' do
      it 'should render template' do
        get :edit, params: { use_route: :backoffice, id: club.id }
        expect(response).to render_template(:edit)
      end
    end
  end
end
