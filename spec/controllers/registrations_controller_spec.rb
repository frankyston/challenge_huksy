# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  context '#create' do
    context 'Not have record on database' do
      it 'should at error message when send email blank' do
        post :create, params: { user: { email: '' } }
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/E-mail be not blank*/)
        expect(response).to redirect_to(new_registration_path)
      end

      it 'should at error message when send invalid email' do
        post :create, params: { user: { email: 'a@' } }
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/E-mail with invalid format*/)
        expect(response).to redirect_to(new_registration_path)
      end

      it 'should create new user' do
        post :create, params: { user: { email: Faker::Internet.email } }
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/Usuário criado com sucesso. Verifique seu e-mail que enviamos um token para acessar.*/)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'Have record on database' do
      let(:user) { create(:user) }
      it 'should update token' do
        old_token = user.token
        post :create, params: { user: { email: user.email } }
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to match(/Você já tem cadastro por aqui. Enviamos um e-mail com o seu token de acesso.*/)
        expect(old_token).to_not eq(user.reload.token)
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
