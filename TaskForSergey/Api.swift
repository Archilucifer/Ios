//
//  Api.swift
//  TaskForSergey
//
//  Created by Alina on 20/09/2019.
//  Copyright © 2019 Lucifer. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Api {
    var url : String
    
    init(url:String) {
        self.url = url
    }
    
    func makeGetRequest(params:[String:Any]){
        request(url, method: .get, parameters: params).responseJSON{
            (response)->JSON in
            switch response.result{
            case.success(let value):
                let json = JSON(value)
            case .failure(_):
                break
            }
        }
    }
    
}
