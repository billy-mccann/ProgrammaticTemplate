import Foundation
import RxRelay

protocol RootViewModeling {
  
  var labelText: BehaviorRelay<String> { get }
  var nextVCButtonText: BehaviorRelay<String> { get }
  func listenForUpdates()
}

class RootViewModel: NSObject, RootViewModeling, URLSessionWebSocketDelegate {
  let labelText = BehaviorRelay(value: "Label")
  let nextVCButtonText = BehaviorRelay(value: "Go somewhere")
  
  // MARK: - Websocket stuff
  
  private var webSocket : URLSessionWebSocketTask?

  private func createSession() {
    //Session
    let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
    
    //Server API
    let url = URL(string: "wss://demo.piesocket.com/v3/channel_123?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self")
    
    //Socket
    webSocket = session.webSocketTask(with: url!)
    
    //Connect and handles handshake
    webSocket?.resume()
  }

    
  //MARK: - Receive
  private func receive(){
      let workItem = DispatchWorkItem{ [weak self] in
          self?.webSocket?.receive(completionHandler: { result in
              switch result {
              case .success(let message):
                  switch message {
                    case .data(let data):
                        print("1111 Data received \(data)")
                    case .string(let str):
                    print("1111 String received \(str)")
                    default:
                        break
                  }
              
              case .failure(let error):
                  print("1111 Error Receiving \(error)")
              }
              // Recurse to keep connection open
              self?.receive()
          })
      }
      DispatchQueue.global().asyncAfter(deadline: .now() + 1 , execute: workItem)
  }
  //MARK: - Send
  
  func send(){
      
  }
  //MARK: - Close Session
  
  @objc func closeSession(){
      
  }
  
  
  //MARK: - URLSESSION Protocols
  
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
      print("Connected to server")
  }
  
  func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
    print("Disconnect from Server \(String(describing: reason))")
  }
  
// MARK: - RootViewModeling functions
  
  func listenForUpdates(){
    self.createSession()
    self.receive()
    
    var num = 0
    let timer = Timer(timeInterval: 1.0, repeats: true, block: { [self]_ in
      num += 1
      labelText.accept("New Label \(num)")
    })
    RunLoop.main.add(timer, forMode: .common)
  }
}
