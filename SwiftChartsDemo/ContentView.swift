//
//  ContentView.swift
//  SwiftChartsDemo
//
//  Created by Nick Gordon on 3/27/24.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    var productManager = ProductManager()
    
    var body: some View {
        
        ScrollView {
            VStack {
        
                Text("Product Ratings Reviews")
                    .font(.largeTitle)
                    .bold()

   
                        Chart {
                            ForEach(productManager.products) { product in
                                
                              
                                    BarMark(
                                        
                                        x: .value("Title", "\(product.title)"),
                                        y: .value("Rating", product.rating)
                                    )
                                    .foregroundStyle(product.rating < 4.5 ? .red : .green)
                                    .annotation {
                                        Text("\(product.rating, specifier: "%.2f")")
                                            .foregroundStyle(Color.black)
                                        
                                    }
                                
                                RuleMark(
                                    y: .value("Thresgold", 4.5)
                                )
                                .foregroundStyle(.black)
                            
                                
                    }
                }
                        .chartScrollableAxes(.horizontal)
                        .scaleEffect(1.5)
                        .padding(.bottom, 100)
                
                
                
                
                        
                Chart {
                    ForEach(productManager.products) { product in
                        
                      
                        AreaMark(
                                
                                x: .value("Title", "\(product.title)"),
                                y: .value("Rating", product.rating)
                            )
                        .foregroundStyle(product.rating < 4.5 ? .red : .green)
                            
            }
        }
                //.chartScrollableAxes(.horizontal)
               // .scaleEffect(1.5)
                
            }
            .onAppear(perform: {
                Task {
                    await productManager.downLoadProducts()
                }
            })
        }
    }
}

#Preview {
    ContentView()
}
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
