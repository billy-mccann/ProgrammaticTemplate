import UIKit
import RxSwift
import RxCocoa

class RootViewController: UIViewController {
  
  // MARK: - Private
  // UI
  private let listenButton = UIButton()
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
    addChildViewWith(backgroundColor: .systemCyan, layoutGuide: topSixthOfSafeSpace)
    addChildViewWith(backgroundColor: .systemMint, layoutGuide: middleQuarterOfSafeSpace)
    addTopLabel()
    addListenButton()
    
    bindViewModel(viewModel: viewModel)
    addListenButton()
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
  
  // TODO: - add UIView as input param to this func, use for addTopLabel
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
  
  private func addTopLabel(){
    topLabel.translatesAutoresizingMaskIntoConstraints = false
    self.view.addSubview(topLabel)
    
    topLabel.topAnchor.constraint(equalTo: topSixthOfSafeSpace.topAnchor).isActive = true
    topLabel.bottomAnchor.constraint(equalTo: topSixthOfSafeSpace.bottomAnchor).isActive = true
    topLabel.leadingAnchor.constraint(equalTo: topSixthOfSafeSpace.leadingAnchor).isActive = true
    topLabel.trailingAnchor.constraint(equalTo: topSixthOfSafeSpace.trailingAnchor).isActive = true
    topLabel.textAlignment = .center
  }
  
  private func addListenButton() {
    self.viewModel.listenForUpdates()
  }
  
  // MARK: - ViewModel stuff
  private func bindViewModel(viewModel: RootViewModeling) {
    disposeBag.insert(
      viewModel.labelTextRelay.bind(to: topLabel.rx.text)
    )
  }
}

