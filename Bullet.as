package {
	import flash.display.MovieClip;
	
	public class Bullet extends MovieClip{
		var speed:int = 4;  //velocidade da bala
		var Target; //alvo da bala
        var angle:Number;   //angulo da bala
		var remove:Boolean; 
		
		//esta funçao roda a bala
		public function Bullet(rotate:Number,tmpMonster){
			angle = rotate;
			Target = tmpMonster;
			this.rotation = angle/Math.PI*180; //roda a bala
		}
		
		//esta funçao da update na bala
		public function update() {
			
			this.x += this.speed*Math.cos(angle);
			this.y += this.speed*Math.sin(angle);
			
			if(this.hitTestObject(Target)){ // se a bala atinge o objeto
			   Target.hp -= 20;             //reduz vida
			   remove = true;               //remove bala
			}
		}
	}
}