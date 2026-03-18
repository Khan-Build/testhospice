-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 18, 2026 at 09:01 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital_ai_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `ai_decisions`
--

CREATE TABLE `ai_decisions` (
  `decision_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `assigned_action` varchar(100) NOT NULL,
  `allocated_facility_id` int(11) DEFAULT NULL,
  `allocated_staff_id` int(11) DEFAULT NULL,
  `reasoning_text` text NOT NULL,
  `decision_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ai_decisions`
--

INSERT INTO `ai_decisions` (`decision_id`, `encounter_id`, `assigned_action`, `allocated_facility_id`, `allocated_staff_id`, `reasoning_text`, `decision_timestamp`) VALUES
(1, 1, 'Nurse Visit', 2, 2, 'Medium risk, general ward available, nurse assigned', '2026-03-18 12:50:23'),
(2, 2, 'Admit to ICU', 1, 1, 'High risk, chest pain with low BP, critical care needed', '2026-03-18 12:50:23'),
(3, 3, 'Home Treatment', NULL, NULL, 'Low risk, mild symptoms, no resources needed', '2026-03-18 12:50:23'),
(4, 1, 'Nurse Visit', 2, 2, 'Medium risk, general ward available, nurse assigned', '2026-03-18 12:51:46'),
(5, 2, 'Admit to ICU', 1, 1, 'High risk, chest pain with low BP, critical care needed', '2026-03-18 12:51:46'),
(6, 3, 'Home Treatment', NULL, NULL, 'Low risk, mild symptoms, no resources needed', '2026-03-18 12:51:46');

-- --------------------------------------------------------

--
-- Table structure for table `ai_evaluations`
--

CREATE TABLE `ai_evaluations` (
  `evaluation_id` int(11) NOT NULL,
  `encounter_id` int(11) NOT NULL,
  `health_risk_level` enum('Low','Medium','High') NOT NULL,
  `ethics_priority_score` decimal(5,2) NOT NULL,
  `evaluated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ai_evaluations`
--

INSERT INTO `ai_evaluations` (`evaluation_id`, `encounter_id`, `health_risk_level`, `ethics_priority_score`, `evaluated_at`) VALUES
(1, 1, 'Medium', 65.00, '2026-03-18 12:49:26'),
(2, 2, 'High', 92.50, '2026-03-18 12:49:26'),
(3, 3, 'Low', 40.00, '2026-03-18 12:49:26');

-- --------------------------------------------------------

--
-- Stand-in structure for view `decision_dashboard`
-- (See below for the actual view)
--
CREATE TABLE `decision_dashboard` (
`first_name` varchar(50)
,`last_name` varchar(50)
,`health_risk_level` enum('Low','Medium','High')
,`ethics_priority_score` decimal(5,2)
,`assigned_action` varchar(100)
,`reasoning_text` text
,`decision_timestamp` timestamp
);

-- --------------------------------------------------------

--
-- Table structure for table `equipment_inventory`
--

CREATE TABLE `equipment_inventory` (
  `equipment_id` int(11) NOT NULL,
  `category` enum('Diagnostic','Surgical','Monitoring','Consumable','Bed/Ventilator') NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `total_quantity` int(11) NOT NULL,
  `available_quantity` int(11) NOT NULL,
  `location_facility_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `facilities`
--

CREATE TABLE `facilities` (
  `facility_id` int(11) NOT NULL,
  `facility_type` enum('ICU','Ward','ER','Operating Theatre','Isolation','Lab','Pharmacy') NOT NULL,
  `name` varchar(100) NOT NULL,
  `total_capacity` int(11) NOT NULL,
  `current_occupancy` int(11) DEFAULT 0,
  `operational_status` enum('Operational','Full','Maintenance') DEFAULT 'Operational'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `facilities`
--

INSERT INTO `facilities` (`facility_id`, `facility_type`, `name`, `total_capacity`, `current_occupancy`, `operational_status`) VALUES
(1, 'ICU', 'ICU Unit A', 10, 8, 'Operational'),
(2, 'Ward', 'General Ward B', 30, 15, 'Operational'),
(3, 'ER', 'Emergency Room', 20, 18, 'Operational');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `patient_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `contact_info` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`patient_id`, `first_name`, `last_name`, `date_of_birth`, `gender`, `contact_info`, `created_at`) VALUES
(1, 'Amina', 'Osei', '1990-03-15', 'Female', '+254700000001', '2026-03-18 11:20:12'),
(2, 'John', 'Kamau', '1978-11-22', 'Male', '+254700000002', '2026-03-18 11:20:12'),
(3, 'Fatuma', 'Ali', '2000-06-10', 'Female', '+254700000003', '2026-03-18 11:20:12'),
(4, 'David', 'Mwangi', '1955-01-30', 'Male', '+254700000004', '2026-03-18 11:20:12'),
(5, 'Grace', 'Njeri', '1995-08-19', 'Female', '+254700000005', '2026-03-18 11:20:12');

-- --------------------------------------------------------

--
-- Table structure for table `patient_encounters`
--

CREATE TABLE `patient_encounters` (
  `encounter_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `symptoms` text NOT NULL,
  `vitals_bp` varchar(20) DEFAULT NULL,
  `vitals_hr` int(11) DEFAULT NULL,
  `vitals_temp` decimal(4,2) DEFAULT NULL,
  `risk_factors` text DEFAULT NULL,
  `triage_timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient_encounters`
--

INSERT INTO `patient_encounters` (`encounter_id`, `patient_id`, `symptoms`, `vitals_bp`, `vitals_hr`, `vitals_temp`, `risk_factors`, `triage_timestamp`) VALUES
(1, 1, 'Fever, chills, headache', '110/70', 98, 38.90, 'None', '2026-03-18 11:28:22'),
(2, 2, 'Chest pain, difficulty breathing', '90/60', 110, 39.50, 'Hypertension, Diabetes', '2026-03-18 11:28:22'),
(3, 3, 'Mild cough, fatigue', '120/80', 80, 37.20, 'Pregnant', '2026-03-18 11:28:22'),
(4, 1, 'Fever, chills, headache', '110/70', 98, 38.90, 'None', '2026-03-18 12:48:28'),
(5, 2, 'Chest pain, difficulty breathing', '90/60', 110, 39.50, 'Hypertension, Diabetes', '2026-03-18 12:48:28'),
(6, 3, 'Mild cough, fatigue', '120/80', 80, 37.20, 'Pregnant', '2026-03-18 12:48:28');

-- --------------------------------------------------------

--
-- Table structure for table `pharmacy_inventory`
--

CREATE TABLE `pharmacy_inventory` (
  `drug_id` int(11) NOT NULL,
  `item_name` varchar(100) NOT NULL,
  `category` enum('General','Controlled','Vaccine') NOT NULL,
  `current_stock_level` int(11) NOT NULL,
  `reorder_threshold` int(11) NOT NULL,
  `storage_requirement` enum('Room Temp','Cold Chain','Strict Control') DEFAULT 'Room Temp'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pharmacy_inventory`
--

INSERT INTO `pharmacy_inventory` (`drug_id`, `item_name`, `category`, `current_stock_level`, `reorder_threshold`, `storage_requirement`) VALUES
(1, 'Artemether', 'General', 200, 50, 'Room Temp'),
(2, 'Oxytocin', 'Controlled', 30, 10, 'Cold Chain'),
(3, 'Paracetamol', 'General', 500, 100, 'Room Temp');

-- --------------------------------------------------------

--
-- Stand-in structure for view `resource_snapshot`
-- (See below for the actual view)
--
CREATE TABLE `resource_snapshot` (
`facility_type` enum('ICU','Ward','ER','Operating Theatre','Isolation','Lab','Pharmacy')
,`name` varchar(100)
,`available_beds` bigint(12)
,`operational_status` enum('Operational','Full','Maintenance')
,`staff_on_duty` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `staff_roster`
--

CREATE TABLE `staff_roster` (
  `staff_id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `role_category` enum('Doctor','Nurse','Pharmacist','Lab Tech','Support','Admin') NOT NULL,
  `specialization` varchar(100) NOT NULL,
  `shift_status` enum('On Duty','Off Duty','On Call','In Surgery') DEFAULT 'Off Duty',
  `current_patient_load` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_roster`
--

INSERT INTO `staff_roster` (`staff_id`, `first_name`, `last_name`, `role_category`, `specialization`, `shift_status`, `current_patient_load`) VALUES
(1, 'Dr. Lena', 'Mutua', 'Doctor', 'Emergency Medicine', 'On Duty', 3),
(2, 'Nurse', 'Achieng', 'Nurse', 'General Ward', 'On Duty', 5),
(3, 'Dr. James', 'Otieno', 'Doctor', 'Internal Medicine', 'On Call', 1);

-- --------------------------------------------------------

--
-- Structure for view `decision_dashboard`
--
DROP TABLE IF EXISTS `decision_dashboard`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `decision_dashboard`  AS SELECT `p`.`first_name` AS `first_name`, `p`.`last_name` AS `last_name`, `ae`.`health_risk_level` AS `health_risk_level`, `ae`.`ethics_priority_score` AS `ethics_priority_score`, `ad`.`assigned_action` AS `assigned_action`, `ad`.`reasoning_text` AS `reasoning_text`, `ad`.`decision_timestamp` AS `decision_timestamp` FROM (((`ai_decisions` `ad` join `patient_encounters` `pe` on(`ad`.`encounter_id` = `pe`.`encounter_id`)) join `patients` `p` on(`pe`.`patient_id` = `p`.`patient_id`)) join `ai_evaluations` `ae` on(`ae`.`encounter_id` = `pe`.`encounter_id`)) ORDER BY `ad`.`decision_timestamp` DESC ;

-- --------------------------------------------------------

--
-- Structure for view `resource_snapshot`
--
DROP TABLE IF EXISTS `resource_snapshot`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `resource_snapshot`  AS SELECT `f`.`facility_type` AS `facility_type`, `f`.`name` AS `name`, `f`.`total_capacity`- `f`.`current_occupancy` AS `available_beds`, `f`.`operational_status` AS `operational_status`, (select count(0) from `staff_roster` where `staff_roster`.`shift_status` = 'On Duty') AS `staff_on_duty` FROM `facilities` AS `f` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `ai_decisions`
--
ALTER TABLE `ai_decisions`
  ADD PRIMARY KEY (`decision_id`),
  ADD KEY `encounter_id` (`encounter_id`),
  ADD KEY `allocated_facility_id` (`allocated_facility_id`),
  ADD KEY `allocated_staff_id` (`allocated_staff_id`);

--
-- Indexes for table `ai_evaluations`
--
ALTER TABLE `ai_evaluations`
  ADD PRIMARY KEY (`evaluation_id`),
  ADD KEY `encounter_id` (`encounter_id`);

--
-- Indexes for table `equipment_inventory`
--
ALTER TABLE `equipment_inventory`
  ADD PRIMARY KEY (`equipment_id`),
  ADD KEY `location_facility_id` (`location_facility_id`);

--
-- Indexes for table `facilities`
--
ALTER TABLE `facilities`
  ADD PRIMARY KEY (`facility_id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`patient_id`);

--
-- Indexes for table `patient_encounters`
--
ALTER TABLE `patient_encounters`
  ADD PRIMARY KEY (`encounter_id`),
  ADD KEY `patient_id` (`patient_id`);

--
-- Indexes for table `pharmacy_inventory`
--
ALTER TABLE `pharmacy_inventory`
  ADD PRIMARY KEY (`drug_id`);

--
-- Indexes for table `staff_roster`
--
ALTER TABLE `staff_roster`
  ADD PRIMARY KEY (`staff_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `ai_decisions`
--
ALTER TABLE `ai_decisions`
  MODIFY `decision_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `ai_evaluations`
--
ALTER TABLE `ai_evaluations`
  MODIFY `evaluation_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `equipment_inventory`
--
ALTER TABLE `equipment_inventory`
  MODIFY `equipment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `facilities`
--
ALTER TABLE `facilities`
  MODIFY `facility_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `patient_encounters`
--
ALTER TABLE `patient_encounters`
  MODIFY `encounter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pharmacy_inventory`
--
ALTER TABLE `pharmacy_inventory`
  MODIFY `drug_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `staff_roster`
--
ALTER TABLE `staff_roster`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `ai_decisions`
--
ALTER TABLE `ai_decisions`
  ADD CONSTRAINT `ai_decisions_ibfk_1` FOREIGN KEY (`encounter_id`) REFERENCES `patient_encounters` (`encounter_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ai_decisions_ibfk_2` FOREIGN KEY (`allocated_facility_id`) REFERENCES `facilities` (`facility_id`) ON DELETE SET NULL,
  ADD CONSTRAINT `ai_decisions_ibfk_3` FOREIGN KEY (`allocated_staff_id`) REFERENCES `staff_roster` (`staff_id`) ON DELETE SET NULL;

--
-- Constraints for table `ai_evaluations`
--
ALTER TABLE `ai_evaluations`
  ADD CONSTRAINT `ai_evaluations_ibfk_1` FOREIGN KEY (`encounter_id`) REFERENCES `patient_encounters` (`encounter_id`) ON DELETE CASCADE;

--
-- Constraints for table `equipment_inventory`
--
ALTER TABLE `equipment_inventory`
  ADD CONSTRAINT `equipment_inventory_ibfk_1` FOREIGN KEY (`location_facility_id`) REFERENCES `facilities` (`facility_id`) ON DELETE SET NULL;

--
-- Constraints for table `patient_encounters`
--
ALTER TABLE `patient_encounters`
  ADD CONSTRAINT `patient_encounters_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`patient_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
