<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chuck Norris Jokes</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Chuck Norris Jokes</h1>
        <div class="jokes-list">
            <?php
                // Database connection
                $servername = "mysql_case4";
                $username = "root";
                $password = "mydb6789tyui";
                $dbname = "mydb_case4";

                // Connect to the database
                $conn = new mysqli($servername, $username, $password, $dbname);
                if ($conn->connect_error) {
                    die("Connection failed: " . $conn->connect_error);
                }

                // Fetch jokes
                $sql = "SELECT joke_text, created_at FROM jokes ORDER BY created_at DESC";
                $result = $conn->query($sql);

                if ($result->num_rows > 0) {
                    // Output each joke
                    while ($row = $result->fetch_assoc()) {
                        echo "<div class='joke-item'>";
                        echo "<p class='joke-text'>" . htmlspecialchars($row["joke_text"]) . "</p>";
                        echo "<p class='joke-date'>Saved on: " . $row["created_at"] . "</p>";
                        echo "</div>";
                    }
                } else {
                    echo "<p class='no-jokes'>No jokes found.</p>";
                }

                $conn->close();
            ?>
        </div>
    </div>
</body>
</html>
