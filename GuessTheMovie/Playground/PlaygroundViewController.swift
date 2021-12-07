//
// This is free and unencumbered software released into the public domain.
// 
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
// 
// THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
// 
// For more information, please refer to <https://unlicense.org>
//
//
//  PlaygroundViewController.swift
//  RamySDK
//
//  Created by Ahmed Ramy on 05/04/2021.
//

import UIKit

#if !RELEASE
//let uiModel = LocalVerificationUIDataModel(
//  supportedMethods: [
//    LocalVerificationMethodsUIDataModel(name: "Biometric", icon: .url("https://upload.wikimedia.org/wikipedia/commons/a/a0/%D7%94%D7%9C%D7%95%D7%92%D7%95_%D7%A9%D7%9C_%D7%9E%D7%A2%D7%A8%D7%9B%D7%AA_%D7%94%D6%BEFace_ID.jpg"), onTap: {
//      ServiceLocator.shared.auth.verifyUserLocally(preferredMethod: .biometric) { (results) in
//        switch results {
//        case .success:
//          print("ew3a da5al".tagWith(.internal))
//        case let .failure(error):
//          switch error {
//          case InternalError.iOSCantAuthenticateUserLocally:
//            print("7elw")
//          default:
//            print("error")
//          }
//        }
//      }
//    }),
//    LocalVerificationMethodsUIDataModel(
//      name: "Pin",
//      icon: .url("https://upload.wikimedia.org/wikipedia/commons/a/a0/%D7%94%D7%9C%D7%95%D7%92%D7%95_%D7%A9%D7%9C_%D7%9E%D7%A2%D7%A8%D7%9B%D7%AA_%D7%94%D6%BEFace_ID.jpg"),
//      onTap: {
//        ServiceLocator.shared.auth.verifyUserLocally(preferredMethod: .pin) { (results) in
//          switch results {
//          case .success:
//            print("ew3a da5al".tagWith(.internal))
//          case let .failure(error):
//            switch error {
//            case InternalError.iOSCantAuthenticateUserLocally:
//              print("7elw")
//            default:
//              print("error")
//            }
//          }
//        }
//      }
//    ),
//  ]
//)
//let builder = LocalVerificationUIBuilder(uiModel: uiModel)

final class PlaygroundViewController: BaseViewController {
  public let scrollView = ScrollView().then {
    $0.clipsToBounds = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let uiModel = StaticUIDataModel(
      sections: [
        StaticSectionUIDataModel(
          elements: [
            StaticSectionElementUIDataModel(
              type: .text(
                .init(
                  .body,
                  "How's it going?",
                  .title
                )
              )
            )
          ],
          header: .init(
            .headline,
            "Hi 🙌",
            .title
          )
        )
      ]
    )

    let builder = StaticUIBuilder(uiModel: uiModel)
    let renderedView = builder.build()
    
    self.view.addSubview(self.scrollView)
    
    self.scrollView.snp.remakeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.top.equalTo(self.view.safeArea.top)
      $0.bottom.equalToSuperview()
    }
    
    self.scrollView.scrollableContentView = renderedView
  }
}
#endif
