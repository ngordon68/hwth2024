
# Getting Started with Xcode and SwiftUI

[Swift Chart Conference Slides](https://docs.google.com/presentation/d/1LGkjZa4aKqXasEaKGJzSvfrTcwMkS9Tj1DljkrkTkAk/edit#slide=id.g7e92ecccc8_1_36)

Today we're going to implement Swift Charts to build an expense tracking application.

# Prior Knowledge/Installation
 - [Xcode 15.0 or newer](https://developer.apple.com/xcode/) which can be found on the App Store on the Mac
 - Basic knowledge of Swift and SwiftUI


# User Story
- As a working class citizen with bad spending habits, I would like to see how much I spend
- As a working class citizen with bad spending habits, I like to see a breakdown of my spending
- As a working class citizen with bad spending habits, I like to see which category I spent the most 
  


# Expected Outcome
<img width="300px; height: 500px;" alt="Screen Shot 2023-02-16 at 11 50 11 AM" src="https://github.com/ngordon68/hwth2024/assets/102773701/f80f4479-c773-4098-ac76-2e1a752786f9">
<img width="300px; height: 500px;" alt="Screen Shot 2023-02-16 at 11 50 11 AM" src="https://github.com/ngordon68/hwth2024/assets/102773701/ac1a14c2-698c-4b9e-a664-f9c9bd611d6a">



   
### Step 1 Let's begin a model for our expense and expense totals:

```

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
        lhs.total == rhs.total
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


```
### Step 2 We will make an Observable Class that will manage our expenses:
``` 
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

```

### Step 3. Display list of expenses 

```
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
```


> [!TIP]
>  display numbers with only 2 decimals.
> ```
> Text("\(String(format: "%.2f", expense.amount))")
> ```
# Resources

- [Swift Charts Documentation](https://developer.apple.com/documentation/charts)
- [Swift Charts Youtube Tutorial](https://www.youtube.com/watch?v=c9XxDjmLT24&t=5356s)
- [Benia(good friend/great developer](https://www.linkedin.com/search/results/all/?fetchDeterministicClustersOnly=true&heroEntityKey=urn%3Ali%3Afsd_profile%3AACoAADQtd9gBUT-7ZyIaVlitqprHiReWzGIOoRI&keywords=benia%20morgan-ware&origin=RICH_QUERY_SUGGESTION&position=0&searchId=778e2cfd-8784-4931-ae9c-31125442ae19&sid=vNp&spellCorrectionEnabled=false)

- [Linda Lewi)](https://www.linkedin.com/in/linda-lewis-35262333/)


