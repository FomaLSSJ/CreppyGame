package;

class Inventory
{
	public var inventory:Array<Item> = [];

	public function new():Void
	{
		/* unused */
	}

	public function addItem(item:Item):Void
	{
		this.inventory.push(item);
	}

	public function getItem(Id:Int):Bool
	{
		for (i in 0...inventory.length)
		{
			if (inventory[i].id == Id)
			{
				return true;
			}
		}
		
		return false;
	}
}