const ExtractTextPlugin = require("extract-text-webpack-plugin");
module.exports = {

	entry: "./js/app.js",

	output: {
		filename: "js/app.js",
		path: "../priv/static"
	},
	resolve: {
		extensions: [".js",".vue",".json"]
	},
	plugins: [ 
		new ExtractTextPlugin({
		filename: "css/bundle.css"
	})],
	module: {
		rules: [
		{
			test: /\.vue$/,
			loader:"vue-loader",
			options:{
				loaders:{

					css: ExtractTextPlugin.extract({
						use: "css-loader",
						fallback: "vue-style-loader"
					}),

					scss: ExtractTextPlugin.extract({
						use: ["css-loader","sass-loader"],
						fallback: "vue-style-loader"
					})
				}
				
			}
		},
		{
			test: /\.css$/,
			loader: ExtractTextPlugin.extract(["style-loader","css-loader"])
		},
		{
			test: /\.scss$/,
			loader: ExtractTextPlugin.extract(["style-loader","css-loader","sass-loader"])
		},
		{
			test: /\.js$/,
			loader: "babel-loader",
			exclude: /node_modules/
		},
		{
			test: /\.(png|jpe?g|gif|svg)(\?.*)?$/,
			loader: "url-loader"
		},
		{
			test: /\.(woff2?|eot|ttf|otf)(\?.*)?$/,
			loader: "url-loader"
		}
		] //rules

	}, //module

}//module.exports
