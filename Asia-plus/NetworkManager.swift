//
//  NetworkManager.swift
//  Asia-plus
//
//  Created by Abdusalom Hojiev on 12/17/21.
//

import Foundation
import UIKit



class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    private let baseUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=c8484d89ac4d40d09d38390b62889c92"
    
    
    func getNews(completed: @escaping (Result<NewsModel, NErrors>)-> Void) {
        
        var urlComponent = URLComponents()
        
        urlComponent.scheme? = "https"
        guard let endPoind = URL(string: baseUrl) else {
            completed(.failure(.Invalidnews))
            return
        }
        
        let session = URLSession.shared.dataTask(with: endPoind) { data, response, error in
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200  else {
                completed(.failure(.InvalidResponse))
                return
            }
            
            if error != nil {
                completed(.failure(.Invalidnews))
            }
            
            guard let getdata = data else {
                completed(.failure(.InvalidData))
                return
                }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let getnew = try decoder.decode(NewsModel.self, from: getdata)
                completed(.success(getnew))
            }
            catch {
                print("Problems zdes")
                print(error)
                completed(.failure(.InvalidData))
            }
        }
        session.resume()
    }
}
