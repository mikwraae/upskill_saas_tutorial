class ProfilesController < ApplicationController
    
    # GET to /users/:user_id/profiles/new
    def new 
        # Render blank profile form
        @profile = Profile.new
    end
    
    
    # POST to /users/user_id/profile
    def create
        #Ensure that we have the user who is filling out form
        @user = User.find (params[:user_id])
        # Create profile linked to this secific user
        @profile = @user.build_profile( profile_params)
        
        # If save is succesful flash message and redirect to root_path
        if @profile.save
            flash[:success] = "Profile updated!"
            redirect_to user_path(params[:user_id])
        else
            render action: :new
        end
    end
    
    private 
        def profile_params
            params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
        end
end