//
//  AdsViewModel.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/22/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

class AdsViewModel {
  
  enum AdsTableViewCellType {
    case normal(cellViewModel: AdCellViewModel)
    case error(message: String)
  }
  
  enum State {
    case searching
    case normal
    case error(message: ErrorInfo)
  }
  
  let adCells = Bindable([AdsTableViewCellType]())
  var state: Bindable<State> = Bindable(.normal)
   
  var ads = [Ad]()
  var filteredAds = [Ad]()
  var apiService: APIService
  
  init(apiService: APIService = APIService.shared) {
    self.apiService = apiService
  }
  
  func getAds() {
    apiService.fetchAds(completion: { [weak self] result in
      guard let `self` = self else {
        return
      }
      
      switch result {
      case .success(let payload):
        self.ads = payload.results
        self.reloadCells(ads: self.ads)
      case .failure(let error):
        switch(error) {
        case .notFound:
          self.state.value = .error(message: ErrorInfo(error: ErrorDetail(code: 404, info: "Not Found")))
          self.adCells.value = [.error(message: "Error: -NotFound")]
          break
        case .error(let message):
          self.state.value = .error(message: message)
          self.adCells.value = [.error(message: message.error.info)]
        default:
          break
        }
       
      }
    })
  }
  
  func filter(text: String) {
    filteredAds = ads.filter { (ad: Ad) -> Bool in
      return ad.name.lowercased().contains(text.lowercased())
    }
    reloadCells(ads: filteredAds)
  }
  
  func searchingState() {
    state.value = .searching
  }
  
  func normalState() {
    filteredAds = []
    reloadCells(ads: ads)
    state.value = .normal
  }
  
  private func reloadCells(ads: [Ad]) {
    adCells.value = ads.compactMap { .normal(cellViewModel: $0 as AdCellViewModel) }
  }
  
}
