# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  context '#create' do
    it 'should at error message with invalid token' do
      post :create, params: { user: { token: '' } }
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to match(/Token inválido. Favor tente novamente ou digite seu e-mail no cadastre-se para receber um novo token por e-mail.*/)
      expect(subject).to render_template(:new)
    end

    it 'should success login' do
      user = create(:user)
      post :create, params: { user: { token: user.token } }
      expect(flash[:notice]).to be_present
      expect(flash[:notice]).to match(/Login realizado com sucesso.*/)
      expect(response).to redirect_to(root_path)
    end
  end
end
