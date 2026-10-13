// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

// Sources/SwiftLLM/Tokenizer.swift

import Foundation

struct ByteTokenizer: Sendable {
    static let vocabularySize = 256

    func encode(_ text: String) -> [Int] {
        Array(text.utf8).map(Int.init)
    }

    func decode(_ tokens: [Int]) -> String {
        let bytes = tokens.map { UInt8(clamping: $0) }
        return String(decoding: bytes, as: UTF8.self)
    }

    func decode(token: Int) -> String {
        decode([token])
    }
}
