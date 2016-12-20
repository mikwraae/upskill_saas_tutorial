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
        // collect the credit card fields.
        var ccNum = $('#card_number').val();
        var cvcNum = $('#card_code').val();
        var expMonth = $('#card_month').val();
        var expYear = $('#card_year').val();
        
        // Send the card info to Stripe.
        Stripe.createToken({
            number: ccNum,
            cvc: cvcNum,
            exp_month: expMonth,
            exp_year: expYear
        }, stripeResponseHandler);
        
        
    });
   
    
    // Stripe will return a card token.
    // Inject card token as hidden field into form.
    // Submit form to our Rails app    
    
});


