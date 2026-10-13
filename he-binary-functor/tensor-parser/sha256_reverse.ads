-- License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
-- SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
-- Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
-- Existing file, component and third-party notices and grants are preserved.

with SHA256; use SHA256;
with System.Storage_Elements; use System.Storage_Elements;

package SHA256_Reverse
  with SPARK_Mode => On
is
   procedure Reverse_Hash_32bit (
      Target_Digest : in Digest;
      Base_Block : in Block;
      Payload_Index : in Positive;
      Found : out Boolean;
      Preimage : out Unsigned_32
   )
     with
       Pre => Payload_Index <= Positive'Last - 3
              and then Payload_Index >= Block'First
              and then Payload_Index + 3 <= Block'Last,
       Global => null;

end SHA256_Reverse;
