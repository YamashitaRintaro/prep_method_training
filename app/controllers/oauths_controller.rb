class OauthsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :require_category_id

  def oauth
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    if (@user = login_from(provider))
      redirect_to new_training_path
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        redirect_to edit_user_category_path
      rescue
        redirect_to root_path, notice: "#{provider.titleize}でログインできませんでした"
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider, :denied)
  end
end