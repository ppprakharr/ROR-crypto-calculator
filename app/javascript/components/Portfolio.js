import React, { Component } from "react";
import PortfolioItem from "./PortfolioItem";
class Portfolio extends Component{
    constructor(props){
        super(props)

    }

    render(){

        const portfolioItems = this.props.portfolio.map((item, index) => <PortfolioItem key = {index} item={item}/> )
        const total = this.props.portfolio.reduce((total, curr) => total + curr.value, 0)
        return(
            <div>
            <div className="portfolio-value">
                <div className="portfolio-value--total">Your total portfolio value is:</div>
                <div className="portfolio-value--total">{total}</div>
            </div>
            <div className="portfolio-items">
                {portfolioItems}
            </div>

            </div>
        )
    }
}

export default Portfolio