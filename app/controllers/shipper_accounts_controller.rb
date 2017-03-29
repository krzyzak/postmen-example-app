class ShipperAccountsController < ApplicationController
  def index
    @slug = params.dig(:shipper_account, :slug)
    @shipper_accounts = Postmen::ShipperAccount.all(slug: @slug)
  end
end
