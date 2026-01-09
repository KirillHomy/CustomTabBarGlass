//


import SwiftUI

struct CustomTabBar<TabItemView: View>: UIViewRepresentable {
    
    var size: CGSize
    var activeTint: Color = .blue
    var barTint: Color = .gray.opacity(0.15)
    
    @Binding var activeTab: CustomTabType
    
    @ViewBuilder var tabItemView: (CustomTabType) -> TabItemView
    
    func makeCoordinator() -> Coordinator {
        Coordinator (parent: self)
    }
    
    func makeUIView (context: Context) -> UISegmentedControl {
        let items = CustomTabType.allCases.map(\.rawValue)
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = 0
        
        
        for (index, tab) in CustomTabType.allCases.enumerated() {
            let renderer = ImageRenderer(content: tabItemView(tab))
            renderer.scale = 2
            let image = renderer.uiImage
            
            control.setImage(image, forSegmentAt: index)
        }
        DispatchQueue.main.async {
            for subview in control.subviews {
                if subview is UIImageView && subview != control.subviews.last {
                    subview.alpha = 0
                }
            }
        }
        control.selectedSegmentTintColor = UIColor(barTint)
        control.setTitleTextAttributes([.foregroundColor : UIColor(activeTint)], for: .selected)
        control.setTitleTextAttributes([.foregroundColor : UIColor.gray], for: .normal)
        control.addTarget(context.coordinator, action: #selector(context.coordinator.tabselected(_:)), for: .valueChanged)
        return control
    }
    
    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, uiView: UISegmentedControl, context: Context) -> CGSize? {
        return size
    }
    
    class Coordinator: NSObject {
        
        var parent: CustomTabBar
        
        init(parent: CustomTabBar) {
            self.parent = parent
        }
        
        @objc func tabselected(_ control: UISegmentedControl) {
            parent.activeTab = CustomTabType.allCases[control.selectedSegmentIndex]
        }
    }

}
