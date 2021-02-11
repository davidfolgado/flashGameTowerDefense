package{
	public class Data {
		
		public var levels:Array = new Array();		//array para guardar os niveis
		public var waypoints_x:Array = new Array(); //array para guardar x waypoint de todos os niveis
		public var waypoints_y:Array = new Array(); //array para guardar y waypoint de todos os niveis
		
		public var level1:Array = new Array();			//array para guardar a data do nivel um
		public var waypoints_x_1:Array = new Array();   //array para guardar x waypoints de level1
		public var waypoints_y_1:Array = new Array();	//array para guardar y waypoints de level1
		
		public var level2:Array = new Array();			//array para guardar a data do nivel dois
		public var waypoints_x_2:Array = new Array();   //array para guardar x waypoints de level2
		public var waypoints_y_2:Array = new Array();	//array para guardar y waypoints de level2
		
		public var level3:Array = new Array();			//array para guardar a data do nivel tres
		public var waypoints_x_3:Array = new Array();   //array para guardar x waypoints de level3
		public var waypoints_y_3:Array = new Array();	//array para guardar y waypoints de level3
		
		public function setUp(){
			level1 = [[0,0,0,0,1,1,1,1,1,0],
					 [0,0,0,0,1,0,0,0,1,0],
					 [1,1,0,0,1,0,0,0,1,0],
					 [0,1,0,0,1,0,0,0,1,0],
					 [0,1,0,0,1,0,0,0,1,0],
					 [0,1,1,1,1,0,0,0,1,0],
					 [0,0,0,0,0,0,0,0,1,1],
					 [0,0,0,0,0,0,0,0,0,0],
					];
					
			level2 = [[0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,1,1,1,1,1,1],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [1,1,1,1,1,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					 [0,0,0,0,0,0,0,0,0,0],
					];
					
			level3 = [[0,0,0,0,0,0,0,0,0,0],
					 [1,1,1,1,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					 [0,0,0,0,1,0,0,0,0,0],
					];
					
			
		    //waypoints são os pontos que o monstro vira
			waypoints_x_1 = [75 ,75 ,225,225,425,425,475];
			waypoints_y_1 = [125,275,275,25 ,25 ,325,325];
			
			waypoints_x_2 = [225,225,475];
			waypoints_y_2 = [275,75,75];
			
			waypoints_x_3 = [225,225];
			waypoints_y_3 = [75,375];
			
			levels = [level1,level2,level3];
			waypoints_x = [waypoints_x_1,waypoints_x_2,waypoints_x_3];
			waypoints_y = [waypoints_y_1,waypoints_y_2,waypoints_y_3]
		}
	}
}