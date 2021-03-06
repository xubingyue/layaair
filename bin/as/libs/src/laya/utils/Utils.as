package laya.utils {
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.maths.Rectangle;
	
	/**
	 * <code>Utils</code> 是工具类。
	 */
	public class Utils {
		/**@private */
		private static var _gid:int = 1;
		/**@private */
		private static var _pi:Number = /*[STATIC SAFE]*/ 180 / Math.PI;
		/**@private */
		private static var _pi2:Number = /*[STATIC SAFE]*/ Math.PI / 180;
		
		/**
		 * 角度转弧度。
		 * @param	angle 角度值。
		 * @return	返回弧度值。
		 */
		public static function toRadian(angle:Number):Number {
			return angle * _pi2;
		}
		
		/**
		 * 弧度转换为角度。
		 * @param	radian 弧度值。
		 * @return	返回角度值。
		 */
		public static function toAngle(radian:Number):Number {
			return radian * _pi;
		}
		
		/**
		 * 将传入的 uint 类型颜色值转换为字符串型颜色值。
		 * @param color 颜色值。
		 * @return 字符串型颜色值。
		 */
		public static function toHexColor(color:Number):String {
			if (color < 0 || isNaN(color)) return null;
			var str:String = color.toString(16);
			while (str.length < 6) str = "0" + str;
			return "#" + str;
		}
		
		/**获取一个全局唯一ID。*/
		public static function getGID():int {
			return _gid++;
		}
		
		/**
		 * 将字符串解析成 XML 对象。
		 * @param value 需要解析的字符串。
		 * @return js原生的XML对象。
		 */
		public static function parseXMLFromString(value:String):XmlDom {
			var rst:*;
			__JS__("rst=(new DOMParser()).parseFromString(value,'text/xml')");
			return rst;
		}
		
		/**
		 * @private
		 * <p>连接数组。和array的concat相比，此方法不创建新对象</p>
		 * <b>注意：</b>若 参数 a 不为空，则会改变参数 source 的值为连接后的数组。
		 * @param	source 待连接的数组目标对象。
		 * @param	array 待连接的数组对象。
		 * @return 连接后的数组。
		 */
		public static function concatArray(source:Array, array:Array):Array {
			if (!array) return source;
			if (!source) return array;
			var i:int, len:int = array.length;
			for (i = 0; i < len; i++) {
				source.push(array[i]);
			}
			return source;
		}
		
		/**
		 * @private
		 * 清空数组对象。
		 * @param	array 数组。
		 * @return	清空后的 array 对象。
		 */
		public static function clearArray(array:Array):Array {
			if (!array) return array;
			array.length = 0;
			return array;
		}
		
		/**
		 * @private
		 * 清空source数组，复制array数组的值。
		 * @param	source 需要赋值的数组。
		 * @param	array 新的数组值。
		 * @return 	复制后的数据 source 。
		 */
		public static function copyArray(source:Array, array:Array):Array {		
			source || (source = []);
			if (!array) return source;
			source.length = array.length;
			var i:int, len:int = array.length;
			for (i = 0; i < len; i++) {
				source[i]=array[i];
			}
			return source;
		}
		
		/**
		 * @private
		 * 根据传入的显示对象 <code>Sprite</code> 和此显示对象上的 两个点，返回此对象上的两个点在舞台坐标系上组成的最小的矩形区域对象。
		 * @param	sprite 显示对象 <code>Sprite</code>。
		 * @param	x0	点一的 X 轴坐标点。
		 * @param	y0	点一的 Y 轴坐标点。
		 * @param	x1	点二的 X 轴坐标点。
		 * @param	y1	点二的 Y 轴坐标点。
		 * @return 两个点在舞台坐标系组成的矩形对象 <code>Rectangle</code>。
		 */
		public static function getGlobalRecByPoints(sprite:Sprite, x0:Number, y0:Number, x1:Number, y1:Number):Rectangle {
			var newLTPoint:Point;
			newLTPoint = new Point(x0, y0);
			newLTPoint = sprite.localToGlobal(newLTPoint);
			var newRBPoint:Point;
			newRBPoint = new Point(x1, y1);
			newRBPoint = sprite.localToGlobal(newRBPoint);
			
			return Rectangle._getWrapRec([newLTPoint.x, newLTPoint.y, newRBPoint.x, newRBPoint.y]);
		}
		
		/**
		 * 计算传入的显示对象 <code>Sprite</code> 的全局坐标系的坐标和缩放值，返回 <code>Rectangle</code> 对象存放计算出的坐标X值、Y值、ScaleX值、ScaleY值。
		 * @param	sprite <code>Sprite</code> 对象。
		 * @return  矩形对象 <code>Rectangle</code>
		 */
		public static function getGlobalPosAndScale(sprite:Sprite):Rectangle {
			return getGlobalRecByPoints(sprite, 0, 0, 1, 1);
		}
		
		/**
		 * 给传入的函数绑定作用域，返回绑定后的函数。
		 * @param	fun 函数对象。
		 * @param	scope 函数作用域。
		 * @return 绑定后的函数。
		 */
		public static function bind(fun:Function, scope:*):Function {
			var rst:Function;
			__JS__("rst=fun.bind(scope);");
			return rst;
		}
		
		/**
		 * 测量文本在指定样式下的宽度、高度信息。
		 * @param	txt 文本内容。
		 * @param	font 文本字体样式。
		 * @return 文本的宽高信息对象。如：{width:xxx,height:xxx}
		 */
		public static function measureText(txt:String, font:String):* {
			return RunDriver.measureText(txt, font);
		}
		
		/**
		 * @private
		 * 对传入的数组列表，根据子项的属性 Z 值进行重新排序。返回是否已重新排序的 Boolean 值。
		 * @param	childs 子对象数组。
		 * @return Boolean 值，表示是否已重新排序。
		 */
		public static function updateOrder(childs:Array):Boolean {
			if ( (!childs) || childs.length < 2) return false;
			
			var c:Sprite = childs[0];
			var i:int = 1, sz:int = childs.length;
			var z:Number = c._zOrder, low:Number, high:Number, mid:Number, zz:Number;
			var repaint:Boolean = false;
			
			for (i = 1; i < sz; i++) {
				c = childs[i] as Sprite;
				if (!c) continue;
				if ((z = c._zOrder) < 0) z = c._zOrder;
				if (z < childs[i - 1]._zOrder)//如果z小于前面，找到z>=的位置插入
				{
					mid = low = 0;
					high = i - 1;
					while (low <= high) {
						mid = (low + high) >>> 1;
						if (!childs[mid]) break;//这里有问题
						zz = childs[mid]._zOrder;
						if (zz < 0) zz = childs[mid]._zOrder;
						
						if (zz < z)
							low = mid + 1;
						else if (zz > z)
							high = mid - 1;
						else break;
					}
					if (z > childs[mid]._zOrder) mid++;
					childs.splice(i, 1);
					childs.splice(mid, 0, c);
					repaint = true;
				}
			}
			return repaint;
		}
		
		/**
		 * @private
		 * 批量移动点坐标。
		 * @param points 坐标列表。
		 * @param x x轴偏移量。
		 * @param y y轴偏移量。
		 */
		public static function transPointList(points:Array, x:Number, y:Number):void {
			var i:int, len:int = points.length;
			for (i = 0; i < len; i += 2) {
				points[i] += x;
				points[i + 1] += y;
			}
		}
		
		/**
		 * 解析一个字符串，并返回一个整数。和JS原生的parseInt不同：如果str为空或者非数字，原生返回NaN，这里返回0
		 * @param	str 要被解析的字符串
		 * @param	radix 表示要解析的数字的基数。该值介于 2 ~ 36 之间。如果它以 “0x” 或 “0X” 开头，将以 16 为基数。如果该参数小于 2 或者大于 36，则 parseInt() 将返回 NaN。
		 * @return	返回解析后的数字
		 */
		public static function parseInt(str:String, radix:int=0):int {
			var result:* = Browser.window.parseInt(str, radix);
			if (isNaN(result)) return 0;
			return result;
		}
	}
}