class PostsController < ApplicationController
  before_action :signed_in, only: [:new, :create]
  
  def index
    @posts = Post.all
    @user = current_user
  end
  
  def new
    @post = Post.new
    @user = current_user
  end
  
  def create
    @post = Post.new(title: params[:post][:title], body: params[:post][:body], user_id: current_user.id )
    if @post.save
      flash[:success] = "Successfully saved post"
      redirect_to posts_path
    else
      render :new
    end
  end
  
  
  private
    
    def signed_in
      if current_user.nil?
        redirect_to login_path
      end
    end
end
