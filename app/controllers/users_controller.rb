class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # Connecter automatiquement l'utilisateur après son inscription
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Inscription réussie !'
    else
      flash.now[:alert] = @user.errors.full_messages.join(', ')
      render :new
    end
  end
  

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :city_id, :age)
  end
end
