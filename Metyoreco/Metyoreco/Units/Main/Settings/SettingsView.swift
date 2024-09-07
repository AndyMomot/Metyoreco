//
//  SettingsView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 07.09.2024.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @EnvironmentObject private var rootViewModel: RootContentView.RootContentViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SettingsView()
}
