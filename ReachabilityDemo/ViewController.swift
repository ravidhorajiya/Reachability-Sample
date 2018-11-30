import UIKit
import Reachability

class ViewController: UIViewController {
  
  fileprivate var isConnected = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    ReachabilityManager.shared.addListener(listener: self as NetworkStatusListener)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    ReachabilityManager.shared.removeListener(listener: self as NetworkStatusListener)
  }
  
  func changeBackgroundColor() {
    view.backgroundColor = isConnected ? .green : .red
  }
}

extension ViewController: NetworkStatusListener {
  
  func networkStatusDidChange(status: Reachability.Connection) {
    switch status {
    case .none:
      debugPrint("Network became unreachable")
    case .wifi:
      changeBackgroundColor()
      debugPrint("Network reachable through WiFi")
    case .cellular:
      changeBackgroundColor()
      debugPrint("Network reachable through Cellular Data")
    }
    isConnected = status == .none ? false : true
    changeBackgroundColor()
  }
}

