package {
	import flash.display.MovieClip;
	
	public class Tower2 extends MovieClip{
		const c_reloadTime=10;
		
		var reloadTime = int; //tempo que a torre da reload
		var range = int;      //distancia que a torre começa a disparar
		var cost = int;       //custo da torre
		
		public function Tower2(){
			reloadTime=10;
			range=100;
			cost=40;
		}
	}
}