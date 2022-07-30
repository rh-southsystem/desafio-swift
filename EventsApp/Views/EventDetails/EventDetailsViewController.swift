//
//  EventDetailsViewController.swift
//  EventsApp
//
//  Created by Rodrigo Ryo Aoki on 29/07/22.
//

import UIKit
import RxCocoa
import RxSwift

class EventDetailsViewController: UIViewController {

	// MARK: - Properties
	
	private var viewModel: EventDetailsViewModelProtocol?
	private var outputHandler: ((EventDetailsViewController.Output) -> Void)?
	
	private var bag = DisposeBag()
	
	private var scrollView: UIScrollView = {
		var view = UIScrollView()
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var scrollContentView: UIStackView = {
		var view = UIStackView()
		
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private var imageView: UIImageView = {
		var view = UIImageView()
		
		view.contentMode = .scaleAspectFill
		view.image = UIImage(named: "placeHolder")
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	private var detailsCard: DetailsCard = {
		var view = DetailsCard()
		
		view.translatesAutoresizingMaskIntoConstraints = false
		
		return view
	}()
	
	private var descriptionLabel: UILabel = {
		var view = UILabel()
		
		view.font = .systemFont(ofSize: 18)
		view.textColor = .gray
		
		return view
	}()
	
	// MARK: - Init
	
	required init(viewModel: EventDetailsViewModelProtocol,
				  outputHandler: @escaping (EventDetailsViewController.Output) -> Void) {
		super.init(nibName: nil, bundle: nil)
		
		self.viewModel = viewModel
		self.outputHandler = outputHandler
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Output
	
	enum Output {
		case close
	}
	
	// MARK: - Overrides
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.view.backgroundColor = .systemRed
		
		setupView()
    }
}

extension EventDetailsViewController: ComponentCreation {
	func buildViewHierarchy() {
		view.addSubview(scrollView)
		scrollView.addSubview(scrollContentView)
		
		scrollContentView.addArrangedSubview(imageView)
		scrollContentView.addArrangedSubview(detailsCard)
		scrollContentView.addArrangedSubview(descriptionLabel)
	}
	
	func setupConstraints() {
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			
			scrollContentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
			scrollContentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			scrollContentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			
			imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2),
		])
	}
	
	func setupAdditionalConfiguration() {
		
	}
}

private extension EventDetailsViewController {
	func subEvent() {
		viewModel?.event?.subscribe({ [weak self] (event) in
			self?.detailsCard.dateLabel.text = event.element?.date
			self?.detailsCard.localLabel.text = event.element?.local
			self?.detailsCard.titleLabel.text = event.element?.title
			self?.detailsCard.priceLabel.text = String(event.element?.price ?? 0)
			self?.descriptionLabel.text = event.element?.description
			
			self?.title = event.element?.title
		}).disposed(by: bag)
	}
}
