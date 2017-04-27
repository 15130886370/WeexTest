//
//  WXEventModule.swift
//  SwiftWeexSample
//
//  Created by zifan.zx on 24/09/2016.
//  Copyright © 2016 com.taobao.weex. All rights reserved.
//

import Foundation

public extension WXEventModule {
    public func printURL(_ url:String,render: String) {
        print(url)
    }
    
    public func getString(_ callBack: WXModuleCallback) {
        callBack("😝😝😝")
    }
}
