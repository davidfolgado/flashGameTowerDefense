package{
	import flash.display.*;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.events.Event; //used for ENTER_FRAME event
	
	public class Main extends MovieClip{
		//constantes
		const monster_startx:int = -15; //posiçao inicial do monstro
		const monster_starty:int = 125;//posiçao inicial do monstro
		const monster_speed:int = 2;   //velocidade dos monstros
		const monsterno:int = 15;      //numero dos monstros
		
		//variaveis
		var currTower;           //torre atual
		var currTile:Tile1;            // Tile atual
		var currGold:int = 100;        // Gold inicial
		var currLevel:int = 0;         // Level atual
		var gData:Data = new Data();
		
		//Arrays
		var nonPlacableTiles:Array = new Array();  //lista de ladrilhos em que as torres não podem ser colocadas
		var level:Array = new Array();             //Matriz 2D para representar mapa
		var monsters:Array = new Array();          //lista dos monstros no jogo
		var bullets:Array = new Array();           //lista das balas disparadas
		var towers:Array = new Array();            //lista das torres que se mete
		var waypoints_x:Array = new Array();       //waypoints para controlar movimentos dos monstros
		var waypoints_y:Array = new Array();       //waypoints para controlar movimentos dos monstros
		var stageObjects:Array = new Array();      //guardar os objetos no stage
		
		public function Main() {
			playBtn.addEventListener(MouseEvent.MOUSE_UP,playBtnUpHandler);
		}
		
		function playBtnUpHandler(event:MouseEvent){
			gotoAndStop(3);
			init();
		}
		
		function init():void {
			
			gData.setUp();
			level = gData.levels[currLevel];
		    
			//waypoints que os monstros viram
			waypoints_x = gData.waypoints_x[currLevel];
			waypoints_y = gData.waypoints_y[currLevel];
			
			currGold = 100;
			
			BuildMap(level);                                             //funçao para construir mapa
			for(var i=0; i<monsterno; ++i){ 
			if (i==5){
			createMonster2(monster_startx -i*100,waypoints_y[0]); //funçao para criar monstros
			continue;
			}
			if (i==7){
				createMonster2(monster_startx -i*100,waypoints_y[0]); //funçao para criar monstros
			continue;
			}
			if (i==3){
				createMonster4(monster_startx -i*100,waypoints_y[0]); //funçao para criar monstros
			continue;
			}
			if (i==10){
				createMonster4(monster_startx -i*100,waypoints_y[0]); //funçao para criar monstros
			continue;
			}
			if (i==4){
				createMonster5(monster_startx -i*100,waypoints_y[0]); //funçao para criar monstros
			continue;
			}
			if (i==11){
				createMonster5(monster_startx -i*100,waypoints_y[0]); //funçao para criar monstros
			continue;
			}
				if (i%2==0)
					createMonster(monster_startx -i*100,waypoints_y[0]); //funçao para criar monstros
				else{
					createMonster3(monster_startx -i*100,waypoints_y[0]); //funçao para criar monstros

				}
		
			}
			BtnTower.addEventListener(MouseEvent.MOUSE_UP,TowerBtnUpHandler);
			BtnTower2.addEventListener(MouseEvent.MOUSE_UP,TowerBtn2UpHandler);
			restartBtn.addEventListener(MouseEvent.MOUSE_UP,restartBtnUpHandler);
			stage.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDownHandler);
			stage.addEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
		}
		
		function restartBtnUpHandler(event:MouseEvent){
			clearStage();
			gotoAndStop(3);
			init();
		}
		
		//esta funçao vai construir o mapa
		function BuildMap(level):void{
			for(var i:int =0; i < level.length ; ++i){          
				for(var j:int =0; j < level[i].length ; ++j){  //são necessários dois loops para acessar elementos de um array 2D
					var tmpTile:Tile1 = new Tile1();
			        tmpTile.x = j*50;
			        tmpTile.y = i*50;
			        addChild(tmpTile);
					stageObjects.push(tmpTile);
					tmpTile.gotoAndStop(level[i][j]+1);        
					if(level[i][j]==1)                         //adicione o bloco à lista nonPlacableTiles se as torres
					nonPlacableTiles.push(tmpTile);            //não pode ser colocado nele
					tmpTile.addEventListener(MouseEvent.ROLL_OVER,TurnOnTile);
					tmpTile.addEventListener(MouseEvent.ROLL_OUT,TurnOfTile);
				}
			}
		}
		
		//esta função é chamada quando o rato é rolado sobre o azulejo
		function TurnOnTile(event:MouseEvent){
			currTile = event.currentTarget as Tile1;
			if(checkPlacable(currTile) && currTower != null){
				currTile.gotoAndStop(3);
			}
		}
		
		//esta função é chamada quando o rato é rolado para fora da placa
		function TurnOfTile(event:MouseEvent){
			var prevTile = event.currentTarget as Tile1;
			if(prevTile.currentFrame == 3){
				prevTile.gotoAndStop(1);
			}
		}
		
		//esta funçao limpa o stage
		function clearStage():void{
			for(var i:int = 0; i < stageObjects.length; ++i){
				if(stageObjects[i] != null){
					removeChild(stageObjects[i]);
					stageObjects[i] = null;
				}
			}
			for(var i:int = 0; i < towers.length; ++i){
				if(towers[i] != null){
					removeChild(towers[i]);
					towers[i] = null;
				}
			}
			
			if(currTower != null){
				removeChild(currTower);
		    	currTower = null;
			}
			stageObjects.splice(0);
			nonPlacableTiles.splice(0);
			monsters.splice(0);
			towers.splice(0);
			bullets.splice(0);
		}
		
		//esta funçao cria o monstro
		function createMonster(xpos:int,ypos:int):void{
			var tmpMonster = new Monster();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			monsters.push(tmpMonster);  //adiciona o monstro atual à lista de monstros
		}
		function createMonster2(xpos:int,ypos:int):void{
			var tmpMonster = new Monster2();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			monsters.push(tmpMonster);  //adiciona o monstro atual à lista de monstros
		}
		function createMonster3(xpos:int,ypos:int):void{
			var tmpMonster = new Monster3();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			monsters.push(tmpMonster); //adiciona o monstro atual à lista de monstros
		}
		function createMonster4(xpos:int,ypos:int):void{
			var tmpMonster = new Monster4();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			monsters.push(tmpMonster); //adiciona o monstro atual à lista de monstros
		}
		function createMonster5(xpos:int,ypos:int):void{
			var tmpMonster = new Monster5();
			tmpMonster.x = xpos;
			tmpMonster.y = ypos;
			addChild(tmpMonster);
			monsters.push(tmpMonster);  //adiciona o monstro atual à lista de monstros
		}
		
		//esta função verifica se uma torre pode ser colocada em um ladrilho
		function checkPlacable(tmpTile:Tile1):Boolean {
			for(var i:int = 0; i<nonPlacableTiles.length ; ++i){
				if(nonPlacableTiles[i] == tmpTile)
				return false;
			}
			return true;
		}
		
		//esta função retorna a distância entre dois movieclips
		function distance(A:MovieClip,B:MovieClip):Number{
			return Math.pow(Math.pow(B.x-A.x,2) + Math.pow(B.y-A.y,2),0.5);
		}
		
		//esta função irá mover um monstro no jogo (usando um loop podemos mover todos os monstros)
		function moveMonster(tmpMonster,i:int):void {
			var dist_x:Number = waypoints_x[tmpMonster.nextWayPoint] - tmpMonster.x; //distância entre o monstro
			var dist_y:Number = waypoints_y[tmpMonster.nextWayPoint] - tmpMonster.y; //e o próximoWayPoint
			if(Math.abs(dist_y) + Math.abs(dist_x) < 1){   //aumentar o nextWayPoint se o monstro
				++tmpMonster.nextWayPoint;                 //colidiu com um waypoint
			}
			var angle:Number = Math.atan2(dist_y,dist_x); //calcular o ângulo do monstro
			tmpMonster.x += monster_speed*Math.cos(angle);//atualize a posição x
			tmpMonster.y += monster_speed*Math.sin(angle);//atualize a posição y
			tmpMonster.rotation = angle/Math.PI*180;      //gira o monstro
			if(tmpMonster.x >= 475){                      //remove o monstro se ele tocar o último waypoint
				clearStage();
				init();
			}
			if(tmpMonster.hp <= 0){                       //remove o monstro se o seu hp se tornar 0
				currGold += tmpMonster.gold;	        
			    removeChild(tmpMonster);
			    monsters.splice(i,1)
	        }
		}
		
		// esta função irá atualizar uma torre (usando um loop podemos atualizar todas as torres)
		function updateTowers(tmpTower):void {
			 if(tmpTower.reloadTime == 0){           
				for(var i:int = 0; i < monsters.length ; ++i){            // loop através de todo o monstro
				if(distance(tmpTower,monsters[i]) < tmpTower.range){     // verifica se o monstro está no alcance da torre
					var angle:Number = Math.atan2(monsters[i].y - tmpTower.y, monsters[i].x - tmpTower.x); // calcula o ângulo da bala
					var tmpBullet:Bullet = new Bullet(angle,monsters[i]); // cria uma bala
					tmpTower.gun.rotation = (angle/Math.PI*180)+90;
			        tmpBullet.x = tmpTower.x;
			        tmpBullet.y = tmpTower.y;
			        addChild(tmpBullet);
					//stageObjects.push(tmpBullet);
					bullets.push(tmpBullet);                              // adiciona o tmpBullet à lista de marcadores disparados
					tmpTower.reloadTime = tmpTower.c_reloadTime;
					break;
				}
				}
			}else{
					tmpTower.reloadTime -= 1;
		    }
		}
		
		function onEnterFrameHandler(event:Event){
			
			if(monsters.length <= 0){
				++currLevel;
				if(currLevel >= gData.levels.length){
			    	gotoAndStop(2);
					stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameHandler);
					return 0;
				}else{
					level = gData.levels[currLevel];
					clearStage();
					init();
				}
			}
			
			for(var i:int =0;i< monsters.length;++i){ // atualiza todos os monstros
				moveMonster(monsters[i],i);
			}
			
			for(var i:int=0;i<towers.length;++i){     // atualiza todas as torres
				updateTowers(towers[i]);
			}
			
			for(var i:int=0;i<bullets.length;++i){   // atualiza todas as balas
				if(!bullets[i].remove){
					bullets[i].update();
				}else{
					removeChild(bullets[i]);
					bullets.splice(i,1);
				}
			}
			
			if(currTower != null){                             // define a posição da torre para a do mouse
				currTower.x = mouseX + 1 + currTower.width/2;
				currTower.y = mouseY + 1 + currTower.height/2;
			}
			
			txtGold.text = String(currGold);
		}
// esta função irá criar um MovieClip Tower se o usuário clicar no botão Tower
		function TowerBtnUpHandler(event:MouseEvent){ 
			if(currTower == null){
				currTower = new Tower();
			    addChild(currTower);
				//stageObjects.push(currTower);
			}
		}
		function TowerBtn2UpHandler(event:MouseEvent){ 
			if(currTower == null){
				currTower = new Tower2();
			    addChild(currTower);
				//stageObjects.push(currTower);
			}
		}
		
		// esta função colocará a torre quando o usuário clicar no palco
		function onMouseDownHandler(event:MouseEvent){
			if(currTower != null){
				if(checkPlacable(currTile)){                           // verifica se pode ser colocado
				if((currGold-currTower.cost)>=0){                     // verifica se há ouro suficiente para colocar a torre
				if(mouseX < 500){                                      
					txtStatus.text = "";
					currGold -= currTower.cost;
					towers.push(currTower);
					currTower.x = currTile.x + currTile.width/2;        // coloca a torre no ladrilho
				    currTower.y = currTile.y + currTile.height/2;
				    currTower = null;
					nonPlacableTiles.push(currTile);                    // adiciona o bloco atual em nonPlacableTiles
				}                                                       // depois de colocar a torre
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