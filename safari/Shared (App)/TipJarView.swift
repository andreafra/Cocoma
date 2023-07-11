//
//  TipJarView.swift
//  CookieConsentManager
//
//  Created by Andrea on 11/07/23.
//

import SwiftUI

let PROJECT_REPO_URL = URL(string: "https://github.com/andreafra/cocoma")!
let MOZ_REPO_URL = URL(string: "https://github.com/mozilla/cookie-banner-rules-list")!

struct TipJarView: View {
    var body: some View {
        Form {
            VStack {
                Text("To be honest, I'd just like to cover the annual cost of the Apple Developer License (99$/year). Extra donations will be devolved to charity.")
                ProgressView(value: 0.5)
            }
            Text("Alternatively, if you can code, you can fix issues by opening a Pull Request on the project GitHub repository.")
            Link(destination: PROJECT_REPO_URL) {
                Label {
                    Text("Visit Cocoma repository")
                    Spacer()
                    Image(systemName: "link")
                } icon: {
                    Image(systemName: "curlybraces.square.fill")
                        .foregroundColor(.purple)
                        .imageScale(.large)
                }
            }
            Text("You can also contribute to Mozilla's Cookie Banner Rules list, which powers this extensions and new versions of Firefox.")
            Link(destination: MOZ_REPO_URL) {
                Label {
                    Text("Visit Mozilla repository")
                    Spacer()
                    Image(systemName: "link")
                } icon: {
                    Image(systemName: "curlybraces.square.fill")
                        .foregroundColor(.orange)
                        .imageScale(.large)
                }
            }
        }
            .navigationTitle("Tip Jar")
    }
}

struct TipJarView_Previews: PreviewProvider {
    static var previews: some View {
        TipJarView()
    }
}
