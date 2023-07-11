import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                Section {
                    Label {
                        Text("Banners dealt with")
                        Spacer()
                        Text("35")
                    } icon: {
                        Image(systemName: "checkmark.shield.fill")
                            .foregroundColor(.green)
                            .imageScale(.large)
                    }
                    Label {
                        Text("Banners untouched")
                        Spacer()
                        Text("35")
                    } icon: {
                        Image(systemName: "xmark.shield.fill")
                            .foregroundColor(.red)
                            .imageScale(.large)
                    }
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
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
