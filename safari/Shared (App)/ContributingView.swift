//
//  TipJarView.swift
//  CookieConsentManager
//
//  Created by Andrea on 11/07/23.
//

import SwiftUI

let PROJECT_REPO_URL = URL(string: "https://github.com/andreafra/cocoma")!
let MOZ_REPO_URL = URL(string: "https://github.com/mozilla/cookie-banner-rules-list")!

struct ContributingView: View {
    var body: some View {
        List {
            Section {
                Text("You can submit and fix issues on this app GitHub repository.")
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
            Section {
                VStack {
                    Text("To be honest, I'd just like to cover the annual cost of the Apple Developer License (99$/year).")
                    ProgressView(value: 0.5)
                }
            }
        }
            .navigationTitle("Contributing")
    }
}

struct ContributingView_Previews: PreviewProvider {
    static var previews: some View {
        ContributingView()
    }
}
