package webp;
import haxe.io.BytesData;

#if !openfl_next
import openfl.Lib;
#else
import lime.system.System;

#if !macro
@:build(lime.system.CFFI.build("openfl-webp"))
#end

#end

class WebpRaw {
#if !openfl_next
	static public var webp_get_decoder_version = Lib.load("openfl-webp", "webp_get_decoder_version", 0);
	static public var webp_get_encoder_version = Lib.load("openfl-webp", "webp_get_encoder_version", 0);
	static public var webp_get_features = Lib.load("openfl-webp", "webp_get_features", 1);
	static public var webp_decode_bgra = Lib.load("openfl-webp", "webp_decode_bgra", 1);
	static public var webp_encode_bgra = Lib.load("openfl-webp", "webp_encode_bgra", 5);
#else
	@:cffi static public function webp_get_decoder_version():String;
	@:cffi static public function webp_get_encoder_version():String;
	@:cffi static public function webp_get_features(bytes:Dynamic):Array<Dynamic>;
	@:cffi static public function webp_decode_bgra(bytes:Dynamic):Array<Dynamic>;
	@:cffi static public function webp_encode_bgra(bytes:Dynamic, width:Int, height:Int, lossless:Bool, quality_factor:Float):BytesData;
#end
}