class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :find_user
  
  def index
    @title = params[:relation]
    @user = User.find_by id: params[:user_id]
    @users = @user.send(@title).paginate page: params[:page]
  end

  def create
    user = User.find_by id: params[:followed_id]
    current_user.follow user
    redirect_to user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  def destroy
    user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow user
    redirect_to user
    respond_to do |format|
      format.html {redirect_to @user}
      format.js
    end
  end

  private
  #kiểm ta use có nil hay không
    def find_user
      @user = User.find_by id: params[:id]
      if @user.nil?
        redirect_to root_path
      end
    end
end
