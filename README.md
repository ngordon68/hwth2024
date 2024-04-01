# Getting Started with Xcode and SwiftUI

Today we're going to implement SwiftCharts to build an application to visualize product review data.

# Prior Knowledge/Installation
 - [Xcode 15.0 or newer](https://developer.apple.com/xcode/) which can be found on the App Store on the Mac
 - Basic knowledge of Swift and SwiftUI
 - [Dummy JSON](https://dummyjson.com/products) Data to use


### Step 1 Let's begin a struct that will download the JSON data:

```
import Foundation
struct Products: Codable {
    var products:[ProductModel]
}

struct ProductModel: Codable, Identifiable {
    var id : Int
    var title: String
    var description: String
    var price: Int
    var discountPercentage: Double
    var rating: Double
    var stock: Int
    var brand: String
    var category: String
    var thumbnail: String
    var images: [String]
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



