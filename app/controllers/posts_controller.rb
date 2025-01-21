class PostsController < ApplicationController
    before_action :retrieve_post, only: [ :update, :destroy]
    before_action :authorize_request
    def index
        @posts = Post.all.order("created_at DESC")
        if @posts
            render json: @posts, status: :ok
        else
            render json: {message: "No Posts Found"}, status: :not_found
        end
    end

    def show
      @post = Post.find_by(id: params[:id])
      if @post
        render json: @post, status: :ok
      else
        render json: { message: "Post not found" }, status: :not_found
      end
    end

    def create
        @post = current_user.posts.create(post_params)
        if @post.save
          render json: {message: "Created SuccessFully"}, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

    def update
      if @post.is_author?(current_user)
        if @post.update(post_params)
          render json: {message: "Updated SuccessFully"}, status: :ok
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      else
        render json: { error: "not authorized to update this post" }, status: :forbidden
      end
    end

    def destroy
      if @post.is_author?(current_user)
        @post.destroy
        render json: { message: "post successfully deleted" }, status: :ok
      else
        render json: { error: "not authorized to delete this post" }, status: :forbidden
      end
    end


    private

    def post_params
    params.require(:post).permit(:title, :body, tags_attributes: [:tage_name])
    end

    def retrieve_post
    @post = Post.find(params[:id])
    end
end
