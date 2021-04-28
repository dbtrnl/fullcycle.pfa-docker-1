const express = require('express');
const morgan = require('morgan');
const mysql = require('mysql2');

const app = express();

app.use(morgan('dev'));

app.listen(3000, () => {
	console.info("\n----\nNodeJS running on port 3000\n----")
});

const db = mysql.createConnection({
	host: 'pfa-mysql',
	user: 'root',
	password: 'mysql',
	database: 'fc',
	charset: 'utf8'
});

db.connect((error) => {
	if (error) {
		console.error(error);
		process.exit(1);
	}
	console.log('Database connection established!\n----\n');
	return db;
});

app.get('/fc_modules', (req, res) => {
	// db.query('SET NAMES utf8mb4', (err, results, fields) => { });
	db.query(
		'SELECT * FROM `fc_modules`;', (err, results, fields) => { res.status(200).json(results); }
	);
});

app.get('/', (req, res) => {
	res.status(200).json("Tente o endpoint /fc_modules...");
});