package {
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.SharedObject;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	public class ConnectionManager {
		public static var domainUrl:String="";
		public static var userName:String="";
		public static var userPass:String="";
		public static var phpsessid:String="";
		
		// Загружаем config.xml
		public static function loadConfig(_callbackFunction:Function,
										  _errorFunction:Function):void{
			var loaderConfig:URLLoader = new URLLoader();
			loaderConfig.addEventListener(Event.COMPLETE,_callbackFunction);
			loaderConfig.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loaderConfig.load(new URLRequest("config.xml"));
		}
		
		// Сохраняем config.xml
		public static function saveConfig(_domain:String,
										  _login:String):void{
			var xmlToSave:XML=new XML(	<config>
											<domain />
											<login />
										</config>);
			xmlToSave.domain.@value=_domain;
			xmlToSave.login.@value=_login;
			//saveToFile(File.applicationDirectory.nativePath+"/config.xml", xmlToSave.toXMLString());
			// Грузим сохраненные локально данные о настройках качества графики, музыки и звука
			
			var so:SharedObject = SharedObject.getLocal("JMStorage");
			so.data.config=xmlToSave.toXMLString();
			so.flush();
		}
		
		// Загружаем дерево-каталог
		public static function loadFullTree(_callbackFunction:Function,
											_errorFunction:Function,
											showPics:Boolean):void {
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func=showPics ? "getXMLTree" : "getCatXMLTree";
			vars.login=userName;
			vars.phpsessid=phpsessid;
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}
		
		// Загружаем параметры галереи
		public static function loadApplicationProperties(_callbackFunction:Function,
														 _errorFunction:Function):void{
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="getProp";
			vars.login=userName;
			vars.phpsessid=phpsessid;
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}
		
		// Авторизуемся
		public static function authorizationRequest(_callbackFunction:Function,
													_errorFunction:Function):void{
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="auth";
			vars.login=userName;
			vars.password=userPass;
			vars.phpsessid=phpsessid;
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}
		
		// Загружаем содержимое категории
		public static function getCategoryContent(_callbackFunction:Function,
												  _errorFunction:Function,
												  catId:int):void{
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="getImages";
			vars.catid=catId;
			vars.login=userName;
			vars.phpsessid=phpsessid;
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}
		
		// Создаем категорию в текущей категории
		public static function createCategory(_callbackFunction:Function,
											  _parent:String,
											  _name:String,
											  _description:String):void{
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="edit";
			vars.type="createcat";
			vars.login=userName;
			vars.phpsessid=phpsessid;
			vars.param1=_parent;
			vars.param2=_name;
			vars.param3=_description;
			vars.param4="0";
			vars.param5="0";
			vars.param6="1";
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.load(request);
		}
		
		// Удаляем категорию
		public static function deleteCategory(_callbackFunction:Function,
											  _errorFunction:Function,
											  catId:int ):void{
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="edit";
			vars.type="deletecat";
			vars.login=userName;
			vars.phpsessid=phpsessid;
			vars.param1=catId;
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
			
		}
		
		// Переименовываем категорию категорию
		public static function renameCategory(_callbackFunction:Function,
											  _errorFunction:Function,
											  catId:String,
											  newName:String):void{
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="edit";
			vars.type="renamecat";
			vars.login=userName;
			vars.phpsessid=phpsessid;
			vars.param1=catId;
			vars.param2=newName;
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}

		// Удаляем фотографии
		public static function deletePhotos(_callbackFunction:Function,
											_errorFunction:Function,
											photosIds:String):void{
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="edit";
			vars.type="deletefoto";
			vars.login=userName;
			vars.phpsessid=phpsessid;
			vars.param1=photosIds;
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}
		
		// Аплоадим фотографию
		public static function uploadBase64Photo(	_callbackFunction:Function,
													_errorFunction:Function,
													catId:String,
													fileName:String,
													imgDescription:String,
													imgAuthor:String,
													imgTags:String,
													imgPublished:String,
													encodedPics:Array
		):void{
			var request:URLRequest = new URLRequest (domainUrl+"index2.php");
			var loader: URLLoader = new URLLoader();
			var vars:URLVariables = new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="upload";
			vars.catId=catId;
			vars.login=userName;
			vars.phpsessid=phpsessid;
			vars.file=fileName;
			vars.imgDescription=imgDescription;
			vars.imgAuthor=imgAuthor;
			vars.imgTags=imgTags;
			vars.imgPublished=imgPublished;
			for (var i:int=0; i<encodedPics.length; i++){
				vars[encodedPics[i].picName]=[encodedPics[i].picData];
			}
			request.method = URLRequestMethod.POST;
			request.data = vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction); 
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}

		// Перезаписываем фотографию
		public static function reUploadBase64Photo(	_callbackFunction:Function,
													_errorFunction:Function,
													catId:String,
													photoid:String,
													encodedPics:Array
		):void{
			var request:URLRequest = new URLRequest (domainUrl+"index2.php");
			var loader: URLLoader = new URLLoader();
			var vars:URLVariables = new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="upload";
			vars.catId=catId;
			vars.photoid=photoid;
			vars.login=userName;
			vars.phpsessid=phpsessid;
			for (var i:int=0; i<encodedPics.length; i++){
				vars[encodedPics[i].picName]=[encodedPics[i].picData];
			}
			request.method = URLRequestMethod.POST;
			request.data = vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}

		// Редактируем свойство фотографии
		public static function setPhotoProperty(	_callbackFunction:Function,
													_errorFunction:Function,
													photoId:String,
													property:String,
													value:String):void{
			try
			{
				// Отсылаю на сохранение этого свойства
				var loader:URLLoader = new URLLoader();
				var vars:URLVariables=new URLVariables();
				vars.option="com_jmediamanager";
				vars.device="pc";
				vars.controller="server";
				vars.no_html="1";
				vars.func="edit";
				vars.type="editfoto";
				vars.login=userName;
				vars.phpsessid=phpsessid;
				vars.param1=photoId;
				vars.param2=property;
				vars.param3=value;
				var request:URLRequest=new URLRequest(domainUrl+"index2.php");
				request.method = URLRequestMethod.POST;
				request.data=vars;
				loader.addEventListener(Event.COMPLETE, _callbackFunction);
				loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
				loader.load(request);
			}
			catch(e:Error)
			{
				return;
			}
		}
		
		// Команда переместить элемент дерева на сервере
		public static function moveTreeItem(_callbackFunction:Function,
											_errorFunction:Function,
											itemType:String,
											idFrom:String,
											toId:String):void{
			var loader:URLLoader = new URLLoader();
			var vars:URLVariables=new URLVariables();
			vars.option="com_jmediamanager";
			vars.device="pc";
			vars.controller="server";
			vars.no_html="1";
			vars.func="edit";
			vars.type="move";
			vars.login=userName;
			vars.phpsessid=phpsessid;
			vars.param1=itemType;
			vars.param2=idFrom;
			vars.param3=toId;
			var request:URLRequest=new URLRequest(domainUrl+"index2.php");
			request.method = URLRequestMethod.POST;
			request.data=vars;
			loader.addEventListener(Event.COMPLETE, _callbackFunction);
			loader.addEventListener(IOErrorEvent.IO_ERROR, _errorFunction);
			loader.load(request);
		}
		
/*		private static function saveToFile(url:String, data:String):void {
			var destination:File=new File(url);
			var myFileStream:FileStream = new FileStream();
			myFileStream.open(destination, FileMode.WRITE);
			myFileStream.writeUTFBytes(data);
			myFileStream.close();
		} */
		
	}
}