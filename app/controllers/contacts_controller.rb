class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end#new
    
    def create
        @contact = Contact.new(contact_params)
        if @contact.save
            #generate and send email update
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            ContactMailer.contact_email(name, email, body).deliver
            
            #inform user of success
            flash[:success] = 'Message sent.'
            redirect_to new_contact_path
        else
            #inform user of error
            flash[:danger] = 'Error occured, message has not been sent.'
            redirect_to new_contact_path
        end#if
    end#create
    
    private
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end#contact_params
end#class