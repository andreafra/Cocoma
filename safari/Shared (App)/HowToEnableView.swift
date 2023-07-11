//
//  HowToEnableView.swift
//  CookieConsentManager
//
//  Created by Andrea on 11/07/23.
//

import SwiftUI

struct HowToEnableView: View {
    var body: some View {
        VStack {
            Form {
                VStack {
                    Image(systemName: "1.circle.fill").padding(.vertical, 4.0).imageScale(.large).foregroundColor(.gray)
                    Text("Open the Settings app and go to Safari > Extensions. Here's a shortcut 😄")
                        
                        
                    Link("Go to Settings \(Image(systemName: "gear"))", destination: URL(string: "App-Prefs:Safari&path=WEB_EXTENSIONS")!)
                        .padding(.horizontal, 24.0)
                        .frame(height: 50)
                        .background(
                            Capsule().fill(Color.accentColor)
                        )
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                VStack {
                    Image(systemName: "2.circle.fill").padding(.vertical, 4.0).imageScale(.large).foregroundColor(.gray)
                    Text("Allow the extension for every website to have the best experience.")
                    GetImage("HowTo_2")
                        .padding(.bottom, 8.0)
                    Text("Under the 'Permission' section, select 'All Websites', and choose the option 'Allow'.")
                    GetImage("HowTo_3")
                    GetImage("HowTo_4")
                        .padding(.bottom, 8.0)
                 }
                .frame(maxWidth: .infinity)
                VStack {
                    Image(systemName: "3.circle.fill").padding(.vertical, 4.0).imageScale(.large).foregroundColor(.gray)
                    Text("You can easily access the extension settings from Safari! Just open the website settings menu, and tap on the extension!")
                    GetImage("HowTo_5").padding(.bottom, 8.0)
                 }
                .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle("How to enable")
    }
}

struct HowToEnableView_Previews: PreviewProvider {
    static var previews: some View {
        HowToEnableView()
    }
}

func GetImage(_ name: String) -> some View {
    return Image(name)
        .resizable()
        .cornerRadius(10)
        .padding(.top)
        .shadow(color: .gray, radius: 3)
        .aspectRatio(contentMode: .fit)
        .frame(maxWidth: .infinity)
}
