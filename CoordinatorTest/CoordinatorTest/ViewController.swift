//
//  ViewController.swift
//  CoordinatorTest
//
//  Created by Hyun Lee on 5/28/24.
//

import UIKit

class ViewController: UIViewController, Storyboarded{
    var coordinator: MainCoordinator?

    private lazy var contentStack: UIStackView = {
      let contentStack = UIStackView()
        contentStack.distribution = .fillEqually
        contentStack.axis = .vertical
        contentStack.spacing = 20
        contentStack.translatesAutoresizingMaskIntoConstraints = false
        return contentStack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        
    }
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        setNavigationBar()
    }
    
    private func prepareUI() {
        title = "Screen 1"
        view.backgroundColor = .white
        
        let secondVCButton = createButton(title: "Go to SecondVC", color: .systemBlue, action: #selector(goToSecondVC))
        let thirdVCButton = createButton(title: "Go to ThirdVC", color: .systemGreen, action: #selector(goToThirdVC))
        
        contentStack.addArrangedSubview(secondVCButton)
        contentStack.addArrangedSubview(thirdVCButton)
     
        view.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            contentStack.heightAnchor.constraint(equalToConstant: 180),
            contentStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            contentStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .red
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func createButton(title: String, color:UIColor, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = color
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    @objc private func goToSecondVC() {
        coordinator?.buySubscription()
    }
    
    @objc private func goToThirdVC() {
        coordinator?.createAccount()
    }
    
}

