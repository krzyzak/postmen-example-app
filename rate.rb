class Rate
  STATUS_TO_COLOR_MAPPING = {
    'calculating' => :blue,
    'calculated' => :green,
    'failed' => :red
  }.freeze

  attr_reader :date

  def initialize
    require_relative './config.rb'
  end

  def table
    Terminal::Table.new headings: ['ID', 'Status'], rows: rows
  end

  def rows
    rates.map do |rate|
      [
        rate.id,
        rate.status.colorize(STATUS_TO_COLOR_MAPPING[rate.status])
      ]
    end
  end

  def rates
    @rates ||= Postmen::Rate.all
  end
end
