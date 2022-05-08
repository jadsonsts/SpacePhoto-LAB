//
//  PhotoInfoController.swift
//  SpacePhoto-LAB
//
//  Created by Jadson on 8/05/22.
//

import Foundation
import UIKit

class PhotoInfoController {
    
    func fetchPhotoInfo(completion: @escaping (PhotoInfo?) -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!
        let query: [String: String] = [
            "api_key" : "rjjix246fVygZzhch1e8rHNjQJvmCIPIXt2iNMg2",
            //"date" : "2017-07-13"
        ]
        
        let url = baseURL.withQueries(query)!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                let jsonDecoder = JSONDecoder()
                if let data = data,
                   let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data){
                    completion(photoInfo)
                } else {
                    print("Either no data was returned, or data was not serialized.")
                    completion(nil)
                }
            }
        }
        task.resume()
    }
}


