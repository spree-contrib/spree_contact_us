Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
                     :name => "contact_us_in_header",
                     :insert_bottom => "#main-nav-bar",
                     :text => "<li class='<%= (request.fullpath.gsub('//','/') == '/contact-us') ? 'current' : 'not'%>'><%= link_to t('spree.contact_us.contacts.new.contact_us'), '/contact-us'  %></li>")
