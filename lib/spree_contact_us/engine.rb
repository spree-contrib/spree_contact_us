module SpreeContactUs
  class Engine < Rails::Engine
    engine_name 'spree_contact_us'

    config.autoload_paths += %W[#{config.root}/lib]

    initializer 'spree.contact_us.preferences', after: 'spree.environment' do
      module Spree::ContactUs
        Config = Spree::ContactUsConfiguration.new
      end
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
