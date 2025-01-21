class UsersController < ApplicationController
    def register
        @user = User.create(user_params)
        if @user.save
            response = {message: 'user has been created successfully'}
            render json: response , :status => :created
        else
            render :json => { :errors => @user.errors.full_messages } , :status => :unprocessable_entity
        end
    end
    def login
        authenticate(params[:email],params[:password])
    end
    def mo
        render json: {message: 'you passed'}
     end

    private
    def authenticate(email,password)
    token = AuthenticateUser.call(email,password)
    if token.success?
        render json:{access_token: token.result,message: 'logged in'}
    else
        render json: { error: token.errors }, status: :unauthorized
        end
    end
    def user_params
        return params.permit(:name,:email,:password,:image)
    end
end
