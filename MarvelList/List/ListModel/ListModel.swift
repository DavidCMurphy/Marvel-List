//
//  ListModel.swift
//  MarvelList
//
//  Created by David Murphy on 08/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit

protocol ListModelProtocol: class {
    
    associatedtype Base
    associatedtype Item
    associatedtype Cell: UITableViewCell
    
    var title: String { get }
    var result: Dynamic<Base> { get }
    var loading: Dynamic<Bool> { get }
    
    func results() -> [Item]?
    func configureCell( _ cell: Cell, _ item: Item )
    func cellSelected( _ item: Item ) -> UIViewController
}

class AnyListModel<Base, Item, Cell: UITableViewCell>: ListModelProtocol {

    let title: String
    let result: Dynamic<Base>
    let loading: Dynamic<Bool>
    
    let resultsClosure: () -> [Item]?
    let cellClosure: (Cell, Item) -> Void
    let selectClosure: (Item) -> UIViewController
    
    let urlString: String
    let fetchable: AnyFetch<Base>
    
    init<M: ListModelProtocol, F: FetchProtocol>( _ url: String, _ model: M, _ fetch: F)
        where M.Base == Base, M.Item == Item, M.Cell == Cell, F.T == M.Base {
        title = model.title
        result = model.result
        resultsClosure = model.results
        loading = model.loading
        cellClosure = model.configureCell
        selectClosure = model.cellSelected
        fetchable = AnyFetch( fetch )
        urlString = url
    }
    
    func results() -> [Item]? {
        return resultsClosure()
    }
    
    func configureCell( _ cell: Cell, _ item: Item) {
        cellClosure( cell, item )
    }

    func cellSelected( _ item: Item ) -> UIViewController {
        return selectClosure( item )
    }
    
    func reload() {
        loading.value = true
        fetchable.fetch( urlString, Base.self) { [weak self] result in
            self?.loading.value = false
            switch(result) {
            case Result.success( let res ):
                self?.result.value = res
                return
            case Result.failure( _ ):
                return
            }
        }
    }
}
