//
//  P_OAuthProvider.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import Foundation

protocol OAuthProviderDelegate:AnyObject {
    func didReceived(_ result:Result<OAuthCredential,Error>)
}
class OAuthProvider:NSObject {
    func startLogin() {
        fatalError()
    }
    weak var oAuthProviderDelegate:OAuthProviderDelegate?
}
