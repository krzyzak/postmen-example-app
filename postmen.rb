Bundler.require

require_relative './labels'
require_relative './rate'
require_relative './shipper_account'

class Thor
  no_commands do
    def cli
      @cli ||= HighLine.new
    end
  end
end

class LabelCLI < Thor
  desc 'list', 'Lists all labels'
  def list
    date = cli.ask('Display labels created before'){|q| q.default = (Date.today - 30).to_s } # 30 days ago

    puts Label.new(date).table
  end
end

class RateCLI < Thor
  desc 'list', 'List all Rates'
  def list
    puts Rate.new.table
  end
end


class ShipperAccountCLI < Thor
  desc 'list', 'List all Shipper Accounts'
  def list
    puts ShipperAccount.new.table
  end
end
class PostmenCLI < Thor
  desc 'setup', 'Sets up a project'
  def setup
    region = cli.ask('Pass your region'){|q| q.default = 'sandbox'}
    api_token = cli.ask('API Token')
    review = cli.ask('Would you like to save this configuration?'){|q| q.default = 'Y' }

    configure(region, api_token) if review.casecmp('Y')
  end

  no_commands do
    def configure(region, api_token)
      File.open('credentials', 'w'){|f| f.write([region, api_token].join(',')) }
    end
  end

  desc 'label [SUBCOMMAND], ...ARGS', 'Label interface'
  subcommand 'label', LabelCLI
  desc 'rate [SUBCOMMAND], ...ARGS', 'Rate interface'
  subcommand 'rate', RateCLI
  desc 'shipper_account [SUBCOMMAND], ...ARGS', 'Shipper Account interface'
  subcommand 'shipper_account', ShipperAccountCLI
end

PostmenCLI.start(ARGV)
