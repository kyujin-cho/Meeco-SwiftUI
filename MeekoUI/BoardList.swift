//
//  Boards.swift
//  MeekoUI
//
//  Created by Kyujin Cho on 7/19/19.
//  Copyright © 2019 Kyujin Cho. All rights reserved.
//

import SwiftUI

let boards: [MeecoBoard] = [
    MeecoBoard(id: "news", name: "IT 뉴스"),
    MeecoBoard(id: "mini", name: "미니기기/IT"),
    MeecoBoard(id: "free", name: "자유 게시판"),
    MeecoBoard(id: "gallery", name: "갤러리"),
    MeecoBoard(id: "market", name: "장터 게시판"),
    MeecoBoard(id: "humor", name: "유머 게시판"),
]

let boardData: [MeecoSection] = [
    MeecoSection(name: "커뮤니티", boards: boards)
]

struct BoardList: View {
    var body: some View {
        NavigationView {
            List {
                ForEach(boardData.identified(by: \.name)) { section in
                    Section(header: Text(section.name)) {
                        ForEach(section.boards) { board in
                            NavigationLink(destination: ArticleList(boardName: board.name, boardId: board.id)) {
                                Text(board.name)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("게시판")
        }
    }
}

struct BoardList_Preview: PreviewProvider {
    static var previews: some View {
        BoardList()
    }
}
