/*global $ */
// Document ready.
$(document).on('turbolinks:load', function(){
    var theForm = $('#pro_form');
    var submitBtn = $('#form-submit-btn');
    // Set strioe public key
    Stripe.setPublisableKey( $( 'meta[name="stripe-key"]').attr('content'));
    
    // When user clicks form submit bnt
    submitBtn.click(function(event){
        // prevent default submission behavior
        event.preventDefault();
        submitBtn.val("Processing").prop('disabled', true);
        // collect the credit card fields.
        var ccNum = $('#card_number').val();
        var cvcNum = $('#card_code').val();
        var expMonth = $('#card_month').val();
        var expYear = $('#card_year').val();
        
        
        // Use stripe js lib for validating
        var error = false;
        
        // validate card number
        if(!Stripe.card.validateCardNumber(ccNum)){
            error = true;
            alert('The credit card number appears to be invalid')
        }
        
        // validate CVC number
        if(!Stripe.card.validateCVC(cvcNum)){
            error = true;
            alert('The CVC number appears to be invalid')
        }
        
        // validate EXP date
        if(!Stripe.card.validateExpiry(expMonth, expYear)){
            error = true;
            alert('The expiration date appears to be invalid')
        }
        
        
        
        if (error){
            // if there are card errors dont send to stripe
           submitBtn.prop('disabled', false).val("Sign Up");
        } else {
            // Send the card info to Stripe.
            Stripe.createToken({
                number: ccNum,
                cvc: cvcNum,
                exp_month: expMonth,
                exp_year: expYear
            }, stripeResponseHandler);    
        }
        
        return false;
    });
   
    // Stripe will return a card token.
    function stripeResponseHandler(status, response) {
        // Get the token from the response
        var token = response.id;
        
        // Inject the card token in a hidden field.
        theForm.append( $('<input type="hidden" name="user[stripe_card_token]" >').val(token));
        
        // Submit form to our Rails app    
        theForm.get(0).submit();
    }   
});


