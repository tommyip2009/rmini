//
//  JSBridge+launch.swift
//  MiniprogramExample
//
//  Created by 欧阳鑫 on 7/31/20.
//  Copyright © 2020 欧阳鑫. All rights reserved.
//

import Foundation
import ObjectMapper


class LaunchPayload: NSObject, ObjectMapper.Mappable {
    var url: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        url <- map["url"]
    }
}


extension JSBridge {
    static func launch(option: JSInvokeNativeOption, callback: @escaping (Any?) -> Void) {
        // 把数据传递给 webviewController
        let payload = LaunchPayload(JSON: option.payload as? [String:Any] ?? [:])
        
        DispatchQueue(label: "com.miniprogram.wait.created").async {
            
            while (true) {
                let miniprogramController = MiniprogramShareController.shared.getMiniprogramController(appId: option.appId!)
                if (miniprogramController != nil) {
                    DispatchQueue.main.async {
                        let miniprogramController = MiniprogramShareController.shared.getMiniprogramController(appId: option.appId!)
                        miniprogramController?.ready(pagePath: payload!.url!)
                        callback("")
                    }
                    break
                }
            }
            
        }
        
        
    }
}
