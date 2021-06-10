//
//  JeonGooTests.swift
//  JeonGooTests
//
//  Created by 이명직 on 2021/03/04.
//

import XCTest
@testable import JeonGoo

class JeonGooTests: XCTestCase {
    
    private var userViewModel = UserViewModel()
    private var state: ViewModelState?
    private var id = "a@a.a"
    private var pass = "1"
    
    override func setUpWithError() throws {
        userViewModel.signInPost(email: self.id, pass: self.pass) { state in
            self.state = state
        }
    }
    
    override func tearDownWithError() throws {
        id = "a@a.a"
        pass = "1"
    }
    
    func test_로그인성공() {
        
        XCTAssertEqual(state, .success)
    }
    
    func test_로그인실패() {
        XCTAssertEqual(state, .failure)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
