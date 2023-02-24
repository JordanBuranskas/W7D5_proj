class UsersController < ApplicationController

    def new #get
        @user = User.new 
        render :new
    end

    def create  #post
        @user = User.create(user_params)

        if @user.save
            login(@user)
            redirect_to users_url
            flash[:message] = ["Successfully Creted"]
        else
            render :new
            flash.now[:error] = @user.errors.full_message
        end
    end

    def show  #get
        @user = User.find(params[:id])
        render :show
    end

    def index #get
        @users = User.all 
        render :index
    end

    def edit #get
        @user = User.find(params[:id])
        render :edit
    end

    def update #post
        @user = User.find(params[:id])

        if @user.update(user_params)
            flash[:message] = ["Succesfully Updated"]
            redirect_to user_url(@user)
            
        else
            flash.now[:error] = @user.errors.full_message
            render :edit
        end

    end

    private

    def user_params
        params.require(:users).permit(:username, :password)
    end
end
