class Users::RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)
    if @user.update(account_update_params)
      set_flash_message :notice, :updated
      sign_in @user, bypass: true
      redirect_to edit_user_registration_path, notice: 'Your details was successfully updated.'
    else
      set_flash_message :alert, :updated
      render 'edit'
    end
  end

  protected

  def after_update_path_for(resource)
    edit_user_registration_path(resource)
  end

  def account_update_params
    params = devise_parameter_sanitizer.sanitize(:account_update)
    return params unless params[:password].blank?

    params.delete('password')
    params.delete('password_confirmation')
    params
  end
end
