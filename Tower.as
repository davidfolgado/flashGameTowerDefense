package {
	import flash.display.MovieClip;
	
	public class Tower extends MovieClip{
		const c_reloadTime=30;
		
		var reloadTime = int; //tempo que a torre da reload
		var range= int;      //distancia que a torre começa a disparar
		var cost = int;       //custo da torre
		
		public function Tower(){
			reloadTime=30;
			range=80;
			cost=20;
		}
	}
}