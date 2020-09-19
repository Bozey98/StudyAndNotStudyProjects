//
//  NavView.swift
//  TestProject
//
//  Created by Денис Мусатов on 13.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

enum ViewRole {
    case root, child, equial
}


class NavViewModel: ObservableObject {
    
    @Published var currentView: ViewStackElement?
    
    private var viewStack = ViewStack() {
        didSet {
            currentView = viewStack.getLast()
            viewStack.views.forEach { el in
                print(el.id)
            }
        }
    }
    
    func push<Content: View>(view: Content, id: String? = nil, role: ViewRole? = nil) {
        let viewStackElement = ViewStackElement(
            id: id == nil ? UUID().uuidString : id!,
            view: AnyView(view),
            role: role == nil ? .equial : role!)
        
        viewStack.push(view: viewStackElement)
    }
    
    func pop() {
        viewStack.pop()
    }

    private struct ViewStack {
        var views: [ViewStackElement] = []
        
        func getLast() -> ViewStackElement? {
            views.last
        }
        
        mutating func push(view: ViewStackElement) {
            views.append(view)
        }
        
        mutating func pop() {
            _ = views.popLast()
        }
    }
}

struct ViewStackElement: Identifiable {
    let id: String
    let view: AnyView
    let role: ViewRole
}



struct NavView<Content: View>: View {
    
    @ObservedObject fileprivate var navViewModel = NavViewModel()
    
    var rootView : Content
    
    init(@ViewBuilder rootView: () -> Content ) {
        self.rootView = rootView()
        //self.navViewModel.push(view: AnyView(self.rootView), id: "root", role: .root)
        
    }
    
    var body: some View {
        
        
        
        
//        ZStack {
//            navViewModel.currentView?.view
//                .environmentObject(navViewModel)
//        }
        
        let isRoot = navViewModel.currentView == nil

        return ZStack {
            if isRoot {
                rootView
                    .environmentObject(navViewModel)
            } else {
                navViewModel.currentView?.view
                    .environmentObject(navViewModel)
            }
        }
        
        
    }
}

struct LinkButton<Content: View, Label: View>: View {
    
    @EnvironmentObject private var navViewModel: NavViewModel
    
    private let label: () -> Label
    private let destination: Content
    private let action: (() -> Void)?
    
    //@State private var customButtonStyle: PushButtonStyle?
    
    init(destination: Content, action: (() -> Void)? = nil, label: @escaping () -> Label) {
        self.destination = destination
        self.action = action
        self.label = label
    }
    
    var body: some View {
        
        Button(
            action: {
                if self.action != nil {
                    self.action!()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navViewModel.push(view: self.destination)
                }
                
            },
            label: label
        )
    }
    
}


struct BackButton<Label: View>: View {
    
    @EnvironmentObject private var navViewModel: NavViewModel
    
    private let label: () -> Label
    private let action: (() -> Void)?
    
    init(action: (() -> Void)? = nil, label: @escaping () -> Label) {
        
        self.action = action
        self.label = label
    }
    
    var body: some View {
        
        Button(
            action: {
                if self.action != nil {
                    self.action!()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navViewModel.pop()
                }
                
            },
            label: label
        )
    }
    
}


class SomeData: ObservableObject {
    var data = 100
}

