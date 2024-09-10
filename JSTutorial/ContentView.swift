//
//  ContentView.swift
//  JSTutorial
//
//  Created by 황인성 on 9/7/24.
//

import SwiftUI


//struct ContentView: View {
//    var body: some View {
//        VStack {
//            if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
//                let url = URL(fileURLWithPath: htmlPath)
//                WebView(url: url)
//                    .edgesIgnoringSafeArea(.all) // WebView를 전체화면에 맞추기
//            } else {
//                Text("로컬 HTML 파일을 찾을 수 없습니다.")
//            }
//        }
//    }
//}

struct ContentView: View {
    
//    let htmlPath = Bundle.main.path(forResource: "index", ofType: "html")!
    let url = URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!)
    let webView = WebView(request: URLRequest(url: URL(fileURLWithPath: Bundle.main.path(forResource: "index", ofType: "html")!)))
    
    var body: some View {
        VStack {
            webView
                .padding(5)
                .background(.yellow)
                .frame(height: 400)
            
            Button("Call JavaScript Function") {
                webView.callJS()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
