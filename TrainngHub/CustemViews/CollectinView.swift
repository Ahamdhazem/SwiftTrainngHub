
import Foundation

import UIKit

class FilterCollectionView: UICollectionView {

    let defaultSelectionIndex = IndexPath(item: 0, section: 0)

    override func awakeFromNib() {
        super.awakeFromNib()
        allowsMultipleSelection = true
    }


    func handleSelection(at indexPath: IndexPath) {
        

        if indexPath == defaultSelectionIndex {

            for selectedIndexPath in indexPathsForSelectedItems ?? [] {

                if selectedIndexPath != defaultSelectionIndex {

                    deselectItem(
                        at: selectedIndexPath,
                        animated: true
                    )
                }
            }

        } else {


            deselectItem(
                at: defaultSelectionIndex,
                animated: true
            )
        }
    }



    func deselectAll() {

        guard let selectedIndexPaths = indexPathsForSelectedItems else {
            return
        }

        for indexPath in selectedIndexPaths {

            deselectItem(
                at: indexPath,
                animated: false
            )
        }
    }



    func selectDefault() {

        deselectAll()

        selectItem(
            at: defaultSelectionIndex,
            animated: false,
            scrollPosition: []
        )
    }



    func restoreSelection(_ indexPaths: [IndexPath]) {


        deselectAll()
        if indexPaths.isEmpty {

            selectDefault()
            return
        }

        for indexPath in indexPaths {

            selectItem(
                at: indexPath,
                animated: false,
                scrollPosition: []
            )
        }
    }
}

