////
////  ScrollableTabBar.swift
////  Weather
////
////  Created by Alexander Zarutskiy on 28.09.2023.
////
//
//import SwiftUI
//
//struct ScrollableTabBar<Content: View>: UIViewRepresentable {
//   
//    
//    
//    // to store SwiftUI View
//    var content: Content
//    
//    // Rect to calculate Width and Height of ScrollView
//    var rect: CGRect
//    
//    // Content offset
//    @Binding var offset: CGFloat
//    
//    // Tabs
//    var tabs: [Any]
//    
//    //Scrollable TabView
//    let scrollView = UIScrollView()
//    
//    init(tabs: [Any],rect: CGRect,offset: Binding<CGFloat>,@ViewBuilder content: () -> Content) {
//        self.content = content()
//        self._offset = offset
//        self.rect = rect
//        self.tabs = tabs
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        return ScrollableTabBar.Coordinator(parent: self)
//    }
//    
//    func makeUIView(context: Context) -> UIScrollView {
//        setUpScrollView()
//        // setting Content Size
//        
//        scrollView.contentSize = CGSize(width: rect.width * CGFloat(tabs.count), height: rect.height)
//        scrollView.addSubview(extractView())
//        scrollView.delegate = context.coordinator
//        return scrollView
//    }
//    
//    func updateUIView(_ uiView: UIViewType, context: Context) {
//    
//    }
//    
//    
//    // setting Up ScrollView
//    func setUpScrollView() {
//        
//        scrollView.isPagingEnabled = true
//        scrollView.bounces = false
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//    }
//    // Extracting SwiftUI View
//    func extractView() -> UIView {
//        let controller = UIHostingController(rootView: content)
//        controller.view.frame = CGRect(x: 0, y: 0, width: rect.width  * CGFloat(tabs.count), height: rect.height)
//        return controller.view!
//    }
//    
//    // Delegate function to get offset
//    
//    class Coordinator: NSObject, UIScrollViewDelegate {
//        var parent: ScrollableTabBar
//        init(parent: ScrollableTabBar) {
//            self.parent = parent
//        }
//        func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            parent.offset = scrollView.contentOffset.x
//        }
//    }
//}
//
//struct ScrollableTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
