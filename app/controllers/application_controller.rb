class ApplicationController < ActionController::Base
    before_action :authenticate_user!, expect: [:top, :sign_up, :sign_in]
end
