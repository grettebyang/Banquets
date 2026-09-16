function ByrdeDR(response){
	
	switch(response)
	{
		case 0 : break;
		case 1 : NewTextBox("Hey", 0); break;
		case 2 : NewTextBox("Hi. Did you check the BEO?", 0, ["3:Yes", "0:No"], ByrdeDR); break;
		case 3 : NewTextBox("Okay.", 0); break;
		default : break;
	}
}