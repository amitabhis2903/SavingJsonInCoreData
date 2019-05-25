//
//  APIService.swift
//  SavingJsonInCoreData
//
//  Created by A on 17/05/19.
//  Copyright © 2019 A. All rights reserved.
//

import Foundation


//MARK: Decalare enum for handling success and error in generic type.
enum Results<T> {
    case Success(T)
    case Error(String)
}


class APIService: NSObject {
    
    let query: String = "dog"
    lazy var endPoint: String = {
        return "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=\(self.query)&nojsoncallback=1#"
    }()
    
    
    //MARK: Ok, let’s go step by step, the getDataWith function accepts a parameter that is another function, and that function accepts as a parameter our enum constraint to a type Dictionary, remember the weird <T> in the enum? well, in this function the T becomes of type [String: AnyObject], can you see how awesome generics are, not yet? ..it’s ok, just get the idea that you don’t need to create a specific enum for every type thank to generics.
    
    final func getData(completion: @escaping (Results<[[String: AnyObject]]>) -> Void) {
        
        //check url is empty or not
        guard let url = URL(string: endPoint) else {
            completion(.Error("Invalid url"))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) {(data, res, err) in
            guard err == nil else {
                completion(.Error(err!.localizedDescription))
                return
            }
            
            guard let data = data else {
                completion(.Error(err?.localizedDescription ?? "There is no new item to show"))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    guard let itemJsonArray = json["items"] as? [[String: AnyObject]] else {
                        completion(.Error(err?.localizedDescription ?? "There is no new item to show"))
                        return
                    }
                    DispatchQueue.main.async {
                        completion(.Success(itemJsonArray))
                    }
                }
            } catch let error {
                completion(.Error(error.localizedDescription))
            }
            
        }
        .resume()
    }
}
