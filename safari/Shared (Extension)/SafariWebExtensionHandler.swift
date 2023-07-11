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
                  let message = userInfo[SFExtensionMessageKey]
            else {
                context.completeRequest(returningItems: nil, completionHandler: nil)
                return
            }

            let response = NSExtensionItem()
            response.userInfo = [ SFExtensionMessageKey: [ "Response to": message ] ]
                
            context.completeRequest(returningItems: [response], completionHandler: nil)
    }
}
