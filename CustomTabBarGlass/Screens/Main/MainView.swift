//

import SwiftUI

struct MainView: View {
    @State private var activeTab: CustomTabType = .home
    
    var body: some View {
       TabView(selection: $activeTab) {
           Tab.init(value: .home) {
               Text("Home")
                   .toolbarVisibility(.hidden, for: .tabBar)
           }
           Tab.init(value: .notifications) {
               Text("Notifications")
                   .toolbarVisibility(.hidden, for: .tabBar)
           }
           Tab.init(value: .settings) {
               Text("Settings")
                   .toolbarVisibility(.hidden, for: .tabBar)
           }
        }
       .safeAreaInset(edge: .bottom) {
           CustomTapBarView()
       }
    }
    
    @ViewBuilder
    func CustomTapBarView() -> some View {
        VStack {
            GlassContainerIfAvailable {
                HStack(spacing: 10) {
                    GeometryReader {
                        CustomTabBar(size: $0.size, activeTab: $activeTab) { tab in
                            TabCellView(tab: tab)
                        }
                        .glassEffectCapsule()
                    }
//                    ZStack {
//                        ForEach(CustomTab.allCases, id: \.rawValue) {
//                            tab in
//                            Image(systemName: tab.actionSymbol)
//                                .font(.title3)
//                                .blurFade(activeTab == tab)
//                        }
//                    }
//                    .frame(width: 55, height: 55)
//                    .glassEffectCapsule()
//                    .animation(.smooth(duration: 0.55, extraBounce: 0), value: activeTab)
                }
                .frame(height: 58)
            }
            .padding(.horizontal, 54)
        }
    }
}


#Preview {
    MainView()
}

