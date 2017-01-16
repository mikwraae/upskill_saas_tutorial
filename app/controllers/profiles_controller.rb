class ProfilesController < ApplicationController
    
    # GET to /users/:user_id/profiles/new
    def new 
        # Render blank profile form
        @profile = Profile.new
    end
    
end