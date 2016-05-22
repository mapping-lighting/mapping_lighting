class UsersGrid

  include Datagrid

  scope do
    User
  end

  filter(:last_sign_in_at,
         :date,
         :range => true,
         :class => 'datepicker',
         :header => "Filter by last sign in date (select date range)")
  filter(:created_at, :date, :id =>'user_created_at')

  filter(:id, :integer, :id => 'user_id')
  filter(:email, :string) { |value| where("email ilike '%#{value}%'") }

  column(:id)

  column(:email)

  column(:last_sign_in_at)

  column(:view, :html => true) do |record|
    link_to admin_user_path(record), method: :get do
      raw('<span class="glyphicon glyphicon-eye-open"></span>')
    end
  end

  column(:delete, :html => true) do |record|
    link_to admin_user_path(record), method: :delete, data: { confirm: 'Are you sure?' } do
      raw('<span class="glyphicon glyphicon-remove-circle"></span>')
    end
  end
end
