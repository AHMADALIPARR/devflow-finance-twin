# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# SPDX-FileCopyrightText: 2026 SNAPKITTYWEST

import Config

config :swarm,
  jwt_secret: System.get_env("JWT_SECRET") || "changeme",
  saml_idp_metadata_url:
    System.get_env("SAML_IDP_METADATA_URL") || "https://idp.example.com/metadata",
  tcp_port: 4488
