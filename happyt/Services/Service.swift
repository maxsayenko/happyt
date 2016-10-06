//
//  Service.swift
//  happyt
//
//  Created by Max Saienko on 9/24/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

import Alamofire
import AlamofireImage
import PromiseKit

struct Service {
    static func LoadImage(url imageUrl: String) -> Promise<UIImage> {
        return Promise { fulfill, reject in
            Alamofire.request(.GET, imageUrl, parameters: nil, encoding: ParameterEncoding.URL, headers: ["Content-Type":"image"])
                .responseImage { response in
                    switch response.result {
                    case .Success(let image):
                        fulfill(image)
                    case .Failure(let error):
                        reject(error)
                    }
            }
        }
    }
}