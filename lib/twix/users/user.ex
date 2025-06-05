defmodule Twix.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Posts.Post

  @required_params [:nickname, :email, :age]

  @email_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/
  @nickname_regex ~r/^[a-zA-Z0-9_]+$/

  schema "users" do
    field :nickname, :string
    field :email, :string
    field :age, :integer
    has_many :posts, Post

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:nickname, min: 3, max: 20)
    |> validate_format(:nickname, @nickname_regex,
         message: "can only contain letters, numbers, and underscores")
    |> unique_constraint(:nickname)
    |> validate_format(:email, @email_regex, message: "is not a valid email address")
    |> unique_constraint(:email)
    |> validate_number(:age, greater_than_or_equal_to: 18)
  end
end
