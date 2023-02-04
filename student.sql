

CREATE TABLE `student` (
  `id` int(10) NOT NULL,
  `name` varchar(50) NOT NULL,
  `ssc` varchar(10) NOT NULL,
  `hsc` varchar(10) NOT NULL,
  `aggregate` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO `student` (`id`, `name`, `ssc`, `hsc`, `aggregate`) VALUES
(1, 'david', '81', '90', '85'),
(2, 'tim', '87', '75', '80'),
(3, 'mark', '90', '70', '80'),
(4, 'tony', '50', '90', '80'),
(5, 'robert', '60', '80', '70'),
(6, 'jhonson', '95', '65', '90'),
(7, 'chris', '50', '70', '60'),
(8, 'danny', '80', '50', '65'),
(9, 'ravi', '75', '65', '70'),
(10, 'howard', '80', '30', '80'),
(11, 'leon', '70', '70', '70'),
(12, 'kennedy', '40', '80', '60'),
(13, 'mark', '70', '90', '80'),
(14, 'andrew', '6', '95', '80'),
(15, 'annie', '50', '70', '60'),
(16, 'rebecca', '35', '75', '45'),
(17, 'ryan', '42', '52', '47'),
(18, 'ray', '60', '34', '62'),
(19, 'sabastian', '33', '79', '76'),
(20, 'lucifer', '40', '50', '45'),
(21, 'asif', '61', '69', '65'),
(22, 'rohit', '40', '70', '55'),
(23, 'marie', '41', '49', '45'),
(24, 'dennis', '60', '66', '65'),
(25, 'cooper', '91', '100', '95');

ALTER TABLE `student`
  ADD PRIMARY KEY (`id`);