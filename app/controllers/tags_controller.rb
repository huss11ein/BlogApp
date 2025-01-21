class TagsController < ApplicationController
    before_action :retrieve_post, only: [:create, :update]
    before_action :retrieve_tag, only: [:destroy,:update]
    before_action :authorize_request
    def create
      if @post.nil?
        render json: { error: "Post not found" }, status: :not_found
        return
      end

      tag = @post.tags.create(tag_params)
      if tag.save
        render 'api/v1/posts/_post', locals: { post: @post }, status: :created
      else
        render json: tag.errors, status: :unprocessable_entity
      end
    end

    def index
      @tags = @post.tags
      render json: @tags, status: :ok
    end

    def destroy
      if !@post.is_author?(current_user.id)
        render json: { error: "Not authorized to delete this tag" }, status: :forbidden
        return
      end

      @tag.destroy
      render json: { message: "Tag deleted successfully" }, status: :ok
    end


    def update
        if !@post.is_author?(current_user.id)
        render json: { error: "Not authorized to update this post" }, status: :forbidden
        return
        end
        if @tag.update(tag_params)
        render 'api/v1/posts/_post', locals: { post: @post }, status: :ok
        else
        render json: @tag.errors, status: :unprocessable_entity
        end
    end


    private
    def retrieve_post
    @post = Post.find(params[:post_id])
    end

    def retrieve_tag
    @tag = Tag.find(params[:id])
    end

    def tag_params
    params.require(:tag).permit(:tage_name)
    end
end

