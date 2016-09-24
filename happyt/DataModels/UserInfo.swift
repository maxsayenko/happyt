//
//  UserInfo.swift
//  happyt
//
//  Created by Max Saienko on 9/24/16.
//  Copyright © 2016 Max Saienko. All rights reserved.
//

struct UserInfo {
    var name: String
    var id: String
    var email: String
    var profilePicSource: String {
        get { return "https://graph.facebook.com/\(id)/picture?type=large" }
    }
    
    init() {
        name = ""
        id = ""
        email = ""
    }
}
