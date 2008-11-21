// Display a video with the specified DFXP captioning document
// 1. Create one function with no parameter to start your player.
// 2. Create a function to start your player with a test, as follows:
//    a. the function takes five parameters:
//       1. integer: The test unique number
//       2. string: filename of the test
//       3. boolean: if autostart should be on or off
//       4. DOM Element: the DOM div element containing your player object
//    b. the player goes in <div id="testarea">
// 3. Create a function to stop your player, as follows:
//    a. the function takes one parameter:
//       1. integer: The test unique number
// 4. Create one function with no parameter to stop your player.
// 5. Invoke addPlayer("name of the player",
//                     "yourStartPlayerFunctionName",
//                     "yourStartTestFunctionName", 
//                     "yourStopTestFunctionName",
//                     "yourStopPlayerFunctionName") to add your player

addPlayer("Sample Player 3.0.1", 
	  "startSamplePlayer", 
	  "startSampleTest", 
	  "stopSampleTest", 
	  "stopSamplePlayer");

function startSamplePlayer() {
    // nothing needs to be done
    alert("Start the sample player.");
}

function startSampleTest(test_number, filename, autostart, div) {

    alert("Start the sample player with the test " + test_number);
}

function stopSampleTest(test_number)
{
    // nothing needs to be done
    alert("Stop the sample player with the test " + test_number);
}

function stopSamplePlayer()
{
    // nothing needs to be done
    alert("Stop the sample player.");
}