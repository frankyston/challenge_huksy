# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
  end

  def create
    User::Session::Flow
      .call(params: params)
      .on_failure(:invalid_token) { |error| error_session(error[:message]) }
      .on_success do |result|
        session[:token] = result[:user].token
        flash[:notice] = result[:message]
        redirect_to root_path
      end
  end

  def destroy
    session.delete(:token)
    redirect_to root_path
  end

  private

  def error_session(error)
    flash[:notice] = error
    render 'new'
  end
end
