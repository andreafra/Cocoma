//
//  SafariWebExtensionHandler.swift
//  Shared (Extension)
//
//  Created by Andrea on 11/07/23.
//

import SafariServices
import os.log

let SFExtensionMessageKey = "message"

class SafariWebExtensionHandler: NSObject, NSExtensionRequestHandling {

    func beginRequest(with context: NSExtensionContext) {
        guard let item = context.inputItems.first as? NSExtensionItem,
              let userInfo = item.userInfo as? [String: Any],
              let data = userInfo[SFExtensionMessageKey] as? AnyObject
        else {
            context.completeRequest(returningItems: nil, completionHandler: nil)
            return
        }
    
        let response = NSExtensionItem()

        // Sync stats
        
        if let store = UserDefaults(suiteName: "group.com.andreafranchini.CookieConsentManager") {
            if let bannersClosed = data["bannersClosed"] {
                store.set(bannersClosed as! Int, forKey: "banners_closed")
            }
        }
        
        response.userInfo = [ SFExtensionMessageKey: [ "success": true ] ]
            
        context.completeRequest(returningItems: [response], completionHandler: nil)
    }
}
