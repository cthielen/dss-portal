authorization do
  role :access do
    # Allow access to the main page
    has_permission_on :application_assignments, :to => :manage do
      if_attribute :person_id => is { user.id }
    end

    # Allow updating of self (happens automatically on main page load)
    has_permission_on :people, :to => [:create, :update] do
      if_attribute :loginid => is { user.loginid }
    end

    # Allow creating of bookmarks (cached_application with rm_id == nil)
    has_permission_on :cached_applications, :to => :manage do
      if_attribute :rm_id => is { nil }
      if_permitted_to :manage, :application_assignments
    end
    
    # Allow (only) creating new of RM-based cached applications
    has_permission_on :cached_applications, :to => [:create]
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
