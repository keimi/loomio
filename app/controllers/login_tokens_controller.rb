class LoginTokensController < ApplicationController

  def show
    session[:pending_token] = login_token.token
    redirect_to login_token.redirect || explore_path
  end

  private

  def login_token
    @login_token ||= LoginToken.find_by!(token: params[:id])
  end
end
