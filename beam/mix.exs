# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# SPDX-FileCopyrightText: 2026 SNAPKITTYWEST

defmodule Swarm.MixProject do
  use Mix.Project

  def project do
    [
      app: :swarm,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Swarm.Application, []}
    ]
  end

  defp deps do
    [
      {:jason, "~> 1.4"},
      {:joken, "~> 2.6"},
      {:samly, "~> 1.0"}
    ]
  end
end
