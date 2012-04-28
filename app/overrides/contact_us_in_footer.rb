# If SpreeStaticContent extension is also being used we list a Contact Us link with the other footer page links.
Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
                     :name => "contact_us_in_footer",
                     :insert_bottom => "#footer-pages ul",
                     :text => "<li class='<%= (request.fullpath.gsub('//','/') == '/contact_us') ? 'current' : 'not'%>'><%= link_to t('spree.contact_us.contacts.new.contact_us'), '/contact_us'  %></li>")
