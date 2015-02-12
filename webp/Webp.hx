package webp;
import haxe.io.Bytes;
import haxe.io.BytesData;
import flash.utils.ByteArray;
import flash.display.BitmapData;
import flash.errors.Error;
import flash.geom.Rectangle;

class Webp {
	/**
	 * Obtains the string version of the decoder
	 * 
	 * @example Webp.getDecoderVersion() == "0.2.0"
	 * 
	 * @return string
	 */
	static public function getDecoderVersion():String {
		return WebpRaw.webp_get_decoder_version();
	}

	/**
	 * Obtains the string version of the encoder
	 * 
	 * @example Webp.getEncoderVersion() == "0.2.0"
	 * 
	 * @return string
	 */
	static public function getEncoderVersion():String {
		return WebpRaw.webp_get_encoder_version();
	}

	/**
	 * Obtains information about a webp image.
	 * 
	 * @param  bytes     Webp bytes
	 * 
	 * @return Information about the image
	 */
	static public function getImageInfo(bytes:ByteArray):WebpInfo {
		var infoArray = WebpRaw.webp_get_info((bytes));
		var info:WebpInfo = new WebpInfo();
		
		info.width = infoArray[0];
		info.height = infoArray[1];
		info.hasAlpha = (infoArray[2] != 0);
		info.bitstreamVersion = infoArray[3];
		info.noIncrementalDecoding = infoArray[4];
		info.rotate = infoArray[5];
		info.uvSampling = infoArray[6];

		return info;
	}

	/**
	 * Decodes a webp image and returns a BitmapData with the image.
	 * 
	 * @param  bytes    Webp bytes
	 * 
	 * @return BitmapData with the image
	 */
	static public function decodeAsBitmapData(bytes:ByteArray):BitmapData {
#if nodejs
		return _decode(WebpRaw.webp_decode_rgba(bytes.byteView));
#else
		return _decode(WebpRaw.webp_decode_rgba(bytes));
#end
	}

	/**
	 * Encodes a BitmapData image into a webp image and returns it as a ByteArray.
	 * 
	 * @param   bitmapData       Image to encode
	 * @param   lossless         Wether to perform a lossless compression or not
	 * @param   quality_factor   Quality of the encoded image 0-100
	 * 
	 * @return  ByteArray with the image encoded as Webp
	 */
	static public function encodeBitmapData(bitmapData:BitmapData, lossless:Bool = false, quality_factor:Float = 86):ByteArray {
#if nodejs
		var input_bytes = bitmapData.getPixels(bitmapData.rect).byteView;
#else
		var input_bytes = bitmapData.getPixels(bitmapData.rect);
#end
		return ByteArray.fromBytes(Bytes.ofData(WebpRaw.webp_encode_rgba(input_bytes, bitmapData.width, bitmapData.height, lossless, quality_factor)));
	}

	static private function _decode(arr:Array<Dynamic>):BitmapData {
		var width:Int = cast(arr[0]);
		var height:Int = cast(arr[1]);
		var bytes:Bytes = Bytes.ofData(cast(arr[2]));
		if (width <= 0 || height <= 0) throw(new Error("Invalid webp size"));
		if (bytes.length != width * height * 4) throw(new Error("Invalid webp size"));
		var bitmapData:BitmapData = new BitmapData(width, height);
		bitmapData.setPixels(bitmapData.rect, ByteArray.fromBytes(bytes));
		return bitmapData;
	}	
}