class ShipperAccount
  STATUS_TO_COLOR_MAPPING = {
    'enabled' => :green,
    'disabled' => :gray,
    'deleted' => :red
  }.freeze

  attr_reader :date

  def initialize
    require_relative './config.rb'
  end

  def table
    Terminal::Table.new headings: ['ID', 'Slug', 'Description', 'Type', 'Status'], rows: rows
  end

  def rows
    shipper_accounts.map do |shipper_account|
      [
        shipper_account.id,
        shipper_account.slug,
        shipper_account.description,
        shipper_account.type,
        shipper_account.status.colorize(STATUS_TO_COLOR_MAPPING[shipper_account.status])
      ]
    end
  end

  def shipper_accounts
    @shipper_accounts ||= Postmen::ShipperAccount.all
  end
end
