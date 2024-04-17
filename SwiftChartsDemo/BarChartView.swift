import Foundation
import SwiftUI
import Charts


var pieData: [PieData] = [
    .init(category: "A", categoryPercentage: 10, color: .blue),
    .init(category: "B", categoryPercentage: 68, color: .green),
    .init(category: "C", categoryPercentage: 20, color: .orange),
    .init(category: "D", categoryPercentage: 38, color: .brown),
    .init(category: "E", categoryPercentage: 98, color: .red),
    .init(category: "F", categoryPercentage: 58, color: .cyan),
    .init(category: "G", categoryPercentage: 77, color: .yellow)
]


class PieData: Identifiable {
    let id = UUID()
    let category: String
    let categoryPercentage: Int
    
    var color: Color
    
    var angle: Double {
        
        
        var midSectorAngle = 0.0
        let total = pieData.reduce(0, { $0 + $1.categoryPercentage }) // needed to compute angles
        var partialTotal = 98
        
        midSectorAngle = Double(partialTotal) + Double(categoryPercentage) / 2
        midSectorAngle *= 2 * Double.pi / Double(total)
        
        return midSectorAngle
    }
    
    init(category: String, categoryPercentage: Int, color: Color) {
        self.category = category
        self.categoryPercentage = categoryPercentage
        self.color = color
    }
}

struct ContentsView: View {
    
  

    var angles: [Double] {
        var computedAngles = [Double]()
        var midSectorAngle = 0.0
        let total = pieData.reduce(0, { $0 + $1.categoryPercentage }) // needed to compute angles
        var partialTotal = 0
        
        for data in pieData {
            midSectorAngle = Double(partialTotal) + Double(data.categoryPercentage) / 2
            midSectorAngle *= 2 * Double.pi / Double(total)
            computedAngles.append(midSectorAngle)
            partialTotal += data.categoryPercentage
        }
        return computedAngles
    }
    
    var body: some View {
        
      
            Chart(pieData) { data in
                SectorMark(angle: .value("Pie Chart", data.categoryPercentage),
                           angularInset: 1.7)
                .foregroundStyle(by: .value("Category", data.category))
                .cornerRadius (5)
                .annotation (position: .overlay) {
                    Text("\(data.categoryPercentage)%")
                        .bold()
                        .position(x: 145+75*sin(data.angle), y: 140-75*cos(data.angle))
                }
                // .offset(x: 200, y: 20) // If here it would rotate sectors !
            }
            .frame(width: 300, height: 300)
            .position(x: 200, y: 400)
      
    }
}

#Preview {
    ContentsView()
}
