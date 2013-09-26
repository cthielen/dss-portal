authorization do
  role :access do
    # Allow access to the main page
    has_permission_on :application_assignments, :to => [:index, :update, :create, :destroy] do
      if_attribute :person_id => is {user.id}
    end

    # Allow updating of self (happens automatically on main page load)
    has_permission_on :people, :to => [:create, :update] do
      if_attribute :loginid => is {user.loginid}
    end
  end
  
  role :guest do
	has_permission_on :people, :to => [:create]
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
