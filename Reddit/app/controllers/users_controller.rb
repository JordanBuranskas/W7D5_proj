class UsersController < ApplicationController

    def new #get
        @user = User.new 
        render :new
    end

    def create  #post


    end

    def show  #get

    end

    def index #get

    end

    def edit #get

    end

    def update #post

    end

    private

    def user_params
        params.require(:users).permit(:)
    end
end
