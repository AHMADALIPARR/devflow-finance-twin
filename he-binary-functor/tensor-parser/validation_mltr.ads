-- License-ID: SL-AGPL3-001 | Covenant-Version: 1.0 | Project policy reference
-- Main project policy: LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt.
-- Existing file, component and third-party notices and grants are preserved.

-- validation_mltr.ads
with Interfaces;
with Format_MLTR; use Format_MLTR;
with System;

package Validation_MLTR is
   pragma SPARK_Mode (On);

   procedure Verify_Structure (
      Addr : in System.Address;
      Len : in Blob_Index;
      Header : in Model_Header;
      Valid : out Boolean
   ) with
      Pre => Len >= Header_Size,
      Post => (if Valid then Header.Tensor_Count <= Max_Tensors);

end Validation_MLTR;
