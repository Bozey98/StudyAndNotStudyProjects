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
    
    @Binding var number: Int
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: [UIPageViewController.OptionsKey.interPageSpacing : 10])
        
        
        pageViewController.setViewControllers([controllers[number]], direction: .forward, animated: true)
        
        pageViewController.view.backgroundColor = .none
        
        
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
        
        
        
        
        
        
    }
}

