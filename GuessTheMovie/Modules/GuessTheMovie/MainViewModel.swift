//
//  MainViewModel.swift
//  GuessTheMovie
//
//  Created by Ahmed Ramy on 07/12/2021.
//

import Combine

public protocol MainViewModelProtocol: BaseViewModel {
    var movie: CurrentValueSubject<String, Never> { get }
    var answers: CurrentValueSubject<[String], Never> { get }
    var router: MainRouterProtocol? { get set }
    
    func didSelect(index: Int)
}

public final class MainViewModel: BaseViewModel, MainViewModelProtocol {
    public private(set) var movie: CurrentValueSubject<String, Never> = .init("")
    public private(set) var answers: CurrentValueSubject<[String], Never> = .init([])
    public var router: MainRouterProtocol?
    public var correctAnswerIndex: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        fetchMovieWithAnswers()
    }
    
    public func didSelect(index: Int) {
        index == correctAnswerIndex ? router?.showSuccessAlert() : router?.showFailureAlert()
    }
}

private extension MainViewModel {
    func fetchMovieWithAnswers() {
        isLoading.send(true)
        Repository
            .main
            .network
            .call(api: MoviesEndpoint.fetchMovies, model: [Movie].self)
            .sink(receiveCompletion: { [weak self] onComplete in
                guard let self = self else { return }
                self.isLoading.send(false)
                guard case let(resultedError) = onComplete else { return }
                self.error.send(resultedError)
            }, receiveValue: { [weak self] movies in
                guard let self = self else { return }
                self.isLoading.send(false)
                guard let randomMovie = movies.randomElement() else { return }
                let title = randomMovie.name
                let movieTitleParts = title.components(separatedBy: " ")
                let correctAnswer = movieTitleParts.randomElement() ?? ""
                
                let generatedTitle = title.replacingOccurrences(of: correctAnswer, with: "....")
                self.movie.send(generatedTitle)
                
                let answers = randomMovie.wrongAnswers + [correctAnswer]
                self.answers.send(answers.shuffled())
            }).store(in: &cancellables)
    }
}
