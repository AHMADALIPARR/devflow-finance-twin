# Telegram Agent SDK

Node, Rust and Haskell bots with persistence and agent adapters.

Audience: Bot and workflow developers.

Source roots:

- `telegram-bot-sdk`

Dependencies: None declared.

Package from the repository root:

```powershell
python scripts/product_suite.py bundle telegram-agent-sdk
```

Release gates:

- Network bot tests require explicit credentials and isolated test workspace
- Lock dependencies and verify migrations, permissions and message delivery before deployment
