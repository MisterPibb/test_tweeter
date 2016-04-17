class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  # def show
  #   variable_name = 0
  #   @universal_veriable_name = 0 #accessible in view and not just this def
  #
  #   @text = "Show"
  #   @post = Post.find(params[:id])
  #   # binding.pry # Stops code and continues in console/terminal
  # end
  def index
    @text = "User Index"

    # @users = User.all.order(created_at: :desc)
    @users = User.search(params[:search]).order(created_at: :desc).page(params[:page]).per(2)
  end

  def new
    @text = "New User"
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(user_params[:email], user_params[:password])
      redirect_to root_path
      flash[:success] = "User Created"
    else
      redirect_to new_user_path
      flash["alert-danger"] = @user.errors.messages.map{|e| "<i class='fa fa-minus'></i> <strong>#{e.flatten.first.to_s.titleize}</strong> #{e.flatten.last}"}.join('<br />')
    end
  end
  # def new
  #   @text = "New"
  # end
  # def create
  #   @post = Post.new(post_params)
  #   if @post.save
  #     redirect_to post_path(@post)
  #   else
  #     redirect_to root_path
  #   end
  #
  # end
  #
  # def edit
  #   @text = "Edit"
  # end
  # def update
  #
  # end
  #
  # private
  # def post_params
  #   params.require(:post).permit(:content, :user_id) if params[:post]
  # end
  private
  def user_params
    params.require(:user).permit(:username, :email, :first_name, :last_name, :password, :password_confirmation) if params[:user]
  end

end
