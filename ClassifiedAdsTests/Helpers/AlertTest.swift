//
//  AlertTest.swift
//  ClassifiedAdsTests
//
//  Created by Maria Agatha España on 12/23/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

import XCTest
@testable import ClassifiedAds

class AlertTests: XCTestCase {
    
    func testAlert() {
        let expectAlertActionHandlerCall = expectation(description: "Alert action handler called")

        let alert = SingleButtonAlert(
            title: "",
            message: "",
            action: AlertAction(buttonTitle: "", handler: {
                expectAlertActionHandlerCall.fulfill()
            })
        )

        alert.action.handler!()

        waitForExpectations(timeout: 0.1, handler: nil)
    }

}
