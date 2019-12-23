//
//  AdsViewModelTests.swift
//  ClassifiedAdsTests
//
//  Created by Maria Agatha España on 12/23/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

import XCTest
@testable import ClassifiedAds

class AdsViewModelTests: XCTestCase {

// MARK: - bindableCells
  func testNormalCells() {
    let appServerClient = MockAppServerClient()
    appServerClient.fetchResult = .success(payload: Results.with())

    let viewModel = AdsViewModel(apiService: appServerClient)
       viewModel.getAds()
       
       guard case .some(.normal(_)) = viewModel.adCells.value.first else {
         XCTFail()
         return
       }
  }
    
    
  func testEmptyCells() {
    let appServerClient = MockAppServerClient()
    appServerClient.fetchResult = .success(payload: Results.none())
       
    let viewModel: AdsViewModel = AdsViewModel(apiService: appServerClient)
    viewModel.getAds()
    
    guard case .some(.normal(_)) = viewModel.adCells.value.first else {
      XCTAssertTrue(true)
      return
    }
  }
  
  func testErrorNotFoundCells() {
    let appServerClient = MockAppServerClient()
    appServerClient.fetchResult = .failure(APIService.GetFailureReason.notFound)

    let viewModel = AdsViewModel(apiService: appServerClient)
    viewModel.getAds()
    
    guard case .some(.error(_)) = viewModel.adCells.value.first else {
      XCTFail()
      return
    }
  
  }
  
}

private final class MockAppServerClient: APIService {
  static let sharedMock = MockAppServerClient()
  var fetchResult: APIService.FetchResult<Results>?

  override func fetchAds(completion: @escaping APIService.FetchCompletion<Results>) {
    completion(fetchResult!)
  }
    
}
