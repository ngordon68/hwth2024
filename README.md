# Getting Started with Xcode and SwiftUI

Today we're going to implement Swift Charts to build an expense tracking application.

# Prior Knowledge/Installation
 - [Xcode 15.0 or newer](https://developer.apple.com/xcode/) which can be found on the App Store on the Mac
 - Basic knowledge of Swift and SwiftUI
   
### Step 1 Let's begin a model for our expense:

```
import Foundation

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



