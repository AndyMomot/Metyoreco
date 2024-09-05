//
//  ViewController.swift
//  Metyoreco
//
//  Created by Andrii Momot on 05.09.2024.
//

import UIKit
import SwiftUI

final class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        showSwiftUIView()
    }
}

private extension RootViewController {
    func showSwiftUIView() {
        // Создаем новый UIHostingController с TabBarView
        let swiftUIViewController = UIHostingController(rootView: RootContentView())
        
        // Добавляем новый контроллер как дочерний
        addChild(swiftUIViewController)
        view.addSubview(swiftUIViewController.view)
        swiftUIViewController.didMove(toParent: self)
        
        // Настраиваем ограничения для tabBarViewController
        swiftUIViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            swiftUIViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            swiftUIViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            swiftUIViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            swiftUIViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}
