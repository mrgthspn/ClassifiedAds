//
//  CellsInteractionTest.swift
//  ClassifiedAdsUITests
//
//  Created by Maria Agatha España on 12/23/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

import XCTest
 
class CellsInteractionTest: XCTestCase {
 
    var app: XCUIApplication!
 
    override func setUp() {
        super.setUp()
 
        continueAfterFailure = false
        app = XCUIApplication()
 
    }
 
    func testAdsTableViewInteraction() {
        app.launch()
        let adsTableView = app.tables["adsTableView"]
        
        XCTAssertTrue(adsTableView.waitForExistence(timeout: 15), "Ad TableView Exists")
       
        let tableCells = adsTableView.cells
        waitForElementToAppear(tableCells.firstMatch)
        if tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
         
            let promise = expectation(description: "Wait for table cells")
         
            for i in stride(from: 0, to: count , by: 1) {
                
                let tableCell = tableCells.element(boundBy: i)
                XCTAssertTrue(tableCell.exists, "The \(i) cell is in place on the table")
                tableCell.tap()
                
                if i == (count - 1) {
                    promise.fulfill()
                }
               
                app.navigationBars.buttons.element(boundBy: 0).tap()
            }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
         
        } else {
            XCTAssert(false, "Was not able to find any table cells")
        }
    }
  
  func waitForElementToAppear(_ element: XCUIElement) {
      let existsPredicate = NSPredicate(format: "exists == true")
      expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
      waitForExpectations(timeout: 10, handler: nil)
  }
}
