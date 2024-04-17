//
//  AddExpenseView.swift
//  SwiftChartsDemo
//
//  Created by Nick Gordon on 4/11/24.
//

import SwiftUI

struct AddExpenseView: View {
    @State private var name = ""
    @State private var amount = ""
    @State private var expenseCategory:ExpenseCategory = .bill
 
    var budgetManager:BudgetManager
    func addExpense(name: String, expense: ExpenseCategory, amount: Double) {
        
        print("\(budgetManager.allExpenses.count)")
        
        budgetManager.allExpenses.append(ExpenseModel(name: name, expense: expense, amount: amount, dateCreated: Date()))
        
        budgetManager.findMonthlyTotal()
        print("added")
        print("\(budgetManager.allExpenses.count)")
        
       
    }
    var body: some View {
        
        VStack {
            Text("Add your Expense")
                .font(.largeTitle)
                .bold()
            
            Group {
                TextField("Enter name", text: $name)
                TextField("Enter amount", text: $amount)
            }
            .textFieldStyle(.roundedBorder)
            .padding()
            
            
            Picker("Please choose a color", selection: $expenseCategory) {
                ForEach(ExpenseCategory.allCases, id: \.self) { expense in
                    Text(expense.rawValue)
                          }
                      }
            
            Button("Add expense") {
                addExpense(name: name, expense: expenseCategory, amount: Double(amount) ?? 0.0)
            }
            
        }
        
    }
}

#Preview {
    AddExpenseView(budgetManager: BudgetManager())
}
