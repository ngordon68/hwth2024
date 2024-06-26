//
//  ExpenseDemoView.swift
//  SwiftChartsDemo
//
//  Created by Nick Gordon on 4/10/24.
//

import SwiftUI
import Charts
import Observation


extension Date {
    static func from(year: Int, month: Int, day: Int) -> Date {
        let components = DateComponents(year: year, month: month, day: day)
        return Calendar.current.date(from: components)!
    }
    
}
enum ExpenseCategory: String, CaseIterable {
    case food, entertainment, bill, utility
}

class ExpenseTotalModel: Identifiable, Equatable {
    static func == (lhs: ExpenseTotalModel, rhs: ExpenseTotalModel) -> Bool {
        lhs.total > rhs.total
    }
    
    
    var id = UUID()
    var name: String
    var category: ExpenseCategory
    var list: [ExpenseModel] = []
    var color: Color
    var percentage: Double = 0.0

    
    var total: Double {
        var total = 0.0
        for expense in list {
            total += expense.amount
        }
        return total
    }
    
    var percentageTotal:Double {
        let manager = BudgetManager()
        var expenseTotal = 0.0
        for expense in manager.allExpenses {
            expenseTotal += expense.amount
        }
        
        return total/expenseTotal * 100
    }
    

    init(id: UUID = UUID(), name: String, expenseCategory: ExpenseCategory, color: Color) {
        self.id = id
        self.name = name
        self.category = expenseCategory
        self.color = color
        
        
    }
}

class ExpenseModel: Identifiable {
    var id = UUID()
    var name: String
    var category: ExpenseCategory
    var amount: Double
    var dateCreated: Date = Date()
    var color: Color
    
    init(id: UUID = UUID(), name: String, expense: ExpenseCategory, amount: Double, dateCreated: Date, color: Color = .red) {
        self.id = id
        self.name = name
        self.category = expense
        self.amount = amount
        self.dateCreated = dateCreated
    
        switch expense {
        case .food:
            self.color = .orange
        case .entertainment:
            self.color = .red
        case .bill:
            self.color = .blue
        case .utility:
            self.color = .purple
      
        }
    }
}


@Observable class BudgetManager {
    
    var mostExpense: (String, Double) {
        var total = 0.0
        var totalName = ""
        
        for expense in allTotals {
            
            if expense.total > total {
                total = expense.total
                totalName = expense.category.rawValue
            }
           
        }
        return (totalName, total)
    }
    
    var allTotals:[ExpenseTotalModel] = [
        ExpenseTotalModel(name: "billTotal", expenseCategory: .bill, color: .blue),
        ExpenseTotalModel(name: "entertainmentTotal", expenseCategory: .entertainment, color: .red),
        ExpenseTotalModel(name: "utilityTotal", expenseCategory: .utility, color: .purple),
        ExpenseTotalModel(name: "foodTotal", expenseCategory: .food, color: .orange)
    ]

    var allExpenses:[ExpenseModel] = [
        ExpenseModel(name: "Water", expense: .utility, amount: 150, dateCreated: .from(year: 2024, month: 1, day: 10), color: .purple),
        ExpenseModel(name: "Rent", expense: .bill, amount: 600, dateCreated: .from(year: 2024, month: 1, day: 1), color: .blue),
        ExpenseModel(name: "Aldi", expense: .food, amount: 210, dateCreated: .from(year: 2024, month: 1, day: 2), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 12, dateCreated: .from(year: 2024, month: 1, day: 15), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 6, dateCreated: .from(year: 2024, month: 1, day: 16), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 6, dateCreated: .from(year: 2024, month: 1, day: 17), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 15, dateCreated: .from(year: 2024, month: 1, day: 18), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 12, dateCreated: .from(year: 2024, month: 2, day: 15), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 6, dateCreated: .from(year: 2024, month: 2, day: 16), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 6, dateCreated: .from(year: 2024, month: 2, day: 17), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 15, dateCreated: .from(year: 2024, month: 2, day: 18), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 12, dateCreated: .from(year: 2024, month: 4, day: 15), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 6, dateCreated: .from(year: 2024, month: 4, day: 16), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 6, dateCreated: .from(year: 2024, month: 4, day: 17), color: .orange),
        ExpenseModel(name: "Lunch", expense: .food, amount: 15, dateCreated: .from(year: 2024, month: 4, day: 18), color: .orange),
        ExpenseModel(name: "lunch", expense: .food, amount: 950, dateCreated: .from(year: 2024, month: 4, day: 12), color: .brown),
        ExpenseModel(name: "Netflix", expense: .entertainment, amount: 22.20, dateCreated: .from(year: 2024, month: 4, day: 20), color: .red),
        ExpenseModel(name: "Rent", expense: .bill, amount: 600, dateCreated: .from(year: 2024, month: 2, day: 1), color: .blue),
        ExpenseModel(name: "Meijer", expense: .food, amount: 310, dateCreated: .from(year: 2024, month: 3, day: 2), color: .orange),
        ExpenseModel(name: "Rent", expense: .bill, amount: 600, dateCreated: .from(year: 2024, month: 3, day: 1), color: .blue),
        ExpenseModel(name: "Netflix", expense: .entertainment, amount: 22.20, dateCreated: .from(year: 2024, month: 3, day: 20), color: .red),
        ExpenseModel(name: "Rent", expense: .bill, amount: 600, dateCreated: .from(year: 2024, month: 4, day: 1), color: .blue),
        ExpenseModel(name: "Meijer", expense: .food, amount: 210, dateCreated: .from(year: 2024, month: 4, day: 10), color: .orange),
        ExpenseModel(name: "Rent", expense: .bill, amount: 700, dateCreated: .from(year: 2024, month: 5, day: 1), color: .blue)
      

    ]
    func findMonthlyTotal() {
        for expense in allExpenses {
            switch expense.category {
            case .bill:
                allTotals[0].list.append(expense)
            case .entertainment:
                allTotals[1].list.append(expense)
            case .utility:
                allTotals[2].list.append(expense)
            case .food:
                allTotals[3].list.append(expense)
                
            }
        }
    }
}



