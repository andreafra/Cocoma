import SwiftUI

struct ContentView: View {
    @AppStorage("banners_closed", store: UserDefaults(suiteName: "group.com.andreafranchini.CookieConsentManager"))
    var bannersClosed: Int = 0
    
    let HELP_URL = URL(string: "https://andreafra.notion.site/Cookie-Consent-Manager-7f7be95ee2c340e29b1b8c4d4e8e4d7c")!
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        Text("\(bannersClosed)").font(.title).bold()
                        Text("cookie banners closed").font(.smallCaps(.body)()).foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
                Section {
                    NavigationLink(destination: HowToEnableView()) {
                        Label {
                            Text("How to enable")
                        } icon: {
                            Image(systemName: "signpost.left.fill")
                                .foregroundColor(.pink)
                                .imageScale(.large)
                        }
                    }
                    NavigationLink(destination: ContributingView()) {
                        Label {
                            Text("Contributing")
                        } icon: {
                            Image(systemName: "star.bubble.fill")
                                .foregroundColor(.yellow)
                                .imageScale(.large)
                        }
                    }
                    NavigationLink(destination: AboutView()) {
                        Label {
                            Text("About")
                        } icon: {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                                .imageScale(.large)
                        }
                    }
                }
                Section {
                    Link(destination: HELP_URL) {
                        Label {
                            Text("Help")
                            Spacer()
                            Image(systemName: "link")
                        } icon: {
                            Image(systemName: "questionmark.bubble.fill")
                                .foregroundColor(.purple)
                                .imageScale(.large)
                        }.foregroundColor(.black)
                    }
                }
            }.navigationTitle(
                Text("Cocoma")
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
