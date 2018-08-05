Rails.configuration.stripe = {
    :publishable_key => 'pk_test_Afxba1zu7EvaPtpRBYYmZCBB',
    :secret_key      => 'sk_test_lkcBXBQh2L5BIQ53ggoZFEPm'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]