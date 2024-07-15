<?php
$servername = getenv('DB_HOST');
$username   = getenv('DB_USER');
$password   = getenv('DB_PASS');
$dbname     = getenv('DB_NAME');

try {
	$db = new PDO("mysql:host=$servername;dbname=$dbname", $username, $password,
		[
			PDO::ATTR_TIMEOUT => 5,
			PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
		]
	);
} catch (Exception $e) {
	echo json_encode([
		"status"  => "error",
		"message" => $e->getMessage(),
	]);
	http_response_code(500);
	exit;
}
header('Content-Type: application/json; charset=UTF-8');
if (isset($_GET['action'])) {
	switch ($_GET['action']) {
		case "list":
			$requestCustomers = $db->query("SELECT id, name FROM customers");
			echo json_encode($requestCustomers->fetchAll(2));
			http_response_code(200);
			break;
		case "details":
			if(isset($_GET['cid']) && !empty($_GET['cid'])){
				$requestCustomer = $db->prepare("SELECT id, name FROM customers WHERE id = :id");
				$requestCustomer->execute([
					"id" => (int) $_GET['cid'],
				]);
				$reqCustomer = $requestCustomer->fetch(2);
				if($requestCustomer->rowCount()){
					echo json_encode($reqCustomer);
					http_response_code(200);
				}else{
					echo json_encode([
						"status"  => "error",
						"message" => "Entity not found",
					]);
					http_response_code(404);
				}
			}else{
				echo json_encode([
					"status"  => "error",
					"message" => "Incomplete request. Please specify the entity ID",
				]);
				http_response_code(409);
			}
			break;
		default:
			echo json_encode([
				"status"  => "error",
				"message" => "Invalid endpoint",
			]);
			http_response_code(409);
	}
} else {
	echo json_encode([
		"status" => "Welcome to the API !",
	]);
	echo json_encode(200);
}
