//


import SwiftUI

struct TabCellView: View {
    
    let tab: CustomTabType
    
    var body: some View {
        VStack(spacing: 3) {
            Image(systemName: tab.symbol)
                .font(.title3)
            Text(tab.rawValue)
                .font(.system(size:10))
                .fontWeight(.medium)
        }
        .symbolVariant(.fill)
        .frame(maxWidth: .infinity)
    }
}