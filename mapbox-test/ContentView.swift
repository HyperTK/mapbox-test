//
//  ContentView.swift
//  mapbox-test
//
//  Created by 滝野駿 on 2023/04/04.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1

    var body: some View {
        // タブレイアウト
        TabView(selection: $selection) {
            // チーム
            TabTeamView()
                .tabItem {
                    Image(systemName: "person.3.sequence.fill")
                    Text("TEAM")
                }.tag(0)
            // 全体マップ
            TabMapView()
                .tabItem {
                    Image(systemName: "map")
                    Text("MAP")
                }.tag(1)
            // 記録
            TabLogView()
                .tabItem(){
                    Image(systemName: "book.closed.fill")
                    Text("LOG")
                }.tag(2)
            // マイページ
            TabLogView()
                .tabItem(){
                    Image(systemName: "person.crop.circle.fill")
                    Text("MYPAGE")
                }.tag(3)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
