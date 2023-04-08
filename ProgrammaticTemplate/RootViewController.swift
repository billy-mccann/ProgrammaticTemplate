//
//  RootViewController.swift
//  ProgrammaticTemplate
//
//  Created by Bill McCann on 4/6/23.
//

import UIKit

class RootViewModel {
  var viewController: RootViewController?
  func listenForUpdates(){}
}

class RootViewController: UIViewController {
  
  let topLabel = UILabel()
  let viewModel = RootViewModel()
  let topSixthOfSafeSpace = UILayoutGuide()
  let middleQuarterOfSafeSpace = UILayoutGuide()

  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupGuides()
    addChildViewWith(backgroundColor: .systemCyan, layoutGuide: topSixthOfSafeSpace)
    addChildViewWith(backgroundColor: .systemMint, layoutGuide: middleQuarterOfSafeSpace)
    addTopLabel()
    
    viewModel.viewController = self
    viewModel.listenForUpdates()
  }
  
  private func setupGuides() {
    view.addLayoutGuide(topSixthOfSafeSpace)
    view.addLayoutGuide(middleQuarterOfSafeSpace)
    
    topSixthOfSafeSpace.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    topSixthOfSafeSpace.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/6).isActive = true
    topSixthOfSafeSpace.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    topSixthOfSafeSpace.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    
    middleQuarterOfSafeSpace.topAnchor.constraint(equalTo: topSixthOfSafeSpace.bottomAnchor, constant: 10).isActive = true
    middleQuarterOfSafeSpace.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/4).isActive = true
    middleQuarterOfSafeSpace.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
    middleQuarterOfSafeSpace.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
  }
  
  private func addChildViewWith(backgroundColor: UIColor, layoutGuide: UILayoutGuide) {
    let childView = UIView()
    childView.translatesAutoresizingMaskIntoConstraints = false
    childView.backgroundColor = backgroundColor
    childView.clipsToBounds = true
    self.view.addSubview(childView)
    
    childView.topAnchor.constraint(equalTo: layoutGuide.topAnchor).isActive = true
    childView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor).isActive = true
    childView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor).isActive = true
    childView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor).isActive = true
    
    childView.layer.cornerRadius = 10.0
  }
  
  private func addTopLabel(){}
}

