//
//  Network.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import Foundation

//
// MARK: - Network
//
class Network {
  //
  // MARK: - Class Methods
  //
  static func loadJSONFile<T: Decodable>(named endpoint: Endpoint?,
                                         page: Int = 1,
                                         type: T.Type,
                                         queue: DispatchQueue? = DispatchQueue.main,
                                         completionHandler: @escaping (T?, NetworkError?) -> Void) {
    guard let urlType = endpoint else {
      if let dispatchQueue = queue {
        dispatchQueue.asyncAfter(deadline: DispatchTime.now()) {
          completionHandler(nil, .invalidPath)
        }
      } else {
        completionHandler(nil, .invalidPath)
      }
    
      return
    }
    
    let endpointData = Constants.EndpointData()
    
    guard let url = URL(string: endpointData.baseUrl + urlType.rawValue + "?per_page=100&page=\(page)") else {
        completionHandler(nil, .invalidPath)
        return
    }
    
    var request = URLRequest(url: url)
    request.setValue(endpointData.apiHostValue, forHTTPHeaderField: endpointData.apiHostKey)
    request.setValue(endpointData.apiKeyValue, forHTTPHeaderField: endpointData.apiKeyKey)
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 200
      
      if statusCode != 200 {
        if let dispatchQueue = queue {
          dispatchQueue.asyncAfter(deadline: DispatchTime.now()) {
            completionHandler(nil, .requestError)
          }
        } else {
          completionHandler(nil, .requestError)
        }
        
        return
      }
      
      do {
        if let jsonData = data {
          let decoder = JSONDecoder()
          let typedObject: T? = try decoder.decode(T.self, from: jsonData)
        
          if let dispatchQueue = queue {
            dispatchQueue.asyncAfter(deadline: DispatchTime.now()) {
              completionHandler(typedObject, nil)
            }
          } else {
            completionHandler(typedObject, nil)
          }
        }
      } catch {
        print(error)
        
        if let dispatchQueue = queue {
          dispatchQueue.asyncAfter(deadline: DispatchTime.now()) {
            completionHandler(nil, .parseError)
          }
        } else {
          completionHandler(nil, .parseError)
        }
      }
    }
    
    dataTask.resume()
  }
}
