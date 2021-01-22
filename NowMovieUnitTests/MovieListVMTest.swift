//
//  MovieListVMTest.swift
//  NowMovieUnitTests
//
//  Created by NghiaTran on 22/01/2021.
//  Copyright © 2021 trungnghia. All rights reserved.
//

import Quick
import Nimble

@testable import NowMovie

class MovieListVMTest: QuickSpec {
    
    override func spec() {
        var viewModel: MovieListVM?
        
        describe("When being MovieListVM") {
            
            beforeEach {
                viewModel = MovieListVM(service: MockApiService())
            }
            
            context("we get list for now playing movie success") {
                it("Should return count is 2") {
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(0))
                    viewModel?.fetchMovies(type: .nowPlaying)
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(2))
                }
            }
            
            context("we get list for popular movie success") {
                it("Should return count is 3") {
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(0))
                    viewModel?.fetchMovies(type: .popular)
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(3))
                }
            }
            
            context("we get list for topRated movie success") {
                it("Should return count is 4") {
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(0))
                    viewModel?.fetchMovies(type: .topRated)
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(4))
                }
            }
            
            context("we get list for upcomming movie success") {
                it("Should return count is 5") {
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(0))
                    viewModel?.fetchMovies(type: .upcoming)
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(5))
                }
            }
            
            afterEach {
                let movieCount = viewModel?.movies.value.count
                let cell = MovieListCell()
                
                for i in 0..<movieCount! {
                    let movie = viewModel?.movieAtIndex(i)
                    cell.viewModel = MovieVM(movie: movie!)
                }
            }
            
        }
        
        
        describe("When being MovieListVM") {
            beforeEach {
                viewModel = MovieListVM(service: MockApiServiceFailed())
            }
            
            context("we get list for now playing movie unsuccess") {
                it("Should return count is 0") {
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(0))
                    viewModel?.fetchMovies(type: .nowPlaying)
                    expect(viewModel?.numberOfRowsInSection(0)).to(equal(0))
                }
            }
        }
    }
}
