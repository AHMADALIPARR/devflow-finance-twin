<!--
License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
Existing file, component and third-party notices and grants are preserved.
-->

# Funnel IR Representation

```IrProc {
  name = "return_item",
  params = [ item: Item, reason: Char(3) ],
  requires = [
    CallRule("returnable", [item]),
    NotEq(FieldRef("item", "state"), EnumVal("State", "RETURNED"))
  ],
  body = [
    Assign(FieldRef("item", "state"),  EnumVal("State", "RETURNED")),
    Assign(FieldRef("item", "reason"), ParamRef("reason")),
    EmitEffect(Update("item")),
    EmitEffect(Commit)
  ],
  effects = [
    Update("Item"), Commit
  ]
}
```
