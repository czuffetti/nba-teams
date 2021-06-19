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
    
    guard let url = URL(string: endpointData.baseUrl + urlType.rawValue) else {
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
          decoder.dateDecodingStrategy = .custom { (decoder) -> Date in
            let value = try decoder.singleValueContainer().decode(String.self)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            
            if let date = formatter.date(from: value) {
              return date
            }
            
            throw NetworkError.dateParseError
          }
          
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
