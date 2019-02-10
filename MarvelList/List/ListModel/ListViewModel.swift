//
//  ListViewModel.swift
//  MarvelList
//
//  Created by David Murphy on 08/02/2019.
//  Copyright © 2019 David Murphy. All rights reserved.
//

import UIKit

class ListViewModel: ListModelProtocol {

    typealias Base = Response
    typealias Item = MCharacter
    typealias Cell = CharacterCell
    
    let title: String = "Characters"
    let loading: Dynamic<Bool> = Dynamic( false )
    let result: Dynamic<Base> = Dynamic( nil )

    func results() -> [Item]? {
        return result.value?.data.results
    }
    
    func configureCell(_ cell: Cell, _ item: Item) {
        cell.characterImageView.setRemoteImageWithAnimation(url: item.thumbnail.image_url)
        cell.characterName.text = item.name
    }
}
