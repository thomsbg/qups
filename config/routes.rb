ActionController::Routing::Routes.draw do |map|
  map.static '/static/:id', :controller => :static, :action => :show
  map.generator '/generator', :controller => :generator, :action => :show
  
  map.resources :hospitals, :only => [:index, :show], :collection => { :search => :get }
  map.resources :regions, :only => [:index, :show], :collection => {
    :states => :get,
    :counties => :get,
    :pin => :post,
    :unpin => :delete,
    :reset => :delete
  }
  # map.resources :reports, :only => [:index, :show]
  
  map.root :generator
end
