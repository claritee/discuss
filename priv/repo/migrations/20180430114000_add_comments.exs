defmodule Discuss.Repo.Migrations.AddComments do
  use Ecto.Migration

  def change do
  	create table(:comments) do
      add :content, :string

      #A Comment has 1 User, has 1 Topic
      #A User has many comments, has many Topics
      #A Topic has many comments, has one User
      add :user_id, references(:users)
      add :topic_id, references(:topics)
      timestamps() 
    end
  end
end
