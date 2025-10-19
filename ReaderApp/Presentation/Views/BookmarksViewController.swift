//
//  BookmarksViewController.swift
//  ReaderApp
//
//  Created by Prashanth on 20/10/25.
//

import UIKit

class BookmarksViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var noBookmarksLbl: UILabel!
    
    private let bookmarkViewModel = BookmarkViewModel()
    private var bookmarkedArticles: Articles = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Bookmarks"
        setupTableView()
        observeBookmarks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bookmarkViewModel.loadBookmarks()
    }
    
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

private extension BookmarksViewController {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
    }
    
    func observeBookmarks() {
        bookmarkViewModel.onBookmarksUpdated = { [weak self] articles in
            self?.bookmarkedArticles = articles
            self?.noBookmarksLbl.isHidden = !articles.isEmpty
            self?.tableView.reloadData()
        }
    }
}

extension BookmarksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarkedArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        let article = bookmarkedArticles[indexPath.row]
        cell.configure(with: article, isBookmarked: true)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
