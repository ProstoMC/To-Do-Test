//
//  Fetcher.swift
//  To-Do-Test
//
//  Created by admin on 03.04.25.
//

import Foundation


class Fetcher {
    

    
    
    
    func fetchData(completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/todos") else {
            //Just return empty array
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
            
        }.resume()
        
    }
}
