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
### Step 2 We will make an Observable Class that will manage both downloading the data and populating the array of data:
``` 
import Foundation
import Observation


@Observable class ProductManager {
    
    var products:[ProductModel] = []

   
    
    func downLoadProducts() async {
        
        print("start download")
        let urlString = "https://dummyjson.com/products"
        
        
        let jsonDecoder = URL(string: urlString)
        
        do {
            
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    guard let result = try? JSONDecoder().decode(Products.self, from: data) else { return }
                    
                   let newResult = result.products
                    
                    products = newResult
                    print(products.count)
                    
                    print("data :\(data)")
                }
            }
        }
        catch {
            print("cannot parse data")
        }

    }
    
}
```



