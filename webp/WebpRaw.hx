package webp;

#if !openfl_next
import openfl.Lib;
#else
import lime.system.System;
#end

class WebpRaw {
#if !openfl_next
	static public var webp_get_decoder_version = Lib.load("openfl-webp", "webp_get_decoder_version", 0);
	static public var webp_get_encoder_version = Lib.load("openfl-webp", "webp_get_encoder_version", 0);
	static public var webp_get_info = Lib.load("openfl-webp", "webp_get_features", 1);
	static public var webp_decode_argb = Lib.load("openfl-webp", "webp_decode_argb", 1);
	static public var webp_encode_argb = Lib.load("openfl-webp", "webp_encode_argb", 5);
#else
	static public var webp_get_decoder_version = System.load("openfl-webp", "webp_get_decoder_version", 0);
	static public var webp_get_encoder_version = System.load("openfl-webp", "webp_get_encoder_version", 0);
	static public var webp_get_info = System.load("openfl-webp", "webp_get_features", 1);
	static public var webp_decode_argb = System.load("openfl-webp", "webp_decode_argb", 1);
	static public var webp_encode_argb = System.load("openfl-webp", "webp_encode_argb", 5);
#end
}