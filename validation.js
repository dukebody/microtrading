function isEmpty(str) {
    if (str == null || str == "")
	return true;
    return false;
}
function trim(str) {
    if (str!=null) {
	while (str.length > 0 && str.charAt(str.length - 1) == " ")
	    str = str.substring(0, str.length - 1);
	while (str.length > 0 && str.charAt(0) == " ")
	    str = str.substring(1, str.length);
    }
    return str;
}
				
function validateForm(theForm) {
				
    if (isEmpty(trim(theForm.elements["name"].value))) {
	alert("Please enter a name"); return false;
    }
    if (isEmpty(trim(theForm.elements["contact"].value))) {
	alert("Please fill the contact field"); return false;
    }
				
    if (isNaN(theForm.elements["price"].value)== true ){
	alert("Please enter a numeric price"); return false;
				
    }
    return true;
}
