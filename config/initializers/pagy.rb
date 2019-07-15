require 'pagy/extras/bootstrap'
require 'pagy/extras/navs'
Rails.application.config.assets.paths << Pagy.root.join('javascripts')
Pagy::VARS[:items] = 24
