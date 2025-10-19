//
//  ViewController.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var searchBar: UISearchBar!
    
    @IBOutlet private weak var bookmarkButton: UIButton!
    
    // MARK: - Properties
    private var viewModel: ArticlesViewModel?
    private var articles: Articles = []
    private var filteredArticles: Articles = []
    private let refreshControl = UIRefreshControl()
    
    private var bookmarkViewModel: BookmarkViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        bindViewModel()
    }
    
    @IBAction func bookmarksButtonTapped(_ sender: Any) {
        let bookmarksVC: BookmarksViewController = BookmarksViewController.loadFromNib()
        navigationController?.pushViewController(bookmarksVC, animated: true)
    }
}

private extension ViewController {
    func setUpUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: "ArticleCell", bundle: nil),
            forCellReuseIdentifier: "ArticleCell"
        )
        searchBar.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshArticles), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func bindViewModel() {
        viewModel = ArticlesViewModel()
        viewModel?.fetchArticles()
        
        viewModel?.onFetchUpdated = { [weak self] news in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.articles = news.articles
                self.applySearchFilter()
                self.refreshControl.endRefreshing()
            }
        }
        
        viewModel?.onFailed = { [weak self] error in
            print(error)
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
            }
        }
        
        bookmarkViewModel = BookmarkViewModel()
    }
    
    @objc func refreshArticles() {
        viewModel?.fetchArticles()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else {
            return UITableViewCell()
        }
        let isBookmarked = bookmarkViewModel?.isBookmarked(filteredArticles[indexPath.row]) ?? false
        cell.configure(
            with: filteredArticles[indexPath.row],
            isBookmarked: isBookmarked
        )
        cell.onBookmarkTapped = { [weak self] in
            guard let self else { return }
            self.bookmarkViewModel?.toggleBookmark(for: filteredArticles[indexPath.row])
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension ViewController: UISearchBarDelegate {
    func applySearchFilter() {
        if let searchText = searchBar.text, !searchText.isEmpty {
            filteredArticles = articles.filter {
                $0.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        } else {
            filteredArticles = articles
        }
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        applySearchFilter()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

