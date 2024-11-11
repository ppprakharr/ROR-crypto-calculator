import React, { Component } from "react";
import "../../assets/stylesheets/application.css"

class Search extends Component{
    constructor(props){
        super(props)

    }

    render(){
        console.log(this.props.searchResults);
        const searchResult = this.props.searchResults.map(curr => (
            <li
              key={curr.id}
              data-id={curr.id}
              onClick={(e) => this.props.handleSelect(e, curr.id)}  // Arrow function to ensure binding
              className="currency-list-item"
            >
              <a href="javascript:void(0)" className="currency">
                <span>{curr.name}</span>
                <span className="currency-symbol">{curr.currency_symbol}</span>
              </a>
            </li>
          ));
          
        return(
            <div>
                <h1>Cryptocurrency Portfolio Calculator</h1>
                <form>
                    <div className="form-group">
                        <label>Search for a currency:</label><br/>
                        <input onChange={this.props.handleChange} autoComplete="off" type="text" name="name" placeholder="Eg. Bitcoin, Etherium, shibuInu.." value={this.props.name} className="field"/>
                    </div>
                    <div className="currency-list">
                       {searchResult}
                    </div>
                </form>
            </div>
        )
    }
}


export default Search