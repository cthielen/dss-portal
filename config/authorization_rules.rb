authorization do
  role :access do
    # Allow access to the main page
    has_permission_on :application_assignments, :to => [:index]

    # Allow updating of self (happens automatically on main page load)
    has_permission_on :people, :to => [:update] do
      if_attribute :loginid => is {user.loginid}
    end
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
