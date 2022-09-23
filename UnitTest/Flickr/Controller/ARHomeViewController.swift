//
//  LazyLoadingCollectionViewController.swift
//  ThemeSample
//
//  Created by Ashok Rawat on 11/05/22.
//

import Foundation
import UIKit

class ARHomeViewController: UIViewController {
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)
    private let itemsPerRow: CGFloat = 2
    
    let cellIdentifier = ARConstant.ARFlickrPhotoCell
    var flickrPhotoModel: ARFlickrPhotoModel?


    @IBOutlet weak var flickrCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        flickrCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        let flickrViewModel = ARFlickrViewModel()
        flickrViewModel.callFlickrPhotoAPI { model, error in
            if error == nil, model != nil {
                self.flickrPhotoModel = model
                DispatchQueue.main.async {
                    self.flickrCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension ARHomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrPhotoModel?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = flickrPhotoModel else {
            return UICollectionViewCell()
        }
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ARFlickrPhotoCell {
            cell.configureFlickrPhotoCell(model.items[indexPath.row])
            cell.addButtonTapAction = {
                self.performSegue(withIdentifier: ARConstant.FlickerDetailVC, sender: cell)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ARHomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
      ) -> CGSize {
          let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
          let availableWidth = view.frame.width - paddingSpace
          let widthPerItem = availableWidth / itemsPerRow
          return CGSize(width: widthPerItem, height: widthPerItem * 1.3)
      }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
      ) -> UIEdgeInsets {
        return sectionInsets
      }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
      ) -> CGFloat {
        return sectionInsets.left
      }
}

extension ARHomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: ARConstant.FlickerDetailVC, sender: collectionView.cellForItem(at: indexPath))
    }
}

extension ARHomeViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ARConstant.FlickerDetailVC {
            if let cell = sender as? UICollectionViewCell, let indexPath = self.flickrCollectionView.indexPath(for: cell), let controller = segue.destination as? ARDetailsViewController {
                controller.flickrItem = flickrPhotoModel?.items[indexPath.row]
            }
        }
    }
}

