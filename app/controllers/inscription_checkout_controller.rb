class InscriptionCheckoutController < ApplicationController
  def create
    @member = params[:member]
    @activities = params[:checkedActivities]
    @user = params[:userID]
    @total = JSON.parse(params[:amount])["Amount"].to_d
    date_string = params[:member][:birthdate]
    date_object = DateTime.iso8601(date_string)
    @family_member = FamilyMember.new(
      firstname: params[:member][:firstname],
      lastname: params[:member][:lastname],
      birthdate: date_object + 1.day,
      legaltutorfirstname: params[:member][:legaltutorfirstname],
      legaltutorlastname: params[:member][:legaltutorlastname],
      phonenumber: params[:member][:phonenumber],
      homephonenumber: params[:member][:homephonenumber],
      adresse: params[:member][:adresse],
      user_id: @user
    )
    if @family_member.save
      @activities.each do |activity|
        FamilyMemberActivity.create(family_member_id:@family_member.id, activity_id: activity[:id], validation:false)
      end
    end
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
    base_url = ENV["BASE_URL"]
    url_success = "#{base_url}/profile"
    redirect_to url_success, allow_other_host: true
  end

  def cancel
    base_url = ENV["BASE_URL"]
    url_cancel = "#{base_url}/inscription"
    redirect_to url_cancel, allow_other_host: true
  end

end
