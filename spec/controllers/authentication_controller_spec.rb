require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe '#index' do
    context 'new user' do
      before { get :index }

      it 'responds with success' do
        expect(response).to have_http_status(:success)
      end

      it 'assigns dialects' do
        expect(assigns(:dialects)).to eq(User.dialects)
      end

      it 'renders index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'existing user' do
      let!(:user) { create :user }

      before do
        sign_in user
        get :index
      end

      it 'responds with 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'do not assigns dialects' do
        expect(assigns(:dialects)).to eq(nil)
      end

      it 'redirects to messages' do
        expect(response).to redirect_to messages_path
      end
    end
  end

  describe '#login' do
    context 'correct parameters' do
      before { post :login, params: { username: 'user1', dialect: 'valley' } }

      it 'responds with 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'do not assigns current_user' do
        expect(assigns(:current_user)).to eq(nil)
      end

      it 'redirects to messages' do
        expect(response).to redirect_to messages_path
      end
    end

    context 'new user' do
      before { post :login, params: { username: 'user1', dialect: 'unknown' } }

      it 'responds with 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'do not assigns current_user' do
        expect(assigns(:current_user)).to eq(nil)
      end

      it 'redirects to messages' do
        expect(response).to redirect_to root_path
      end
    end

    context 'existing user' do
      let!(:user) { create :user }

      before do
        sign_in user
        post :login, params: { username: 'user1', dialect: 'valley' }
      end

      it 'responds with 302' do
        expect(response).to have_http_status(:redirect)
      end

      it 'assigns current_user' do
        expect(assigns(:current_user)).to eq(user)
      end

      it 'redirects to messages' do
        expect(response).to redirect_to messages_path
      end
    end
  end
end
