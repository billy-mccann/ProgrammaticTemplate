import UIKit
import RxSwift
import RxCocoa

class RootViewController: UIViewController {
  
  // MARK: - Private
  // UI
  private let nextVCButton = UIButton()
  private let topLabel = UILabel()
  private let topSixthOfSafeSpace = UILayoutGuide()
  private let middleQuarterOfSafeSpace = UILayoutGuide()
  
  // Binding Requirements
  private var viewModel: RootViewModeling = RootViewModel()
  let disposeBag = DisposeBag()

  // MARK: - Overrides
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupGuides()
    addChildView(childView: nextVCButton, backgroundColor: .systemMint, layoutGuide: middleQuarterOfSafeSpace)
    addChildView(childView: topLabel, backgroundColor: .systemCyan, layoutGuide: topSixthOfSafeSpace)
    topLabel.textAlignment = .center
    nextVCButton.addTarget(self, action: #selector(showViewController), for: .touchUpInside)
    
    bindViewModel(viewModel: viewModel)
  }
  
  private func setupGuides() {
    view.addLayoutGuide(topSixthOfSafeSpace)
    view.addLayoutGuide(middleQuarterOfSafeSpace)
    
    topSixthOfSafeSpace.topAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
      .isActive = true
    topSixthOfSafeSpace.heightAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/6)
      .isActive = true
    topSixthOfSafeSpace.leadingAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
      .isActive = true
    topSixthOfSafeSpace.trailingAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
      .isActive = true
  
    middleQuarterOfSafeSpace.topAnchor
      .constraint(equalTo: topSixthOfSafeSpace.bottomAnchor, constant: 10)
      .isActive = true
    middleQuarterOfSafeSpace.heightAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/4)
      .isActive = true
    middleQuarterOfSafeSpace.leadingAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
      .isActive = true
    middleQuarterOfSafeSpace.trailingAnchor
      .constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
      .isActive = true
  }
  
  private func addChildView(childView: UIView, backgroundColor: UIColor, layoutGuide: UILayoutGuide) {
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
  
  // MARK: - ViewModel stuff
  
  @objc private func showViewController(_ sender: UIButton) {
    
    if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }), let navigationController = keyWindow.rootViewController as? UINavigationController {
        // do something
      let blueVC = BlueViewController()
      navigationController.show(blueVC, sender: self)
    }
  }
  
  private func bindViewModel(viewModel: RootViewModeling) {
    disposeBag.insert(
      viewModel.labelText.bind(to: topLabel.rx.text),
      viewModel.nextVCButtonText.bind(to: (nextVCButton.rx.title()))
    )
    viewModel.listenForUpdates()
  }
}

