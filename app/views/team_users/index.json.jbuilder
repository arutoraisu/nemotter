json.array!(@team_users) do |team_user|
  json.extract! team_user, :id, :team_id, :user_id, :admin
  json.url team_user_url(team_user, format: :json)
end
