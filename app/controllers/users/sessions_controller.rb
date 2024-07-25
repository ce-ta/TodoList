class Users::SessionsController < Devise::SessionsController
    after_action :set_flash_message, only: [:create, :destroy]

    def create
        super
    end

    def destroy
        super
    end

    protected

    def set_flash_message
        if user_signed_in?
            flash[:notice] = "ログインしました"
        else
            flash[:notice] = "ログアウトしました" if request.path == destroy_user_session_path
        end
    end

    def after_sign_in_path_for(resource)
        lists_path
    end

    def after_sign_out_path_for(resource)
        "/users/sign_in"
    end
end
