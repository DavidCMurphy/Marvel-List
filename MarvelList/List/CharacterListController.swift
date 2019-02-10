//
//  ViewController.swift
//  MarvelList
//
//  Created by David Murphy on 06/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit


class CharacterListController<T, V, K: UITableViewCell>: UIViewController, UITableViewDataSource {
    
    let table = UITableView()
    let refresh = UIRefreshControl()
    let activity = UIActivityIndicatorView()
    let model: AnyListModel<T, V, K>
    
    init<M: ListModelProtocol, F: FetchProtocol>( _ url: String, _ list: M, _ fetch: F )
        where M.Base == T, M.Item == V, M.Cell == K, F.T == T {
        model = AnyListModel( url, list, fetch )
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = model.title
        
        table.dataSource = self
        
        // rough guess of cell height for the purposes of optimization
        table.estimatedRowHeight = ListImageHeight
        table.separatorStyle = .none
        table.refreshControl = refresh
        view.addSubview(table)
        table.attachToSuper()
        table.register(K.self, forCellReuseIdentifier: String( describing: K.self ))
        
        refresh.addTarget(self, action: #selector(reloadResults), for: .valueChanged)
        
        activity.hidesWhenStopped = true
        activity.style = .gray
        activity.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activity)

        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activity.startAnimating()
        
        model.reload()
        model.result.bind { [weak self] ( _ ) in
            self?.refresh.endRefreshing()
            self?.activity.stopAnimating()
            self?.table.reloadData()
        }
    }
    
    @objc func reloadResults() {
        model.reload()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.results()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String( describing: K.self ), for: indexPath)
        if let characterCell = cell as? K, let results = model.results() {
            let detail = results[indexPath.row]
            model.cellClosure( characterCell, detail )
        }
        return cell
    }
}
