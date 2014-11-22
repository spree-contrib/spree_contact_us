Spree::Core::Engine.routes.prepend do
  resources :contacts,
    :controller => 'contact_us/contacts',
    :only       => [:new, :create]
  get 'contact-us' => 'contact_us/contacts#new', :as => :contact_us
end
