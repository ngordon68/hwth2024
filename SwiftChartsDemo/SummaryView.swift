//
//  SummaryView.swift
//  SwiftChartsDemo
//
//  Created by Nick Gordon on 4/16/24.
//

import SwiftUI
import Charts

struct SummaryView: View {
    
    var budgetManager: BudgetManager
    
    init(budgetManager: BudgetManager) {
        self.budgetManager = budgetManager
        budgetManager.findMonthlyTotal()
    }
    
    var maxExpenseData: ExpenseTotalModel? {
        budgetManager.allTotals.max{ $0.percentageTotal < $1.percentageTotal }
    }

    
    var body: some View {
        
        VStack {
            Text("Expense BreakDown")
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            Chart(budgetManager.allTotals) { expense in
                
                SectorMark(angle: .value("Name", expense.total),
                           innerRadius: .ratio(0.6),
                           angularInset: 1)
                .cornerRadius(15)
                .foregroundStyle(by: .value("Total", expense.category.rawValue))
                .opacity(maxExpenseData == expense ? 0.2 : 1)
                .annotation(position: .overlay) {
        
                        Text("\(String(format: "%.2f", expense.percentageTotal))%")
                            .font(.system(size: 10))
                        
                    
                }
            }
            .chartLegend(position: .top ,alignment: .center, spacing: 20)
            .overlay {
                VStack {
                    Text("Your most expense is")
                    Text("\(budgetManager.mostExpense.0)")
                        .foregroundStyle(.cyan)
                        .bold()
                    Text("at $\(String(format: "%.2f", budgetManager.mostExpense.1))")
                }
                .frame(width: 100)
                .font(.headline)
               
                
            }
            .frame(height: 400)
            .padding(.bottom, 200)
            
        }
    
        
    }
    
  
}

#Preview {
    SummaryView(budgetManager: BudgetManager())
}
