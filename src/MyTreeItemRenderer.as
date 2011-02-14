package{
    // itemRenderers/tree/myComponents/MyTreeItemRenderer.as
    import com.benstucki.utilities.IconUtility;
    
    import flash.events.ContextMenuEvent;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    
    import mx.collections.*;
    import mx.controls.treeClasses.*;
    import mx.core.FlexGlobals;

    public class MyTreeItemRenderer extends TreeItemRenderer
    {

        // Define the constructor.      
        public function MyTreeItemRenderer() {
            super();
            
			var contextMenu:ContextMenu = new ContextMenu();  
			var menuItems:Array = [];  
			var edit:ContextMenuItem = new ContextMenuItem(resourceManager.getString('myResources', 'newCategory'));  
			edit.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, addCategoryClick);  
			menuItems.push(edit);  
			contextMenu.customItems = menuItems;  
			this.contextMenu = contextMenu;  
        }
        
        private function addCategoryClick(e:ContextMenuEvent):void{
			FlexGlobals.topLevelApplication.onCreateBtnClick();
        }
        
        
        // Override the set method for the data property
        // to set the font color and style of each node.        
        override public function set data(value:Object):void {
        	if (!value) return;
            super.data = value;
            var treeListdata:TreeListData=TreeListData(super.listData);
            //TreeListData(super.listData).icon=value.thumb;
            if(TreeListData(super.listData).hasChildren){
                setStyle("fontWeight", 'bold');
            } else {
            	if(value.thumb){
		            treeListdata.icon=IconUtility.getClass(this, value.thumb, 27,27);
	                setStyle("fontWeight", 'normal');
	            }
            }  
        }
     
        // Override the updateDisplayList() method 
        // to set the text for each tree node.      
        override protected function updateDisplayList(unscaledWidth:Number, 
            unscaledHeight:Number):void {
       
            super.updateDisplayList(unscaledWidth, unscaledHeight);
            if(super.data)
            {
                if(TreeListData(super.listData).hasChildren){
                    var myStr:int = TreeListData(super.listData).item.children.length;
                    super.label.text =  TreeListData(super.listData).label + 
                        "(" + myStr + ")";
                }
            }
        }
    }
}
