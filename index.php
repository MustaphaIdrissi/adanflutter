<?php
$arrayadan=[];

function getPrayerTimes($city, $country, $year) {
    // Create URL with city, country, and year
    $apiUrl = "https://api.aladhan.com/v1/calendarByAddress/{$year}?address=" . urlencode($city) . "," . urlencode($country) ;
    
    // Fetch the content using file_get_contents
    $response = file_get_contents($apiUrl);

    // Check if the request was successful
    if ($response === false) {
        return ["error" => "Unable to fetch data from the API."];
    }

    // Decode JSON response
    $data = json_decode($response, true);

    // Check for JSON decode errors
    if (json_last_error() !== JSON_ERROR_NONE) {
        return ["error" => "JSON decode failed - " . json_last_error_msg()];
    }

    // Check if data contains prayer times
    if (isset($data['data']) && is_array($data['data']) && count($data['data']) > 0) {
        return $data; // Return the full data including 'data' key
    } else {
        return ["error" => "Invalid data received from the API."];
    }
}

// Call the function and display the results
$city = $_POST['city'];
$country = $_POST['country'];
$year = 2024;// Specify the desired year

$prayerTimes = getPrayerTimes($city, $country, $year);
function removeTimeZone($time) {
    return preg_replace('/\s*\(\+\d{2}\)/', '', $time);
}
// Set content type to JSON
header('Content-Type: application/json');

// Print the result as JSON
if (isset($prayerTimes['data'])) {
     for($i=1;$i<=12;$i++){
      
        foreach($prayerTimes['data'][$i] as $dd){

            $arrayadan[] = [
                'date' => $dd['date']['gregorian']['date'],
                'timings'=>[
                'Fajr' => removeTimeZone($dd['timings']['Fajr']),
                'Sunrise' => removeTimeZone($dd['timings']['Sunrise']),
                'Dhuhr' => removeTimeZone($dd['timings']['Dhuhr']),
                'Asr' => removeTimeZone($dd['timings']['Asr']),
                'Sunset' => removeTimeZone($dd['timings']['Sunset']),
                'Maghrib' => removeTimeZone($dd['timings']['Maghrib']),
                'Isha' => removeTimeZone($dd['timings']['Isha']),
                'Imsak' => removeTimeZone($dd['timings']['Imsak']),
                'Midnight' => removeTimeZone($dd['timings']['Midnight']),
                'Firstthird' => removeTimeZone($dd['timings']['Firstthird']),
                'Lastthird' => removeTimeZone($dd['timings']['Lastthird'])



              





                ]
            ];
          







         

        }
      
     }
    

     echo json_encode($arrayadan, JSON_PRETTY_PRINT);
   // echo json_encode($prayerTimes['data'], JSON_PRETTY_PRINT);

 //  $jsonContent = json_encode($arrayadan, JSON_PRETTY_PRINT);

   // Specify the name of the JSON file
  // $filename = "prayer_times.json";

  // $filePath = __DIR__ . '/' . $filename;
 //  file_put_contents($filePath, $jsonContent);

} else {
    echo json_encode($prayerTimes, JSON_PRETTY_PRINT);
}

?>
