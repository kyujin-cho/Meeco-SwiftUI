//
//  NormalArticle.swift
//  MeekoUI
//
//  Created by Kyujin Cho on 7/22/19.
//  Copyright © 2019 Kyujin Cho. All rights reserved.
//

import SwiftUI
import Combine
import WebKit
  
struct WebView : UIViewRepresentable {
    var html: String
      
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
      
    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("Update called, html length: \(self.html.count)")
        uiView.loadHTMLString(html, baseURL: URL(string: "https://meeco.kr"))
    }
      
}

final class NormalArticleLoader: BindableObject {
    let willChange = PassthroughSubject<Void, Never>()
    let fetcher = Fetcher()
    
    var article: ArticleInfo = ArticleInfo() {
        willSet {
            willChange.send()
        }
    }
    
    func fetch(boardId: String, articleId: String) {
        fetcher.fetchArticle(boardId: boardId, articleId: articleId).done { article in
            self.article = article
        }
    }
}

struct NormalArticle: View {
    @ObjectBinding var loader = NormalArticleLoader()
    var boardId: String = ""
    var articleId: String = ""
    
    var body: some View {
        let article = loader.article
        return
            VStack {
                ScrollView {
                    WebView(html: decorateArticleHTML(article))
                }
            }.onAppear { self.fetch() }
    }
    
    func fetch() {
        loader.fetch(boardId: boardId, articleId: articleId)
    }
}
