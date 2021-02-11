package{
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.events.Event; //used for ENTER_FRAME event
	
	public class Main extends MovieClip{
		//constants
		const monster_startx:int = -15; //starting position the monster
		const monster_starty:int = 125;//starting position the monster
		const monster_speed:int = 2;   //speed of the monster
		const monsterno:int = 10;      //number of monsters
		
		//variables
		var currTower:Tower;           //current Tower
		var currTile:Tile1;            //current Tile
		var currGold:int = 100;        //current Gold
		
		//Arrays
		var nonPlacableTiles:Array = new Array();  //list of tiles on which towers cannot be placed
		var level:Array = new Array();             //2D array for representing map
		var monsters:Array = new Array();          //list of monsters in the game
		var bullets:Array = new Array();           //list of bullets fired
		var towers:Array = new Array();            //list of towers placed
		var waypoints_x:Array = new Array();       //waypoints for controlling motion of monsters
		var waypoints_y:Array = new Array();       //waypoints for controlling motion of monsters
		public function Main() {
			init();
		}
		function init():void {
			level = [[0,0,0,0,1,1,1,1,1,0],
					 [0,0,0,0,1,0,0,0,1,0],
					 [1,1,0,0,1,0,0,0,1,0],
					 [0,1,0,0,1,0,0,0,1,0],
					 [0,1,0,0,1,0,0,0,1,0],
					 [0,1,1,1,1,0,0,0,1,0],
					 [0,0,0,0,0,0,0,0,1,1],
					 [0,0,0,0,0,0,0,0,0,0],
					];
		    //waypoints are points from which the monster must turn
			waypoints_x = [75 ,75 ,225,225,425,425,475];
			waypoints_y = [125,275,275,25 ,25 ,325,325];
			
			BuildMap();                                             //function for building the map
			for(var i:int=0; i<monsterno; ++i){ 
				createMonster(monster_startx -i*100,monster_starty); //function for creating monsters
			}
			BtnTower.addEventListener(MouseEvent.MOUSE_UP,TowerBtnUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
		}
		
		//this function will build the map
		function BuildMap():void{
			for(var i:int =0; i < level.length ; ++i){          
				for(var j:int =0; j < level[i].length ; ++j){  //two loops are needed for accessing elements of a 2D array
					var tmpTile:Tile1 = new Tile1();
			        tmpTile.x = j*50;
			        tmpTile.y = i*50;
			        addChild(tmpTile);
					tmpTile.gotoAndStop(level[i][j]+1);        
					if(level[i][j]==1)                         //add the tile to the nonPlacableTiles list if towers
					nonPlacableTiles.push(tmpTile);            //cannot be placed on it
					tmpTile.addEventListener(MouseEvent.ROLL_OVER,TurnOnTile);
					tmpTile.addEventListener(MouseEvent.ROLL_OUT,TurnOfTile);
				}
			}
		}
		
		//this function is called when mouse is rolled over the tile
		function TurnOnTile(event:MouseEvent){
			currTile = event.currentTarget as Tile1;
			if(checkPlacable(currTile) && currTower != null){
				currTile.gotoAndStop(3);
			}
		}
		
		//this function is called when mouse is rolled out of the tile
		function TurnOfTile(event:MouseEvent){
			var prevTile = event.currentTarget as Tile1;
			if(prevTile.currentFrame == 3){
				prevTile.gotoAndStop(1);
			}
		}
		
		//this function creates a monster
		function createMonster(xpos:int,ypos:int):void{
			var tmpMonster:Monster = new Monster();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			monsters.push(tmpMonster);  //add the current monster to the list of monsters 
		}
		
		//this function checks if a tower can be placed on a tile
		function checkPlacable(tmpTile:Tile1):Boolean {
			for(var i:int = 0; i<nonPlacableTiles.length ; ++i){
				if(nonPlacableTiles[i] == tmpTile)
				return false;
			}
			return true;
		}
		
		//this function returns the distance between two movieclips
		function distance(A:MovieClip,B:MovieClip):Number{
			return Math.pow(Math.pow(B.x-A.x,2) + Math.pow(B.y-A.y,2),0.5);
		}
		
		//this function will move a monster in the game (using a loop we can move all monsters)
		function moveMonster(tmpMonster:Monster,i:int):void {
			var dist_x:Number = waypoints_x[tmpMonster.nextWayPoint] - tmpMonster.x; //distance between the monster
			var dist_y:Number = waypoints_y[tmpMonster.nextWayPoint] - tmpMonster.y; //and the nextWayPoint
			if(Math.abs(dist_y) + Math.abs(dist_x) < 1){   //increase the nextWayPoint if monster 
				++tmpMonster.nextWayPoint;                 //collided with a waypoint
			}
			var angle:Number = Math.atan2(dist_y,dist_x); //compute the angle of the monster
			tmpMonster.x += monster_speed*Math.cos(angle);//update the x position
			tmpMonster.y += monster_speed*Math.sin(angle);//update the y position
			tmpMonster.rotation = angle/Math.PI*180;      //rotate the monster
			if(tmpMonster.x >= 475){                      //remove the monster if it touches the last wayPoint
			removeChild(tmpMonster);
			monsters.splice(i,1)
			}
			if(tmpMonster.hp <= 0){                       //remove the monster if its hp becomes 0
				currGold += tmpMonster.gold;	        
			    removeChild(tmpMonster);
			    monsters.splice(i,1)
	        }
		}
		
		//this function will update a tower(using a loop we can update all towers)
		function updateTowers(tmpTower:Tower):void {
			 if(tmpTower.reloadTime == 0){           
				for(var i:int = 0; i < monsters.length ; ++i){            //loop through all the monster
				if(distance(tmpTower,monsters[i]) < tmpTower.range){      //check if monster is in the range of the tower
					var angle:Number = Math.atan2(monsters[i].y - tmpTower.y, monsters[i].x - tmpTower.x); //compute angle of the bullet
					tmpTower.gun.rotation = (angle/Math.PI*180)+90;
					var tmpBullet:Bullet = new Bullet(angle,monsters[i]); // create a bullet
			        tmpBullet.x = tmpTower.x;
			        tmpBullet.y = tmpTower.y;
			        addChild(tmpBullet);
					bullets.push(tmpBullet);                              //add tmpBullet to the list of bullets fired
					tmpTower.reloadTime = 30;
					break;
				}
				}
			}else{
					tmpTower.reloadTime -= 1;
		    }
		}
		
		function onEnterFrameHandler(event:Event){
			
			if(monsters.length <= 0){              
			    gotoAndStop(2);
				stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
				return 0;
			}
			
			for(var i:int =0;i< monsters.length;++i){ //update nos carros
				moveMonster(monsters[i],i);
			}
			
			for(var i:int=0;i<towers.length;++i){     //update nas torres
				updateTowers(towers[i]);
			}
			
			for(var i:int=0;i<bullets.length;++i){    //da update nas balas
				if(!bullets[i].remove){
					bullets[i].update();
				}else{
					removeChild(bullets[i]);
					bullets.splice(i,1);
				}
			}
			
			if(currTower != null){                             // posiçao das torres
				currTower.x = mouseX + 1 + currTower.width/2;
				currTower.y = mouseY + 1 + currTower.height/2;
			}
			
			txtGold.text = String(currGold);
		}
		
		//this function will create a Tower movieClip if user clicked on Tower Button
		function TowerBtnUpHandler(event:MouseEvent){ 
			if(currTower == null){
				currTower = new Tower();
			    addChild(currTower);
			}
		}
		
		//this function will place the tower when user clicks on the stage
		function onMouseDownHandler(event:MouseEvent){
			if(currTower != null){
				if(checkPlacable(currTile)){                           //check if placable
				if((currGold-currTower.cost)>=0){                      //check if there is enough gold to place the 
				if(mouseX < 550){                                      //tower
					txtStatus.text = "";
					currGold -= currTower.cost;
					towers.push(currTower);
					currTower.x = currTile.x + currTile.width/2;        //place the tower on the tile
				    currTower.y = currTile.y + currTile.height/2;
				    currTower = null;
					nonPlacableTiles.push(currTile);                    //add the current Tile into nonPlacableTiles
				}                                                       //after placing the tower
				}else{
					txtStatus.text = "not enough gold";
				}                                                           
			    }
				if(mouseX >500 && mouseX<600){
				   removeChild(currTower);
				   currTower = null;
			    }
			}
		}
	}
}