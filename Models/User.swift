//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Tommy Tran on 03/10/2018.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User{
    
    var name:String?
    var screenName:String?
    static var current: User?
    
    init(dictionary: [String:Any]) {
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
    }
    
    
}
