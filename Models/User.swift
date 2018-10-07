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
    var profilePictureURL:URL?
    private static var _current: User?
    var dictionary: [String: Any]?
    
    init(dictionary: [String:Any]) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profilePictureURL = URL(string: dictionary["profile_image_url_https"] as! String)
    }
    
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUser") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUser")
            } else {
                defaults.removeObject(forKey: "currentUser")
            }
        }
    }
    
}
