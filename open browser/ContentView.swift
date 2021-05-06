//
//  ContentView.swift
//  open browser
//
//  Created by Salman Ahmed on 27/04/2021.
//

import SwiftUI
import WebKit
import SafariServices


struct ContentView: View {
    // whether or not to show the Safari ViewController
    @State var showSafari = false
    
    // initial URL string
    @State var urlString = "https://afternoon-scrubland-98993.herokuapp.com/"
    
    var body: some View {
        // Webview method
//        Webview(url: URL(string: urlString)!)
        
        // SafariView method
        Button(action: {
            // tell the app that we want to show the Safari View Controller
            self.showSafari = true
        }) {
            Text("Show Safari tab")
        }
        // open Safari tab
        .sheet(isPresented: $showSafari) {
            SafariView(url:URL(string: self.urlString)!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Webview: UIViewRepresentable {
    let url: URL

    func makeUIView(context: UIViewRepresentableContext<Webview>) -> WKWebView {
        let webview = WKWebView()

        let request = URLRequest(url: self.url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        webview.load(request)

        return webview
    }

    func updateUIView(_ webview: WKWebView, context: UIViewRepresentableContext<Webview>) {
        var request = URLRequest(url: self.url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
        
        request.setValue("Bearer hello1", forHTTPHeaderField: "access-token")
        request.setValue("Bearer hello2", forHTTPHeaderField: "refresh-token")

        webview.load(request)
    }
}

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }

}
