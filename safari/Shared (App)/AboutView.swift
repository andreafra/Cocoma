//
//  AboutView.swift
//  CookieConsentManager
//
//  Created by Andrea on 11/07/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        List {
            Section {
                Text("😄 Thanks for using this app!")
            }
            Section {
                Text("Made by Andrea Franchini")
                Label {
                    Text("My Website")
                    Spacer()
                    Image(systemName: "link")
                } icon: {
                    Image(systemName: "curlybraces.square.fill")
                        .foregroundColor(.accentColor)
                        .imageScale(.large)
                }
            } header: {
                Text("Credits")
            }
            Section {
                Label {
                    Text("mozilla/cookie-banner-rules-list")
                    Spacer()
                    Image(systemName: "link")
                } icon: {
                    Image(systemName: "curlybraces.square.fill")
                        .foregroundColor(.accentColor)
                        .imageScale(.large)
                }
            } header: {
                Text("Licenses")
            }
        }
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
