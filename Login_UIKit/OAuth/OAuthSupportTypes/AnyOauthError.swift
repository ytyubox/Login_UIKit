//
//  AnyOauthError.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//


struct AnyOauthError:Error {
    var message:String
    init(_ m:String) {
        message = m
    }
}


