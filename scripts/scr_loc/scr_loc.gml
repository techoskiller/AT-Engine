function loc(english_value,japanese_value) {
	if (global.lang == "en")
		return english_value
	
	if (global.lang == "ja")
		return japanese_value
}

function loc_getfont(font) {
    if (font == fnt_main) {
        if (global.lang == "ja")
			return fnt_main_ja
        return fnt_main
    }
    
    return font
}