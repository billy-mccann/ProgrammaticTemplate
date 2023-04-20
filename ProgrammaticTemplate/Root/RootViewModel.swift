import Foundation
import RxRelay

protocol RootViewModeling {
  var labelTextRelay: BehaviorRelay<String> { get }
  func listenForUpdates()
}

class RootViewModel: RootViewModeling {
  let labelTextRelay = BehaviorRelay(value: "Label")

  // TODO: - Put timer on different runloop level
  func listenForUpdates(){
    var num = 0
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [self]_ in
      num += 1
      labelTextRelay.accept("New Label \(num)")
    })
  }
}
