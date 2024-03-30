class UsersController < ApplicationController
  skip_authentication only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @organization = Organization.create(members: [@user])
      @app_session = @user.app_sessions.create
      log_in(@app_session)

      redirect_to root_path, 
        flash: { success: t(".welcome", name: @user.name) },
        status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end