class PostsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    def index
        posts = Post.all
        render json: posts
    end

    def create
        post = Post.create(post_params)
        render json: post, status: :created
    end

    def update
        post = find_post
        post.upadate(post_params)
        render json: post
    end

    def destroy
        post = find_post
        post.destroy
        head :no_content
    end

    private

    def find_post
        Post.find(params[:id])
    end

    def render_not_found_response
        render json: {error: "Post not found"}, status: :not_found
    end

    def spice_params
        params.permit(:title, :content, :summary, :category)
    end
end
