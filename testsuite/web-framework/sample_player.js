// This is a sample of what needs to be implement for
// a DFXP presentation processor in order to add it in
// the test framework

function SamplePlayer() {
}

// The name of your player.

SamplePlayer.prototype.name = function () {
  return "Sample Player";
}

// Start your player.

SamplePlayer.prototype.startPlayer = function() {
    // nothing needs to be done
    alert("Start the sample player.");
}

// Run your player with a test
//  test_number (integer): The test unique number
//  filename (string): relative URI of the test
//  autostart (boolean): if the player should start automatically or not
//  div (DOM Element): the DOM div element containing your player object

SamplePlayer.prototype.startTest = function(test_number, filename, autostart, div) {

    alert("Start the sample player with the test " + test_number);
}

// Stop your player running wit a certain test
//   test_number (integer): The test unique number

SamplePlayer.prototype.stopTest = function(test_number)
{
    // nothing needs to be done
    alert("Stop the sample player with the test " + test_number);
}

// Stop your player.

SamplePlayer.prototype.stopPlayer = function()
{
    // nothing needs to be done
    alert("Stop the sample player.");
}

// Add your player in the list

addPlayer(new SamplePlayer());

