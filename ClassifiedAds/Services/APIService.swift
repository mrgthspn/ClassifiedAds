//
//  APIService.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/22/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

import Foundation

class APIService {
  
  static let shared = APIService()
  
  enum GetFailureReason: Error {
    case notFound
    case error(message: ErrorInfo)
  }
  
  private var observation: NSKeyValueObservation?
  
  typealias FetchResult<T> = Result<T, GetFailureReason>
  typealias FetchCompletion<T> = (_ result: FetchResult<T>) -> Void
  
  
  init() {}
 
  func fetchAds(completion: @escaping FetchCompletion<Results>) {
    fetch(request: request(endpoint: Api.list_endpoint)!, completion: completion)
  }
  
  private func fetch<T>(request: URLRequest, completion: @escaping FetchCompletion<T>) where T: Decodable {
     let session = URLSession(configuration: .default)
     let task = session.dataTask(with: request) { (data, response, error) in
       if error != nil {
         completion(.failure(.notFound))
         return
       }
       if let safeData = data {
         if let parsedData = self.parseJSON(safeData, model: T.self) {
           DispatchQueue.main.async {
             completion(.success(payload: parsedData))
           }
         } else {
          if let errorData = self.parseJSON(safeData, model: ErrorInfo.self) {
            completion(.failure(GetFailureReason.error(message: errorData)))
          }
        }
       }
     }
    
     task.resume()
  }

  private func parseJSON<T>(_ data: Data, model: T.Type) -> T? where T : Decodable {
    let decoder = JSONDecoder()
    do {
      let decodedData = try decoder.decode(T.self, from: data)
      return decodedData
    } catch {
      return nil
    }
  }
  
  private func request(endpoint:String) -> URLRequest? {
    if let baseURL = URL(string: Api.base_url) {
      let endpointURL = baseURL.appendingPathComponent(endpoint)
      return URLRequest(url: endpointURL)
    }
    
    return nil
  }
  
}
