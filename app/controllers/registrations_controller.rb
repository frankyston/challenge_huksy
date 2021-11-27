# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def new; end

  def create
    User::Register::Flow
      .call(params: params)
      .on_failure(:param_email_be_blank) { |error| error_register(error[:message]) }
      .on_failure(:invalid_email) { |error| error_register(error[:message]) }
      .on_failure(:invalid_user_params) { |user| error_register(user[:errors]) }
      .on_success do |result|
        flash[:notice] = result[:message]
        redirect_to root_path
      end
  end

  private

  def error_register(error)
    flash[:notice] = error
    redirect_to new_registration_path
  end
end
