//
//  BarChart.swift
//  Metyoreco
//
//  Created by Andrii Momot on 11.09.2024.
//

import SwiftUI
import Charts

struct BarChart: View {
    var model: IncomeExpenditureModel
    
    var body: some View {
        Asset.chartBg.swiftUIImage
            .resizable()
            .scaledToFill()
            .opacity(0.8)
            .overlay {
                HStack {
                    Chart {
                        let middleValue = (model.income + model.expenditure) / 2
                        RuleMark(y: .value("", middleValue))
                            .foregroundStyle(.white)
                            .lineStyle(.init(lineWidth: 2, dash: [5]))
                        
                        BarMark(x: .value("expenditure", 1),
                                y: .value("", model.income))
                        .foregroundStyle(Colors.yellowCustom.swiftUIColor)
                        .cornerRadius(40)
                        
                        BarMark(x: .value("income", 1.2),
                                y: .value("456", model.expenditure))
                        .foregroundStyle(.red)
                        .cornerRadius(40)
                       
                    }
                }
            }
    }
}

#Preview {
    BarChart(model: .init(income: 244, expenditure: 167))
        .frame(width: 378, height: 260)
}
