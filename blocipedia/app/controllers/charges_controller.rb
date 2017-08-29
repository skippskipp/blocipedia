class ChargesController < ApplicationController
  def new
    @amount = 15_00
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: @amount
    }

  end

  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    @amount = 15_00
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: @amount,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    upgrade  #Upgrade role to 'Premium'

    flash[:notice] = "Congratulations for upgrading, #{current_user.username}!"
    redirect_to root_path

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def downgrade
   current_user = User.find(params[:stripeToken])
   current_user.params[:stripeToken] = nil
   current_user[:customer][:amount] = nil

   if current_user.save
     flash[:notice] = "Your Premium Membership has been canceled. We will miss you :("
     redirect_to new_charge_path
   end
  end

  def upgrade
    current_user.role = 2
    current_user.save!
  end

end
