# Getting Started with Xcode and SwiftUI

Today we're going to implement Swift Charts to build an expense tracking application.

# Prior Knowledge/Installation
 - [Xcode 15.0 or newer](https://developer.apple.com/xcode/) which can be found on the App Store on the Mac
 - Basic knowledge of Swift and SwiftUI
   
### Step 1 Let's begin a model for our expense and expense totals:

```
import Foundation

enum ExpenseCategory: String, CaseIterable {
    case food, entertainment, bill, utility, tax
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
        case .tax:
            self.color = .brown
        }
    }
}


class ExpenseTotalModel: Identifiable {
    
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


```
### Step 2 We will make an Observable Class that will manage our expenses:
``` 
import Foundation
import Observation

@Observable class BudgetManager {
    
    var allTotals:[ExpenseTotalModel] = [
        ExpenseTotalModel(name: "billTotal", expenseCategory: .bill, color: .blue),
        ExpenseTotalModel(name: "entertainmentTotal", expenseCategory: .entertainment, color: .red),
        ExpenseTotalModel(name: "utilityTotal", expenseCategory: .utility, color: .purple),
        ExpenseTotalModel(name: "taxTotal", expenseCategory: .tax, color: .brown),
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
        ExpenseModel(name: "Federal Tax", expense: .tax, amount: 950, dateCreated: .from(year: 2024, month: 4, day: 12), color: .brown),
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
            case .tax:
                allTotals[3].list.append(expense)
            case .food:
                allTotals[4].list.append(expense)
                
            }
        }
    }
}
```


#Resources


