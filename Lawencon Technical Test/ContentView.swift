//
//  ContentView.swift
//  Lawencon Technical Test
//
//  Created by Rival Fauzi on 20/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn: Bool = UserDefaults.standard.string(forKey: "username") != nil
    
    var body: some View {
        NavigationView {
            if isLoggedIn {
                ListMovieView(isLoggedIn: $isLoggedIn)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
