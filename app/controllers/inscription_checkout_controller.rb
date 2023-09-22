class InscriptionCheckoutController < ApplicationController
  skip_forgery_protection
  def create
    @member = params[:member]
    @activities = params[:checkedActivities]
    @userID = params[:userID]
    session[:member] = @member
    session[:checkedActivities] = @checkedActivities
    session[:userID] = @userID
    @total = JSON.parse(params[:amount])["Amount"].to_d
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: "Paiement des inscriptions - Maison de quartier de la Croix-Berthaud",
            },
          },
          quantity: 1
        },
      ],
      mode: 'payment',
      success_url: inscription_checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: inscription_checkout_cancel_url
    )
    render json: { url: @session.url }

  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    @member = session[:member]
    @checkedActivities = session[:checkedActivities]
    puts @member
    puts '***************'
    session.delete(:member)
    session.delete(:checkedActivities)
    base_url = ENV["BASE_URL"]
    url_success = "#{base_url}/profile"
    redirect_to url_success, allow_other_host: true
  end

  def cancel
    session.delete(:member)
    session.delete(:checkedActivities)
    base_url = ENV["BASE_URL"]
    url_cancel = "#{base_url}/inscription"
    redirect_to url_cancel, allow_other_host: true
  end

end
