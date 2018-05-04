defmodule Discuss.CommentsChannel do
	use Discuss.Web, :channel

	def join(name, _params, socket) do
    # IO.puts("====================")
    # IO.puts(name) # ID of the topic "comments:1"
    {:ok, %{hey: "there"}, socket}
	end

	def handle_in(name, message, socket) do
    # IO.puts(">>>>>-------------------")
    # IO.puts(name)
    # IO.inspect(message)
    {:reply, :ok, socket}
	end
end