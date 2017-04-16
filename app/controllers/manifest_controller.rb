class ManifestController < ApplicationController
  respond_to :json

  def show
    render json: {
      name: ENV['SITE_NAME'] || 'Asamblea de Revolución Democrática',
      short_name: ENV['SITE_NAME'] || 'Asamblea RD',
      display: 'standalone',
      orientation: 'portrait',
      start_url: '/dashboard',
      background_color: '#ffffff',
      theme_color: '#007769',
      icons: [{
        src:   [root_url.chomp('/'), :img, :"logo-square.png"].join('/'),
        sizes: '144x144',
        type:  'image/png'
      }]
    }
  end
end
