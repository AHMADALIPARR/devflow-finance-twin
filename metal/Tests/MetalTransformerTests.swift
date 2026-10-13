// SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
// Licensing: see LICENSES/LicenseRef-Sovereign-Leviathan-SL-AGPL3-001.txt; preserve existing contributor notices.

import XCTest
import Metal
@testable import MetalTransformer

final class MetalTransformerTests: XCTestCase {
    func testDeviceAndPipelinesLoad() throws {
        guard MTLCreateSystemDefaultDevice() != nil else { throw XCTSkip("Metal unavailable") }
        let engine = try MetalTransformer()
        XCTAssertEqual(engine.dimensions.headDim, 128)
    }
}
