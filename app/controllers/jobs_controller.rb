class JobsController < ApplicationController
    before_action :authenticate_user!
    before_action :only_current_user
    
    # Get /users/:user_id/job/new
    def new
        #Render blank job form
        @job = Job.new
    end
    
    # Post to /users/user_id/jobs/
    def create
        @user = User.find(params[:user_id])
        
        @job = @user.jobs.build(job_params)
        
        if @job.save
            flash[:success] = "The job was added to your profile!"
            redirect_to user_path(id: params[:user_id])
            
        else
            flash[:danger] = @job.errors.full_messages.join(", ")
            render action: :new
        end
    end
    
    # GET to /users/:user_id/jobs/:id
    def edit
        @user = User.find(params[:user_id])
        
        @job = @user.jobs.find(params[:id])
    
    end
    
    # Patch /users/:user_id/jobs/:id/
    def update
        @user = User.find(params[:user_id])
        
        @job = @user.jobs.find(params[:id])
        
        if @job.update_attributes(job_params)
            flash[:success] = "Job updated!"
            redirect_to user_path(id: params[:user_id])
        else
            render action: :edit
        end
    end
    
    
    # GET /users/:user_id/jobs/
    def index
        @users = User.includes( :jobs)
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @job = @user.jobs.find(params[:id])
        
        @job.destroy
        
        if @user.jobs.count == 0
            redirect_to user_path(id: params[:user_id])
        else
            redirect_to user_jobs_path(id: params[:user_id])
        end
            
    end
    
    
    private
    def job_params
        params.require(:job).permit(:job_title, :start_date, :end_date, :company, :description)
    end
    
    def only_current_user
        @user = User.find(params[:user_id])
        redirect_to(root_url) unless @user == current_user
    end
    
end