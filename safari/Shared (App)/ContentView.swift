import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        Text("42").font(.title).bold()
                        Text("cookie banners closed").font(.smallCaps(.body)()).foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
                Section {
                    NavigationLink(destination: SettingsView()) {
                        Label {
                            Text("Settings")
                        } icon: {
                            Image(systemName: "switch.2")
                                .foregroundColor(.indigo)
                                .imageScale(.large)
                        }
                    }
                    NavigationLink(destination: RulesView()){
                        Label {
                            Text("Rules")
                        } icon: {
                            Image(systemName: "scroll.fill")
                                .foregroundColor(.mint)
                                .imageScale(.large)
                        }
                    }
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
                    NavigationLink(destination: StatisticsView()) {
                        Label {
                            Text("Statistics")
                        } icon: {
                            Image(systemName: "chart.bar.fill")
                                .foregroundColor(.orange)
                                .imageScale(.large)
                        }
                    }
                    NavigationLink(destination: TipJarView()) {
                        Label {
                            Text("Tip Jar")
                        } icon: {
                            Image(systemName: "dollarsign.square.fill")
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
