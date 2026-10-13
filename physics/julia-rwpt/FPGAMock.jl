# SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
# Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

module FPGAMock
export send_pulse_table, apply_control

function send_pulse_table(csv_path::String)
    println("FPGA mock: loading pulse table from ", csv_path)
    return true
end

function apply_control(cmd::Dict)
    println("FPGA mock: apply control ", cmd)
    return true
end

end # module
