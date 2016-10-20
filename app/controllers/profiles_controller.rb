class ProfilesController < ApplicationController
    def new
        # form where a user can fill out their own profile.
        @user = User.find(params[:user_id])
        @profile = Profile.new
    end#new
    
    def create
        @user = User.find(params[:user_id])
        @profile = @user.build_profile(profile_params)
        if @profile.save
            flash[:success] = "Profile updated!"
            redirect_to user_path(params[:user_id])
        else
            render action: :new
        end#ifelse
    end#create
    
    def edit
        @user = User.find(params[:user_id])
        @profile = @user.profile
    end#edit
    
    private
        def profile_params
            params.require(:profile).permit(:first_name,:last_name,:job_title,:phone_number,:contact_email,:description)
        end#profile_params
        
end#class
