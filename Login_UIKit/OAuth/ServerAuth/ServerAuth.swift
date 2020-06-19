//
//  ServerAuth.swift
//  Login_UIKit
//
//  Created by 游宗諭 on 2020/6/19.
//  Copyright © 2020 游宗諭. All rights reserved.
//

import Foundation

protocol ServerAuthDelegate:AnyObject {
    func didReceive(result: ServerAuth.ServerAuthResult)
}

class ServerAuth {
    typealias ServerAuthResult = Result<ServerJSON,Error>
    var mockIsSuccess = true
    func login(_ stoken: String) {
        print(Self.self, #function)
        switch mockIsSuccess {
            case true:
                let serverJson = ServerJSON(_名字: "Yu", _令牌: UUID().uuidString)
                continueDelegate?.didReceive(result: .success(serverJson))
            case false:
                let error = AnyOauthError("server 404")
                continueDelegate?.didReceive(result: .failure(error))
        }
        
        
    }
    struct ServerJSON {
        var _名字:String
        var _令牌:String
    }
    weak var continueDelegate:ServerAuthDelegate?
}
