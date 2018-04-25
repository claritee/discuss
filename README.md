# Discuss


To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server` or `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Notes

### Add new phoenix project

```
mix phoenix.new discuss
```

### DB details

See `dev.exs` - the details can be changed to not use default `postgres` user

If `postgres` user is not setup, the DB config can be updated to use another user.

### Server side templates

* discuss/web/templates/layout
* discuss/web/templates/page

By default - the app has one layout file, but can have multiple layout files.

### Materializecss

* http://materializecss.com/
* Referencing CSS from http://materializecss.com/getting-started.html

### MVC

* web/controllers
* web/models
* web/views
* web/router.ex

`request -> router -> controller` 

Whats happening (example - `page`):

1. When Phoenix starts, it looks in the views folder and looks up the name of the module `Discuss.PageView` and sees `Page` view
2. Phoenix then looks in templates folder and try to find a folder called `page`
3. Phoenix then takes all the files in the `page` template folder and add this as a function to the `Page View`. In this case in the `render` function (see `PageController`)

Name of - views, templates, models, controllers are linked

* Controller: `controllers/PageController.ex`
* Templates: `tempaltes/page`
* View: `views/page_view.ex`
* Models

Try this in `iex -S mix phx.server`

```
Discuss.PageView.render("index.html")
```

### Migrations

Create:

```
mix ecto.gen.migration add_topics
```

* creating priv/repo/migrations
* creating priv/repo/migrations/datetimestamp_add_topics.exs

Add:

```
mix ecto.migrate
```

Check DB:

```
psql -d discuss_dev
```

```
discuss_dev=# \dt
               List of relations
 Schema |       Name        | Type  |  Owner
--------+-------------------+-------+----------
 public | schema_migrations | table | postgres
 public | topics            | table | postgres
(2 rows)
```

To rollback a migration

```
mix ecto.rollback
```

### Requests

#### web.ex

Contains helpers and modules for reuse e.g. Controller common helpers

#### Request Objects

Every function in a controller takes 2 args

* conn - request object containing cookie info, headers, request path etc
* params - request params

### Models

#### Changesets

````
iex(1)> struct = %Discuss.Topic{}
%Discuss.Topic{__meta__: #Ecto.Schema.Metadata<:built, "topics">, id: nil,
 title: nil}
iex(2)> params = %{title: "blah"}
%{title: "blah"}
iex(3)> Discuss.Topic.changeset(struct, params)
#Ecto.Changeset<action: nil, changes: %{title: "blah"}, errors: [],
 data: #Discuss.Topic<>, valid?: true>
````

Handling Form Input

```
%{"_csrf_token" => "xxx",
  "_utf8" => "✓", "topic" => %{"title" => "dddd"}}
```
^ Need to use pattern matching to access the params for "topic"

#### Routes

`mix phoenix.routes`

```
mix phoenix.routes is deprecated. Use phx.routes instead.
 page_path  GET   /            Discuss.PageController :index
topic_path  GET   /topics/new  Discuss.TopicController :new
topic_path  POST  /topics      Discuss.TopicController :create
```

#### Ecto

```
[info] POST /topics
[debug] Processing with Discuss.TopicController.create/2
  Parameters: %{"_csrf_token" => "xxx", "_utf8" => "✓", "topic" => %{"title" => "000"}}
  Pipelines: [:browser]
[debug] QUERY OK db=2.1ms
INSERT INTO "topics" ("title") VALUES ($1) RETURNING "id" ["000"]
```

Record:

```
%Discuss.Topic{__meta__: #Ecto.Schema.Metadata<:loaded, "topics">, id: 3,
 title: "000"}
```