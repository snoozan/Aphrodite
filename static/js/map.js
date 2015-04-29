/**
 * start ex 51.5,-0.127
 * end ex 52.5,-0.127
 */
function buildIframe(start, end, api_key) {
	var frame = $('<iframe id="mapFrame" name="mapFrame">');
	var src = 'https://www.google.com/maps/embed/v1/directions?';
	var origin = 'origin=' + start; 
	var dest = '&destination='+end;
	var mode = '&mode=transit';
	var api = '&key=' + api_key;
	
	frame.attr('src', src + origin + dest + mode + api).attr('width', 500).attr('height', 500);
	return frame;
}
