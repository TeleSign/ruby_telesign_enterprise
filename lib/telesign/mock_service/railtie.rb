module TeleSign
  module MockService
    class Railtie < ::Rails::Railtie
      initializer 'telesign_railtie.configure_rails_initialization' do
        require 'telesign/mock_service/spin_up'
      end
    end
  end
end
