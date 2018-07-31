module PasswordResetsHelper
  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = t".info"
      redirect_to root_url
    else
      flash.now[:danger] = t".danger"
      render :new
    end
  end
end
