//
//  Created by Bruce Evans
//  Copyright © 2016 Bruce Evans. All rights reserved.
//

import XCTest
@testable import OurApp

class OurAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateArray() {
        let array = createArrayWithCount(100);
        XCTAssert(array.count == 100, "Element count does not equal 100")
    }
    
}
