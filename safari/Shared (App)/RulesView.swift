//
//  RulesView.swift
//  CookieConsentManager
//
//  Created by Andrea on 11/07/23.
//

import SwiftUI
import SafariServices.SFSafariApplication
import SafariServices.SFSafariExtensionManager

struct RulesView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}

func sendMessageToExtension() {
    let messageName = "Hello from App"
    let messageInfo = ["AdditionalInformation":"Goes Here"]
    SFSafariApplication.dispatchMessage(withName: messageName, toExtensionWithIdentifier: extensionBundleIdentifier, userInfo: messageInfo) { error in
        debugPrint("Message attempted. Error info: \(String.init(describing: error))")
    }
}

