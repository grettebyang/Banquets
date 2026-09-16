// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DessertChoices(){

	var desserts = array_create(0);
	array_push(desserts, "French silk pie");
	array_push(desserts, "Cake");
	array_push(desserts, "Cookies");
	array_push(desserts, "Donuts");
	array_push(desserts, "Cupcakes");
	array_push(desserts, "Bagels");
	
	var dessertChoice = desserts[irandom_range(0,5)];
	
	return dessertChoice;

}