//
//  IncomeExpenditureStatisticsView.swift
//  Metyoreco
//
//  Created by Andrii Momot on 11.09.2024.
//

import SwiftUI

struct IncomeExpenditureStatisticsView: View {
    @StateObject private var viewModel = IncomeExpenditureStatisticsViewModel()
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        ZStack {
            Asset.homeBg.swiftUIImage
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 32) {
                HStack {
                    BackButtonView(imageName: Asset.homeTab.name)
                    Spacer(minLength: bounds.width * 0.15)
                    NavigationTitleView(text: "Utwórz projekt")
                }
                .padding(.trailing)
                
                ScrollView {
                    VStack(spacing: 18) {
                        
                        BarChart(model: viewModel.incomeExpenditure)
                        
                        HStack {
                            Asset.buttonBg.swiftUIImage
                                .resizable()
                                .overlay {
                                    HStack {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 4)
                                                .foregroundStyle(Colors.yellowCustom.swiftUIColor)
                                                .padding(.vertical, 14)
                                            Text("\(viewModel.incomeExpenditure.income)")
                                                .foregroundStyle(.black)
                                                .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 15))
                                        }
                                        
                                        Text("Dochód")
                                            .foregroundStyle(.white)
                                            .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
                                    }
                                    .padding(.horizontal, 9)
                                }
                            Spacer()
                            Asset.buttonBg.swiftUIImage
                                .resizable()
                                .overlay {
                                    HStack {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 4)
                                                .foregroundStyle(.red)
                                                .padding(.vertical, 14)
                                            Text("\(viewModel.incomeExpenditure.expenditure)")
                                                .foregroundStyle(.white)
                                                .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 15))
                                        }
                                        
                                        Text("Strata")
                                            .foregroundStyle(.white)
                                            .font(Fonts.MontserratAlternates.medium.swiftUIFont(size: 15))
                                    }
                                    .padding(.horizontal, 9)
                                }
                        }
                        
                        InputField(title: "Dochód",
                                   text: $viewModel.income)
                        .keyboardType(.numbersAndPunctuation)
                        InputField(title: "Strata",
                                   text: $viewModel.expenditure)
                        .keyboardType(.numbersAndPunctuation)
                        
                        NextButtonView(title: "Zapisz") {
                            withAnimation {
                                viewModel.saveValues()
                            }
                        }
                        .frame(maxHeight: 60)
                        .padding(.top)
                        
                        Rectangle()
                            .foregroundStyle(Colors.silverGray.swiftUIColor)
                            .frame(height: 2)
                            .padding(.vertical)
                        
                        Text("Tutaj określasz swoje dochody i straty, a z czasem możesz analizować swoje statystyki")
                            .foregroundStyle(.white)
                            .font(Fonts.MontserratAlternates.bold.swiftUIFont(size: 13))
                            .multilineTextAlignment(.center)
                        
                        Spacer(minLength: 70)
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.never)
            }
        }
        .navigationBarBackButtonHidden()
        .hideKeyboardWhenTappedAround()
        .onAppear {
            viewModel.getIncomeExpenditure()
        }
    }
}

#Preview {
    IncomeExpenditureStatisticsView()
}
