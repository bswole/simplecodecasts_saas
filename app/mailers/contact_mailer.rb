class ContactMailer < ActionMailer::Base
    default to: 'smk1986@yahoo.com'
    
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body
        mail(from: email, subject: 'Contact Form Message')
    end#contact_email

end#class