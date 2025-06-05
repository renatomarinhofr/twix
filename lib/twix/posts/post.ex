defmodule Twix.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twix.Users.User

  @cast_fields [:text, :likes]
  @required_fields [:text, :user_id]

  schema "posts" do
    field :text, :string
    field :likes, :integer, default: 0
    belongs_to :user, User

    timestamps()
  end

  def changeset(post \\ %__MODULE__{}, attrs) do
    post
    |> cast(attrs, @cast_fields)
    |> validate_required(@required_fields)
    |> validate_length(:text, min: 1, max: 300)
    |> foreign_key_constraint(:user_id, message: "must reference a valid user")
  end
end
