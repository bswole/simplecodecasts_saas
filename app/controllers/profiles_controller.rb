class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :only_current_user
    
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
    
    def update
        @user = User.find(params[:user_id])
        @profile = @user.profile
        if @profile.update_attributes(profile_params)
            flash[:success] = "Profile updated!"
            redirect_to user_path(params[:user_id])
        else
            render action: :edit
        end#ifelse
    end#update
    
    def edit
        @user = User.find(params[:user_id])
        @profile = @user.profile
    end#edit
    
    private
        def profile_params
            params.require(:profile).permit(:first_name,:last_name,:avatar,:job_title,:phone_number,:contact_email,:description)
        end#profile_params
        
        def only_current_user
            @user = User.find(params[:user_id])
            redirect_to(root_url) unless @user == current_user
        end#only_current_user
        
end#class
