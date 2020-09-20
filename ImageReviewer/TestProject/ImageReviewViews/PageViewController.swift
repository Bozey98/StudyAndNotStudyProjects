//
//  PageViewController.swift
//  TestProject
//
//  Created by Денис Мусатов on 14.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct PageViewController: UIViewControllerRepresentable {
    
    @EnvironmentObject var previewHider: PreviewHider
    
    var controllers: [UIViewController]
    
    @State private var pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.interPageSpacing : 10])
    
    @Binding var number: Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        
        pageViewController.setViewControllers([controllers[number]], direction: .forward, animated: true)
        
        pageViewController.view.backgroundColor = .none
        
        let pan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handlePan(sender:)))

        pageViewController.view.addGestureRecognizer(pan)
        
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        
        
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        //uiViewController.setViewControllers([controllers[0]], direction: nil, animated: true)
        
            
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    
    class Coordinator: NSObject, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        var parent: PageViewController
        
        init(_ parent: PageViewController) {
            self.parent = parent
        }
        
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            
            if index == 0 {
                
                return parent.controllers.last
                
            }
            
            
        
            return parent.controllers[index - 1]
        }
        
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else {
                return nil
            }
            
           
            if index == parent.controllers.count - 1 {
                
                return parent.controllers.first
                
            }
            
            return parent.controllers[index + 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if finished,
                let visibleViewController = pageViewController.viewControllers?.first,
                let index = parent.controllers.firstIndex(of: visibleViewController) {
                    
                parent.number = index
                    
            }
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
            print("Heh")
        }
        
        
        @objc func handlePan(sender: UIPanGestureRecognizer) {
            print(sender.translation(in: self.parent.pageViewController.view).y)
            guard let gestureView = sender.view else {
                return
            }
            
            let dragOffset = sender.translation(in: gestureView).y
            
            gestureView.frame.origin.y = dragOffset
            
            UIView.animate(withDuration: 1, animations: {
                self.parent.previewHider.showBackground = false
            })
            
            if sender.state == .began {
                
            }
            
//            gestureView.center = CGPoint(
//                x: gestureView.center.x,
//                y: gestureView.center.y + dragOffset
//            )
            
            if sender.state == .ended {
                if abs(dragOffset) > UIScreen.main.bounds.height / 5 {
                    self.parent.previewHider.showReviewView = false
                } else {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.parent.previewHider.showBackground = true
                        sender.setTranslation(.zero, in: self.parent.pageViewController.view)
                        gestureView.frame.origin.y = sender.translation(in: self.parent.pageViewController.view).y
                    })
                }
                
                
                

            }
            
        }
        
        
    }
}

