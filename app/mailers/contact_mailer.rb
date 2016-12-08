class ContactMailer < ActionMailer::Base
   
   default to: 'mikkelwraaehansen@gmail.com'
   
   def contact_email(name, email, body)
      @name = name
      @email = email
      @body = body
      
      mail(from: email, subject: 'Conect Form Message')
   end
    
end