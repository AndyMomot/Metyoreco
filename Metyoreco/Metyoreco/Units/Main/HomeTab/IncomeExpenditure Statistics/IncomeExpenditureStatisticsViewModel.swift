//
//  IncomeExpenditureStatisticsViewModel.swift
//  Metyoreco
//
//  Created by Andrii Momot on 11.09.2024.
//

import Foundation

extension IncomeExpenditureStatisticsView {
    final class IncomeExpenditureStatisticsViewModel: ObservableObject {
        @Published var incomeExpenditure: IncomeExpenditureModel = .init()
        @Published var income = ""
        @Published var expenditure = ""
        
        func getIncomeExpenditure() {
            DispatchQueue.main.async { [weak self] in
                if let model = DefaultsService.incomeExpenditure {
                    self?.incomeExpenditure = model
                }
            }
        }
        
        func saveValues() {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                let incomeValue = Int(self.income) ?? .zero
                let expenditureValue = Int(self.expenditure) ?? .zero
                
                self.incomeExpenditure.income += incomeValue
                self.incomeExpenditure.expenditure += expenditureValue
                DefaultsService.incomeExpenditure = self.incomeExpenditure
                
                self.income = ""
                self.expenditure = ""
            }
        }
    }
}
