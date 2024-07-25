class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?

  def create
    super
    if @user.save
      flash[:notice] = "ようこそ"
    end
  end

  def destroy
    super
    flash[:notice] = "アカウントが削除されました"
  end

  protected

  def after_sign_up_path_for(resource)
    lists_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation])
  end

  def update_resource(resource, params)
    resource.update_without_current_password(params)
    flash[:notice] = "メールアドレスを更新しました"
  end
end
