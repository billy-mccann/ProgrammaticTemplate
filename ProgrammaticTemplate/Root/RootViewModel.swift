import Foundation
import RxSwift


class RootViewModel {
  let viewController: RootViewControllable
  let disposeBag = DisposeBag()
  let labelTextBehaviorSubject = BehaviorSubject(value: "Label")

  init(viewController: RootViewControllable) {
    self.viewController = viewController
  }
  
  func bind(){
    labelTextBehaviorSubject
      .subscribe(onNext:
        { [self] text in
        viewController.topLabel.text = text }
      )
      .disposed(by: disposeBag)
  }

  func listenForUpdates(){
    var num = 0
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self]_ in
      num += 1
      labelTextBehaviorSubject.on(.next("New Label \(num)"))
    })
  }
}
