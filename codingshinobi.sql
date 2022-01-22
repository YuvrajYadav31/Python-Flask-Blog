-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2022 at 03:49 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingshinobi`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `sno` int(20) NOT NULL,
  `name` text NOT NULL,
  `phone_no` varchar(13) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `email` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`sno`, `name`, `phone_no`, `msg`, `date`, `email`) VALUES
(1, 'first post', '1234567890', 'first post', '2021-12-27 18:04:53', 'first@gmail.com'),
(61, 'hunny ', '1134568554', 'hi', '2022-01-16 16:12:27', 'hi@gmail.com'),
(71, 'hunny ', '8802910601', 'hi', '2022-01-19 20:39:51', 'hunny456@gmail.com'),
(72, 'hunny ', '9882224404', 'hi', '2022-01-21 13:47:12', 'hunny456@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `description` text NOT NULL,
  `date` datetime NOT NULL,
  `code` varchar(5000) NOT NULL,
  `language` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `description`, `date`, `code`, `language`) VALUES
(1, 'create a flask app within just 2 minutes', 'Flask App', 'first-Post', 'Flask is a web framework, it’s a Python module that lets you develop web applications easily. \r\nIt’s has a small and easy-to-extend core: it’s a microframework that doesn’t include an ORM \r\n(Object Relational Manager) or such features.\r\nIt does have many cool features like url routing, template engine. It is a WSGI web app\r\n framework. and In this post I, m gonna show you, how to  create a flask app.\r\nA minimal Flask application looks something like this:', 'So what did that code do?\r\n\r\nFirst we imported the Flask class. An instance of this class will be our WSGI application.\r\nNext we create an instance of this class. The first argument is the name of the application’s\r\n module or package. __name__ is a convenient shortcut for this that is appropriate for\r\n most cases. This is needed so that Flask knows where to look for resources such as templates\r\n and static files.\r\nWe then use the route() decorator to tell Flask what URL should trigger our function.\r\nThe function returns the message we want to display in the user’s browser. The default content\r\n type is HTML, so HTML in the string will be rendered by the browser.\r\nSave it as hello.py or something similar. Make sure to not call your application flask.py because \r\nthis would conflict with Flask itself.', '2022-01-19 22:48:16', 'from flask import Flask\r\n\r\napp = Flask(__name__)\r\n\r\n@app.route(\"/\")\r\ndef hello_world():\r\n    return (\"Hello, World!\")', 'Python'),
(2, 'how to create a Snake, water and gun game.', 'Python Project', 'second-post', 'Snake Water Gun is one of the famous two-player game played by many people. It is a hand \r\ngame in which the player randomly chooses any of the three forms i.e. snake, water, and gun.\r\n Here, we are going to implement this game using python. \r\n\r\nThis python project is to build a game for a single player that plays with the computer \r\n\r\nWe will use random.choice() method and nested if-else statements to select a random item from a list.\r\nBelow is the implementation:\r\n', 'Following are the rules of the game:\r\n\r\nSnake vs. Water: Snake drinks the water hence wins.\r\nWater vs. Gun: The gun will drown in water, hence a point for water\r\nGun vs. Snake: Gun will kill the snake and win.\r\n\r\nIn situations where both players choose the same object, the result will be a draw.', '2022-01-19 22:51:37', '#import random module\r\nimport random\r\n\r\n# Snake Water Gun Game\r\ndef gameWin(comp, you):\r\n    # If two values are equal, declare a tie!\r\n    if comp == you:\r\n        return None\r\n\r\n    # Check for all possibilities when computer chose snake\r\n    elif comp == \'snake\':\r\n        if you==\'water\':\r\n            return False\r\n        elif you==\'gun\':\r\n            return True\r\n    \r\n    # Check for all possibilities when computer chose water\r\n    elif comp == \'water\':\r\n        if you==\'gun\':\r\n            return False\r\n        elif you==\'snake\':\r\n            return True\r\n    \r\n    # Check for all possibilities when computer chose gun\r\n    elif comp == \'gun\':\r\n        if you==\'snake\':\r\n            return False\r\n        elif you==\'water\':\r\n            return True\r\n\r\nprint(\"Comp Turn: Snake, Water, or Gun?\")\r\nrandNo = random.randint(1, 3) \r\nif randNo == 1:\r\n    comp = \'snake\'\r\nelif randNo == 2:\r\n    comp = \'water\'\r\nelif randNo == 3:\r\n    comp = \'gun\'\r\n\r\nyou = input(\"Your Turn: Snake, Water, or Gun?\")\r\na = gameWin(comp, you)\r\n\r\nprint(f\"Computer chose {comp}\")\r\nprint(f\"You chose {you}\")\r\n\r\nif a == None:\r\n    print(\"The game is a tie!\")\r\nelif a:\r\n    print(\"You Win!\")\r\nelse:\r\n    print(\"You Lose!\")', 'python'),
(3, 'Fixing an error jinja2.exceptions. TemplateNotFound: template.html in flask.', 'Jinja error', 'third-post', 'Flask raises TemplateNotFound error even though template file exists.\r\n So, the solution for this problem is you just have to implement template_folder=\"template\" \r\nin your app. Just like this:\r\napp = Flask(__name__, template_folder=\"template\" )', 'I hope this code will be  helpful to those, who were facing this\r\nerror again and again.  ', '2022-01-19 23:24:25', 'from flask import Flask, render_template\r\napp = Flask(__name__, template_folder=\"template\")\r\n\r\n\r\n@app.route(\"/\")\r\ndef template_test():\r\n    return render_template(\'template.html\'])\r\n\r\nif __name__ == \'__main__\':\r\n    app.run(debug=True)', 'Python'),
(5, 'Create a digital clock using JS only.', 'JS Project', 'new-post-2', 'Clocks are useful element for any UI if used in a proper way. Clocks can be used in sites where\r\ntime is the main concern like some booking sites or some app showing arriving times of train, \r\nbuses, flights, etc. Clock is basically of two types, Analog and Digital. We will be looking at making\r\na digital one.\r\n\r\nApproach: The approach is to use the date object to get time on every second\r\nand then re-rendering time on the browser using the new time that we got by calling the same\r\nfunction each second.\r\n\r\n', 'Use this code in any HTML file, Paste this code above the end body tag between]\r\n <script></script>\r\nlike this:\r\n<script>\r\ncode{\r\n}\r\n</body>\r\n', '2022-01-20 00:56:41', '<script>\r\n        let a;\r\n        let date;\r\n        let time;\r\n        const options = { weekday: \'long\', year: \'numeric\', month: \'long\', \r\n        day: \'numeric\', };\r\n        setInterval(() => {\r\n         a =  new Date();\r\n         date = a.toLocaleDateString(undefined,options)\r\n         time = a.getHours() + \':\' + a.getMinutes() +\':\'+ a.getSeconds()  \r\n        document.getElementById(\'time\').innerHTML = time + \"<br> on \" \r\n+ date;    }, 1000);\r\n\r\n    </script>', 'JavaScript'),
(19, 'create a simple stack bootstrap form with a Checkbox.', 'bootstrap form', 'sixth-post', 'Simple Stacked bootstrap form.', 'All textual <input> and  <textarea> elements with class .form-control get proper form styling:', '2022-01-20 01:09:30', '<!DOCTYPE html>\r\n<html lang=\"en\">\r\n<head>\r\n  <title>Bootstrap Example</title>\r\n  <meta charset=\"utf-8\">\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\r\n  <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\">\r\n  <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js\"></script>\r\n</head>\r\n<body>\r\n\r\n<div class=\"container mt-3\">\r\n  <h2>Stacked form</h2>\r\n  <form action=\"/action_page.php\">\r\n    <div class=\"mb-3 mt-3\">\r\n      <label for=\"email\">Email:</label>\r\n      <input type=\"email\" class=\"form-control\" id=\"email\" placeholder=\"Enter email\" name=\"email\">\r\n    </div>\r\n    <div class=\"mb-3\">\r\n      <label for=\"pwd\">Password:</label>\r\n      <input type=\"password\" class=\"form-control\" id=\"pwd\" placeholder=\"Enter password\" name=\"pswd\">\r\n    </div>\r\n    <div class=\"form-check mb-3\">\r\n      <label class=\"form-check-label\">\r\n        <input class=\"form-check-input\" type=\"checkbox\" name=\"remember\"> Remember me\r\n      </label>\r\n    </div>\r\n    <button type=\"submit\" class=\"btn btn-primary\">Submit</button>\r\n  </form>\r\n</div>\r\n\r\n</body>\r\n</html>', 'HTML');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `sno` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
