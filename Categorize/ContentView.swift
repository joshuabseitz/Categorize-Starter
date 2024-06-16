//
//  ContentView.swift
//  Categorize
//
//  Created by Joshua Seitz on 6/16/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        if authViewModel.user == nil {
            SignInView()
        } else {
            HomeView()
        }
    }
}
