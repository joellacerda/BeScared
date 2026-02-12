//
//  MainTabView.swift
//  BeScared
//
//  Created by Joel Lacerda on 30/01/26.
//

import SwiftUI

struct MainTabView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().barTintColor = UIColor.black
    }

    var body: some View {
        TabView {
            MovieListView()
                .tabItem {
                    Label("Discover", systemImage: "popcorn")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        .accentColor(.red)
        .preferredColorScheme(.dark)
    }
}
