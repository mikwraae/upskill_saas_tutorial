class UsersController < ApplicationController
    before_action :authenticate_user!
    
    # Index to /users/
    def index
    
    
    end
    
    # Get to users/:id/
    def show
        @user = User.find(params[:id])
    end
    

end