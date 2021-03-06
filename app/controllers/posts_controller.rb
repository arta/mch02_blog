class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.order( created_at: :desc )
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new( post_params )

    if @post.save
      redirect_to @post, notice: 'Successfully created!'
    else
      render 'new'
    end
  end

  def show
    @post = Post.find( params[:id] )
    @comments = @post.comments.all
    # @comment = @post.comments.build # Rails Guides: build in the comment form
  end

  def edit
    @post = Post.find( params[:id] )
  end

  def update
    @post = Post.find( params[:id] )

    if @post.update( post_params )
      redirect_to @post, notice: "Successfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find( params[:id] )
    @post.destroy

    redirect_to root_path, notice: 'Successfully deleted!'
   end

  private
  def post_params
    params.require( :post ).permit( :title, :body )
  end
end
