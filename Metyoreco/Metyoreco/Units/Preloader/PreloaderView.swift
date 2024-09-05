//
//  PreloaderView.swift

import SwiftUI

struct PreloaderView: View {
    @StateObject private var viewModel = PreloaderViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Colors.deepSpaceBlue.swiftUIColor
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Asset.launchTiles.swiftUIImage
                    .opacity(0.1)
            }
            .ignoresSafeArea()
            .offset(y: 50)
            
            VStack(spacing: 70) {
                Asset.logo.swiftUIImage
                
                ProgressView(value: viewModel.progress)
                    .tint(Colors.yellowCustom.swiftUIColor)
                    .background(Colors.silverGray.swiftUIColor)
                    .cornerRadius(3, corners: .allCorners)
                    .frame(height: 8)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 44)
            }
            .padding(.horizontal, 40)
        }
        .onReceive(viewModel.timer) { input in
            DispatchQueue.main.async {
                withAnimation {
                    viewModel.updateProgress()
                }
            }
        }
    }
}

#Preview {
    PreloaderView()
}
