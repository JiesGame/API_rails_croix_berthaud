class CheckoutController < ApplicationController
  def create
    @total = params[:Amount].to_d
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: "Don à l'association de la maison de quartier de la Croix-Berthaud",
            },
          },
          quantity: 1
        },
      ],
      mode: 'payment',
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    render json: { url: @session.url }

  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    base_url = ENV["BASE_URL"]
    url_success = "#{base_url}/thank_you"
    redirect_to url_success, allow_other_host: true
  end

  def cancel
    base_url = ENV["BASE_URL"]
    url_cancel = "#{base_url}"
    redirect_to url_cancel, allow_other_host: true
  end

end
