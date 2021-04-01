//
//  NetworkingService.swift
//  Contributors
//
//  Created by Евгений Клюенков on 02.04.2021.
//

import Foundation
import Alamofire


class NetworkingService {
    
    func fetchRequest(completion: @escaping ([Contributors]?, Error?) -> Void) {
        
        guard let url = URL(string: "https://api.github.com/repos/videolan/vlc/contributors") else { return }
        
        AF.request(url).validate().responseData { response in
            guard let data = response.data, response.error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                let contributors = try decoder.decode([Contributors].self, from: data)
                
                DispatchQueue.main.async {
                    completion(contributors, nil)
                }
            } catch let error{
                completion(nil, error)
            }
        }
    }
}
