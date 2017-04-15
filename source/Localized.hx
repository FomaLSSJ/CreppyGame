package;

class Localized
{
	private var object:Dynamic;
	
	public function new():Void
	{
		object = {
			"US": {
				"NAME": "English",
				"DATA": {
					"MENU": {
						"TITLE": "- Suspense -",
						"DESCRIPTION": "Wow. Such harror, much survivar!",
						"NEW_GAME": "New Game"
					},
					"GAME": {}
				}
			}
		};
	}
	
	public function get():Dynamic
	{
		return object;
	}
}