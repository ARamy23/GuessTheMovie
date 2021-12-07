//
//  GuessTheMovieTests.swift
//  GuessTheMovieTests
//
//  Created by Ahmed Ramy on 07/12/2021.
//

import Nimble
import Quick
@testable import GuessTheMovie

/**
 * # What to test?
 * The app must ..
 * - [] Perform a network call to get the remote list of movies and decode the result: https://gist.githubusercontent.com/i0sa/f5b878c5a35386fda952c350fc53fce9/raw/186811752752d29fbf5ee5418065daa689593ff5/complete-movie-title.json
 * - [] Choose random movie and display it to the user a long with its four answers
 * - [] Hide a random word of movie's name, and use this hidden word as a correct answer
 * - [] Render the obfusticated movie title in the screen (Correct answer should be hidden in displayed movie title with ***** for example)
 * - [] Use the three wrong answers given in the Movie remote object
 * - [] The four answers should be displayed in random order
 * - [] Show an alert when the user selects an answer whether it was right or wrong
 */

class GuessTheMoviesTests: QuickSpec {
    override func spec() {
        describe("App") {
            context("Networking") {
                it("must fetch remote list of movies and parse them") {
                    XCTFail()
                }
            }
            
            context("Choosing the movie") {
                it("Chooses random movie & Random word") {
                    XCTFail()
                }
                
                it("Chooses random movie & Random word") {
                    XCTFail()
                }
                
                it("It randomize the Answers ordering") {
                    XCTFail()
                }
            }
            
            context("Presentation") {
                it("presents the question with random title being obfusicated") {
                    XCTFail()
                }
                
                it("must have at least 1 correct answer") {
                    XCTFail()
                }
                
                it("shows the user the success alert on success answer") {
                    XCTFail()
                }
                
                it("shows the user the false alert on false answer") {
                    XCTFail()
                }
            }
        }
    }
}
