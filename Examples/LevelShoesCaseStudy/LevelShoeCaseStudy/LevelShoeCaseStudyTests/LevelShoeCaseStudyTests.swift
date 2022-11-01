//
//  LevelShoeCaseStudyTests.swift
//  LevelShoeCaseStudyTests
//
//  Created by Jyoti on 16/10/2022.
//

import XCTest
@testable import LevelShoeCaseStudy

class LevelShoeCaseStudyTests: XCTestCase {
    
    func testMainViewControllerFetchData() throws {
        _ = ShoppingListInteractor(service: ShopListServiceMock())
         
        _ = expectation(description: "Fetch data from service")
         
         waitForExpectations(timeout: 3.0, handler: nil)
         //print(shoppingListInteractor)
        //print(expectation)
        // XCTAssertEqual(shoppingListInteractor.ShopList.count, 1)
        // XCTAssertEqual(viewController.ShopList.first?.title, "This is a test.")
     }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

final class ShopListServiceMock: Mockable, ListServiceable {
    func getItemList() async -> Result<ShoppingList, RequestError> {
        return .success(loadJSON(filename: "shoping_list_JSON", type: ShoppingList.self))
    }
}
