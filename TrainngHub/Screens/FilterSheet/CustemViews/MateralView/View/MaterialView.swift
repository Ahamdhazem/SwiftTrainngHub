
import Foundation
import UIKit

class MaterialView: UIView {



    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: FilterCollectionView!




    var viewModel: MaterialViewModel! {
        didSet {
            restoreSelection()
        }
    }




    override func awakeFromNib() {
        super.awakeFromNib()

        setupCollectionView()
        cellRegistration()
    }



    private func setupCollectionView() {

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.allowsMultipleSelection = true
    }



    private func cellRegistration() {

        let nib = UINib(
            nibName: "FilterCell",
            bundle: nil
        )

        collectionView.register(
            nib,
            forCellWithReuseIdentifier: FilterCell.identifier
        )
    }


     func restoreSelection() {

        guard let viewModel = viewModel else {
            return
        }

        let indexPaths = viewModel.tempSelection.map {
            $0.indexpath
        }

        collectionView.restoreSelection(indexPaths as! [IndexPath])
    }
}




extension MaterialView: UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {

        return viewModel.materialType.count
    }


    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FilterCell.identifier,
            for: indexPath
        ) as! FilterCell

        cell.configer(
            viewModel.materialType[indexPath.item]
        )

        return cell
    }
}



extension MaterialView: UICollectionViewDelegate {

    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {



        if indexPath.item == 0 {

            viewModel.clearFilter()

        }


        else {

            viewModel.appendQuery(indexPath)
        }



        self.collectionView.handleSelection(
            at: indexPath
        )
    }


    func collectionView(
        _ collectionView: UICollectionView,
        didDeselectItemAt indexPath: IndexPath
    ) {



        viewModel.removeQuery(indexPath)



        if viewModel.tempSelection.isEmpty {

            self.collectionView.selectDefault()
        }
    }


    func collectionView(
        _ collectionView: UICollectionView,
        shouldDeselectItemAt indexPath: IndexPath
    ) -> Bool {



        if indexPath.item == 0 {

            return false
        }

        return true
    }
}




extension MaterialView: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {

        return CGSize(
            width: 100,
            height: 50
        )
    }


    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {

        return 5
    }


    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {

        return 8
    }


    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {

        return UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 40
        )
    }
}

