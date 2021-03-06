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
    
//    private init(){
//
//    }
    
    private let baseUrl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=c8484d89ac4d40d09d38390b62889c92"
    
    
    func getNews(completed: @escaping (Result<NewsModel, NErrors>)-> Void) {
        
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
    
    
    func getSportNews(comleted: @escaping (Result<SportsData, NErrors>) -> Void) {

    let baseUrl = "https://newsdata.io/api/1/news?apikey=pub_3450df049649181f4ff97a9fcb463f9f6dec&q=sports"


        guard let url = URL(string: baseUrl) else {return}

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil  {
                
                comleted(.failure(.InvalidResponse))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {return}

            guard let data = data else {return}

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let sportsData =  try decoder.decode(SportsData.self, from: data)
                comleted(.success(sportsData))
            }
            catch {
                print(error)
                comleted(.failure(.InvalidData))
            }
        }
        task.resume()
    }

}

