var webpack = require("webpack");
var path = require('path');
var fs = require('fs');
var cfg = {
	devtool: 'source-map',
	module: {
		rules: [
			{ test: /\.coffee$/, use: "coffee-loader"},
			{ test: /\.glsl$/, use: "glsl-template-loader" },
			{ test: /\.(xml|html|txt|md)$/, loader: "raw-loader" },
			{ test: /\.(less)$/, use: ['style-loader','css-loader','less-loader'] },
			{ test: /\.(woff|woff2|eot|ttf|svg)$/,loader: 'url-loader?limit=65000' }
		]
	},
	entry: {
		main: "./source/tile-grid-util.coffee",
	},
	output: {
		path: path.join(__dirname,"..","/dist/"),
		filename: "tile-grid-util.js",
		library: 'Slide',
		libraryTarget: 'umd'
	}
}
module.exports = cfg;