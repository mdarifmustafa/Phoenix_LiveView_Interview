# Interview

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


Install Erlang/OTP 27+
Install Elixir 1.7+
Install Latest NodeJS LTS for node/nvm


#Installing archives for Phoenix Mix
mix archive.install hex phx_new

#Declaring and starting new project
mix phx.new hello


# create your project repo
mix ecto.create


#Starting Server
mix phx.server


#Generating a socket
https://hexdocs.pm/phoenix/channels.html#generating-a-socket
mix phx.gen.socket User


#Config for DB
/config/dev.exs

#Generating new schema at /lib/hello/user.ex
mix phx.gen.schema User users name:string email:string bio:string number_of_pets:integer

#Mix Ecto Task
mix ecto.migrate

#You can use DB operations also using command line
iex -S mix



And it has created a migration.
So what migrations are out a way of keeping track of what changes you are making to a database.
So for instance right now you have only one table overhead and later on we might want to modify this
table.
That is what migrations do they take care off going from one version of the database to another version
of the database and making sure that your data stays put and you don't lose anything during transitions
from one version to another way.





D:\projects\phoenix\hello>iex -S mix
Erlang/OTP 27 [erts-15.0.1] [source] [64-bit] [smp:16:16] [ds:16:16:10] [async-threads:1] [jit:ns]

Generated hello app
Interactive Elixir (1.17.2) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> alias Hello.User
Hello.User
iex(2)> User.changeset(%User{}, %{})
#Ecto.Changeset<
  action: nil,
  changes: %{},
  errors: [
    name: {"can't be blank", [validation: :required]},
    email: {"can't be blank", [validation: :required]},
    bio: {"can't be blank", [validation: :required]},
    number_of_pets: {"can't be blank", [validation: :required]}
  ],
  data: #Hello.User<>,
  valid?: false,
  ...
>
iex(3)> cs = User.changeset(%User{}, %{})
#Ecto.Changeset<
  action: nil,
  changes: %{},
  errors: [
    name: {"can't be blank", [validation: :required]},
    email: {"can't be blank", [validation: :required]},
    bio: {"can't be blank", [validation: :required]},
    number_of_pets: {"can't be blank", [validation: :required]}
  ],
  data: #Hello.User<>,
  valid?: false,
  ...
>
iex(4)> cs.valid?
false
iex(5)> cs.errors
[
  name: {"can't be blank", [validation: :required]},
  email: {"can't be blank", [validation: :required]},
  bio: {"can't be blank", [validation: :required]},
  number_of_pets: {"can't be blank", [validation: :required]}
]
iex(6)> param = %{name: "Joe", email: "joe@gmail.com", bio: "Doctor", number_of_pets: 1}
%{name: "Joe", bio: "Doctor", email: "joe@gmail.com", number_of_pets: 1}
iex(7)> cs = User.changeset(%User{}, param)
#Ecto.Changeset<
  action: nil,
  changes: %{
    name: "Joe",
    bio: "Doctor",
    email: "joe@gmail.com",
    number_of_pets: 1
  },
  errors: [],
  data: #Hello.User<>,
  valid?: true,
  ...
>
iex(8)> recompile()
Compiling 1 file (.ex)
:ok
iex(9)> import Ecto.Query
Ecto.Query
iex(10)> import Hello.Repo
Hello.Repo
iex(11)> Repo.all( from u in User, select: u.email )
** (UndefinedFunctionError) function Repo.all/1 is undefined (module Repo is not available). Did you mean:

      * Hello.Repo.all/1

    Repo.all(#Ecto.Query<from u0 in Hello.User, select: u0.email>)
    iex:11: (file)
iex(11)> Repo.all( from u in User, select: u.email )
** (UndefinedFunctionError) function Repo.all/1 is undefined (module Repo is not available). Did you mean:

      * Hello.Repo.all/1

    Repo.all(#Ecto.Query<from u0 in Hello.User, select: u0.email>)
    iex:11: (file)
iex(11)> Repo.insert(%User{name: "Joe", bio: "Doctor", email: "joe@gmail.com", number_of_pets: 1})
** (UndefinedFunctionError) function Repo.insert/1 is undefined (module Repo is not available). Did you mean:

      * Hello.Repo.insert/1

    Repo.insert(%Hello.User{__meta__: #Ecto.Schema.Metadata<:built, "users">, id: nil, name: "Joe", email: "joe@gmail.com", bio: "Doctor", number_of_pets: 1, inserted_at: nil, updated_at: nil})
    iex:11: (file)
iex(11)> Hello.Repo.insert(%User{name: "Joe", bio: "Doctor", email: "joe@gmail.com", number_of_pets: 1})
[debug] QUERY OK source="users" db=12.9ms decode=1.3ms queue=1.6ms idle=1458.9ms
INSERT INTO "users" ("name","bio","email","number_of_pets","inserted_at","updated_at") VALUES ($1,$2,$3,$4,$5,$6) RETURNING "id" ["Joe", "Doctor", "joe@gmail.com", 1, ~U[2024-09-30 00:57:19Z], ~U[2024-09-30 00:57:19Z]]
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:386
{:ok,
 %Hello.User{
   __meta__: #Ecto.Schema.Metadata<:loaded, "users">,
   id: 1,
   name: "Joe",
   email: "joe@gmail.com",
   bio: "Doctor",
   number_of_pets: 1,
   inserted_at: ~U[2024-09-30 00:57:19Z],
   updated_at: ~U[2024-09-30 00:57:19Z]
 }}
iex(12)> Hello.Repo.all( from u in User, select: u.email )
[debug] QUERY OK source="users" db=6.6ms queue=0.9ms idle=1449.7ms
SELECT u0."email" FROM "users" AS u0 []
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:386
["joe@gmail.com"]
iex(13)> Hello.Repo.all(from u in User, select: %{u.id => u.email})
[debug] QUERY OK source="users" db=0.5ms queue=0.5ms idle=1101.1ms
SELECT u0."id", u0."email" FROM "users" AS u0 []
↳ :elixir.eval_external_handler/3, at: src/elixir.erl:386
[%{1 => "joe@gmail.com"}]
iex(14)>