struct ExpenseDemoView: View {
    
    @State private var isShowingExpenseView = false
    @State private var isShowingSummaryView = false
   
    @State var budgetManager = BudgetManager()
    
    init() {
        budgetManager.findMonthlyTotal()
        
    }
    
    var maxExpenseData: ExpenseTotalModel? {
        budgetManager.allTotals.max{ $0.total > $1.total }
    }

    var body: some View {
        
        VStack {
            Text("Expense Tracker")
                .font(.largeTitle)
                .bold()
            
            HStack {
                
                Button {
                    isShowingExpenseView.toggle()
                } label: {
                    Text("Add Expense")
                }
                
                Button {
                    isShowingSummaryView.toggle()
                } label: {
                    Text("Summary")
                }
            }
            .buttonStyle(.borderedProminent)
            
  
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text("2024 Breakdown")

                    Text("Total Spending: $\(String(format: "%.2f", budgetManager.allTotals.reduce(0, { $0 + $1.total}) ))")
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    Chart(budgetManager.allTotals) { expense in
                        
                        RuleMark(y: .value("Goal", 1000))
                            .foregroundStyle(.black.opacity(0.2))
                            .opacity(0.2)

                        BarMark(x: .value("Name", expense.name),
                                y: .value("Amount", expense.total))
                        .foregroundStyle(by: .value("Name", expense.category.rawValue))
                        .annotation {
                            Text("\(String(format: "%.2f", expense.total))")
                                .font(.caption)
                            
                        }
                        
                    }
                    
                    .background(.gray.opacity(0.1))
                    .frame(height: 100)
                    .padding()
                    .chartXAxis(.hidden)
                    
                    
                    Chart(budgetManager.allExpenses) { expense in
 

                        BarMark(x: .value("Name", expense.dateCreated),
                                y: .value("Amount", expense.amount))

//                        .annotation {
//                            Text("\(String(format: "%.2f", expense.amount))")
//                                .font(.caption)
//                            
//                        }
                        
                    }
                    
                    .background(.gray.opacity(0.1))
                    .frame(height: 100)
                    .padding()
                    
                    
  
                    

                    
                    HStack {
                        Image(systemName: "line.diagonal")
                            .rotationEffect(Angle(degrees: 45))
                            .foregroundColor(.black)
                        Text("Limit")
                    }
                    .font(.caption2)
                    
                }
            ScrollView {
             
                ForEach(budgetManager.allExpenses.sorted(by: { $0.dateCreated > $1.dateCreated})) { expense in
                    
                    HStack {
                      
                        VStack {
                            Text(expense.name)
                                .bold()
                            Text(expense.dateCreated.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                        Text("\(String(format: "%.2f", expense.amount))")
                            .bold()
                       
                            
                    }
                    .padding(.horizontal)
                    Rectangle()
                        .frame(height: 1)
                }
                
                
                
                

       
            }
        }
        .padding()
        .sheet(isPresented: $isShowingExpenseView, content: {
            AddExpenseView(budgetManager: budgetManager)
        })
        .sheet(isPresented: $isShowingSummaryView, content: {
            SummaryView(budgetManager: budgetManager)
        })
    }
}

#Preview {
    ExpenseDemoView()
}
