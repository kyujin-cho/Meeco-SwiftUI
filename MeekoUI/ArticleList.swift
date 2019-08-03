//
//  ArticleList.swift
//  MeekoUI
//
//  Created by Kyujin Cho on 7/19/19.
//  Copyright © 2019 Kyujin Cho. All rights reserved.
//

import SwiftUI
import Combine

final class ArticleListLoader: BindableObject {
    let willChange = PassthroughSubject<Void, Never>()
    let fetcher = Fetcher()
    
    var articles: [NormalRowInfo] = [] {
        willSet {
            willChange.send()
        }
    }
    
    func fetch(boardId: String, categoryName: String, pageNum: Int) {
        fetcher.fetchNormal(boardId: boardId, categoryName: categoryName, pageNum: pageNum).done { response in
            var newArticles: [NormalRowInfo] = self.articles
            for row in response {
                newArticles.append(row)
            }
            self.articles = newArticles
        }
    }
}

struct ArticleList: View {
    var boardName = ""
    @State var boardId = ""
    @State var categoryName = ""
    @State var pageNum = 1
    @ObjectBinding private var articleListLoader = ArticleListLoader()
    
    var body: some View {
        List {
            ForEach(articleListLoader.articles.identified(by: \.articleId)) { article in
                NavigationLink(destination: NormalArticle(boardId: article.boardId, articleId: article.articleId)) {
                    Text(article.title)
                }
            }
            Rectangle()
                .onAppear {
                    print("End of scroll; articles: \(self.articleListLoader.articles.count)")
                    if self.articleListLoader.articles.count != 0 {
                        self.pageNum += 1
                        self.fetch()
                    }
                }
        }
        .navigationBarTitle(boardName)
        .onAppear(perform: fetch)
    }
    
    private func fetch() {
        articleListLoader.fetch(boardId: boardId, categoryName: categoryName, pageNum: pageNum)
    }
}

struct ArticleList_Preview: PreviewProvider {
    static var previews: some View {
        ArticleList(boardId: "mini", categoryName: "", pageNum: 1)
    }
}
