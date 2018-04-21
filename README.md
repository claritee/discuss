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