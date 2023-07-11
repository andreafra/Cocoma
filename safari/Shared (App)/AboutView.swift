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
            Text("Made by Andrea Franchini")
        }
        .navigationTitle("About")
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
