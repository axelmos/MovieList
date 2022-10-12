//
//  ApiService.swift
//  MovieList
//
//  Created by Axel Mosiejko on 12/10/2022.
//

import Foundation

class ApiService {
    static let shared = ApiService()
    
    func request<T:Decodable>(_ apiRequest: ApiRequest,
                   completion: @escaping (T) -> Void,
                   failure: @escaping (ApiError) -> Void) {
        
        let headers = [
          "Content-Type": "application/json;charset=utf-8",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYmI3MWQ2MmZjYmI1ODA1M2U2MWNlYjViYTg0ZDcxMCIsInN1YiI6IjYzNDcxNGY2ZmU1YzkxMDA3ZWQxZjlhZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7u1z18ZgPDefN4FB6I8JuAr4u7w0hM_M9mCk2n93mF8"
        ]
        
        var urlString = ""
        if let parameters = apiRequest.parameters?.queryParams(), apiRequest.method == .get {
            var components = URLComponents()
            components.queryItems = parameters.map {
                URLQueryItem(name: $0, value: "\($1)")
            }
            urlString = apiRequest.path.basePath + apiRequest.path.subPath + (components.url?.absoluteString ?? "")
        } else {
            urlString = apiRequest.path.basePath + apiRequest.path.subPath
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = apiRequest.method.rawValue.uppercased()
        request.allHTTPHeaderFields = headers
        
        if apiRequest.method == .post {
            if let parameters = apiRequest.parameters?.queryParams() {
                let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = httpBody
            }
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            guard let data = data else { return }
            //print(String(data: data, encoding: .utf8)!)
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(T.self, from: data)
                    completion(response)
            } catch(let error) {
                print(error)
                failure(error as! ApiError)
                return
            }
        })
        dataTask.resume()
    }
}

