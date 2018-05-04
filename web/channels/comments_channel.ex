defmodule Discuss.CommentsChannel do
	use Discuss.Web, :channel

  alias Discuss.{Topic, Comment}

	def join("comments:" <> topic_id, _params, socket) do
    # IO.puts("====================")
    # IO.puts(name) # ID of the topic "comments:1"
    topic_id = String.to_integer(topic_id)
    topic = Topic
      |> Repo.get(topic_id)
      |> Repo.preload(:comments)

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
	end

  # Called when something is pushed to the channel
  # socket object in channel is like the "conn" object in the Controller
  # To get access to variables: socket.assigns
	def handle_in(name, %{"content" => content}, socket) do
    # IO.puts(">>>>>-------------------")
    # IO.puts(name)
    # IO.inspect(message)

    # Message: %{"content" => "comment!"}

    topic = socket.assigns.topic
    user_id = socket.assigns.user_id

    changeset = topic
      #this only builds one association, cannot be called multiple times
      #to build more than one association, need to add a 2nd arg so that the comment is associated to a topic and user
      |> build_assoc(:comments, user_id: user_id)
      |> Comment.changeset(%{content: content})

    case Repo.insert(changeset) do
      {:ok, comment} ->
        # Note: calling broadcast - broadcast message to subscribers
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new",
          %{comment: comment}
          )
        {:reply, :ok, socket}
      {:error, _reason} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
	end
end