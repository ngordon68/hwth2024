//
//  JsonDecoder.swift
//  SwiftChartsDemo
//
//  Created by Nick Gordon on 3/28/24.
//

import Foundation
import Observation

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
    
    /*
     "id": 1,
     "title": "iPhone 9",
     "description": "An apple mobile which is nothing like apple",
     "price": 549,
     "discountPercentage": 12.96,
     "rating": 4.69,
     "stock": 94,
     "brand": "Apple",
     "category": "smartphones",
     "thumbnail": "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg",
     "images": [
       "https://cdn.dummyjson.com/product-images/1/1.jpg",
       "https://cdn.dummyjson.com/product-images/1/2.jpg",
       "https://cdn.dummyjson.com/product-images/1/3.jpg",
       "https://cdn.dummyjson.com/product-images/1/4.jpg",
       "https://cdn.dummyjson.com/product-images/1/thumbnail.jpg"
     ]
     */
    
}




@Observable class ProductManager {
    
    var products:[ProductModel] = []
    
    var products2:[ProductModel] = []
    
    var products3:[ProductModel] = []
    
    var products4:[ProductModel] = []
   
    
    func downLoadProducts() async {
        
        print("start download")
        let urlString = "https://dummyjson.com/products"
        
        let jsonDecoder = URL(string: urlString)
        
        do {
            
            if let url = URL(string: urlString) {
                if let data = try? Data(contentsOf: url) {
                    guard let result = try? JSONDecoder().decode(Products.self, from: data) else { return }
                    
                   let newResult = result.products
//                    
                    products = newResult
//                    products2 = newResult[1]
//                    products3 = newResult[2]
//                    products4 = newResult[3]
                    print(products.count)
                    
                    print("data :\(data)")
                }
            }
        }
        catch {
            print("cannot parse data")
        }
        
       // let result = JSONDecoder
        
        //let result = try await URLSession.shared.decode(ProductModel.self, from: jsonDecoder)
        
        //let blogPost: BlogPost = try! JSONDecoder().decode(BlogPost.self, from: jsonData)
        
   

        
        
//        let url1 = URL(string: "https://hws.dev/user-24601.json")!
//        let user = try await URLSession.shared.decode(User.self, from: url1)
//        print("Downloaded \(user.name)")
    }
    
}
