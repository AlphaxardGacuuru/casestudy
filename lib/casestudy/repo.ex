defmodule Casestudy.Repo do
  use Ecto.Repo,
    otp_app: :casestudy,
    adapter: Ecto.Adapters.Postgres
end
