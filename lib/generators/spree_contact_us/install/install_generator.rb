module SpreeContactUs
  module Generators
    class InstallGenerator < Rails::Generators::Base

      argument :file_name, type: :string, desc: 'rails app_path', default: '.'
      source_root File.expand_path('../../templates', __FILE__)

      def copy_initializer_file
        template 'spree_contact_us.rb', "#{file_name}/config/initializers/spree_contact_us.rb"
      end
    end
  end
end
