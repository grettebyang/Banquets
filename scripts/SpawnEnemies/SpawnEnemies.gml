// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SpawnEnemies(){
	if(layer_exists("EnemySpawn"))
	{
		var spawnArea = layer_tilemap_get_id(layer_get_id("EnemySpawn"));
		var enemyCount = irandom_range(2,5);
	
		for(var i = 0; i < enemyCount; i++)
		{
			var xx = irandom_range(0, room_width);
			var yy = irandom_range(0, room_height);
			while(!tilemap_get_at_pixel(spawnArea, xx, yy))
			{
				xx = irandom_range(0, room_width);
				yy = irandom_range(0, room_height);
			}
			instance_create_layer(xx, yy, "Instances", wasp_obj);
		}
	}
	
}