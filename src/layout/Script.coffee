unicode = require 'unicode-properties'

# This maps the Unicode Script property to an OpenType script tag
# Data from http://www.microsoft.com/typography/otspec/scripttags.htm
# and http://www.unicode.org/Public/UNIDATA/PropertyValueAliases.txt.
UNICODE_SCRIPTS = 
  Caucasian_Albanian: 'aghb'
  Arabic: 'arab'
  Imperial_Aramaic: 'armi'
  Armenian: 'armn'
  Avestan: 'avst'
  Balinese: 'bali'
  Bamum: 'bamu'
  Bassa_Vah: 'bass'
  Batak: 'batk'
  Bengali: ['bng2', 'beng']
  Bopomofo: 'bopo'
  Brahmi: 'brah'
  Braille: 'brai'
  Buginese: 'bugi'
  Buhid: 'buhd'
  Chakma: 'cakm'
  Canadian_Aboriginal: 'cans'
  Carian: 'cari'
  Cham: 'cham'
  Cherokee: 'cher'
  Coptic: 'copt'
  Cypriot: 'cprt'
  Cyrillic: 'cyrl'
  Devanagari: ['dev2', 'deva']
  Deseret: 'dsrt'
  Duployan: 'dupl'
  Egyptian_Hieroglyphs: 'egyp'
  Elbasan: 'elba'
  Ethiopic: 'ethi'
  Georgian: 'geor'
  Glagolitic: 'glag'
  Gothic: 'goth'
  Grantha: 'gran'
  Greek: 'grek'
  Gujarati: ['gjr2', 'gujr']
  Gurmukhi: ['gur2', 'guru']
  Hangul: 'hang'
  Han: 'hani'
  Hanunoo: 'hano'
  Hebrew: 'hebr'
  Hiragana: 'hira'
  Pahawh_Hmong: 'hmng'
  Katakana_Or_Hiragana: 'hrkt'
  Old_Italic: 'ital'
  Javanese: 'java'
  Kayah_Li: 'kali'
  Katakana: 'kana'
  Kharoshthi: 'khar'
  Khmer: 'khmr'
  Khojki: 'khoj'
  Kannada: ['knd2', 'knda']
  Kaithi: 'kthi'
  Tai_Tham: 'lana'
  Lao: 'lao '
  Latin: 'latn'
  Lepcha: 'lepc'
  Limbu: 'limb'
  Linear_A: 'lina'
  Linear_B: 'linb'
  Lisu: 'lisu'
  Lycian: 'lyci'
  Lydian: 'lydi'
  Mahajani: 'mahj'
  Mandaic: 'mand'
  Manichaean: 'mani'
  Mende_Kikakui: 'mend'
  Meroitic_Cursive: 'merc'
  Meroitic_Hieroglyphs: 'mero'
  Malayalam: ['mlm2', 'mlym']
  Modi: 'modi'
  Mongolian: 'mong'
  Mro: 'mroo'
  Meetei_Mayek: 'mtei'
  Myanmar: ['mym2', 'mymr']
  Old_North_Arabian: 'narb'
  Nabataean: 'nbat'
  Nko: 'nko '
  Ogham: 'ogam'
  Ol_Chiki: 'olck'
  Old_Turkic: 'orkh'
  Oriya: 'orya'
  Osmanya: 'osma'
  Palmyrene: 'palm'
  Pau_Cin_Hau: 'pauc'
  Old_Permic: 'perm'
  Phags_Pa: 'phag'
  Inscriptional_Pahlavi: 'phli'
  Psalter_Pahlavi: 'phlp'
  Phoenician: 'phnx'
  Miao: 'plrd'
  Inscriptional_Parthian: 'prti'
  Rejang: 'rjng'
  Runic: 'runr'
  Samaritan: 'samr'
  Old_South_Arabian: 'sarb'
  Saurashtra: 'saur'
  Shavian: 'shaw'
  Sharada: 'shrd'
  Siddham: 'sidd'
  Khudawadi: 'sind'
  Sinhala: 'sinh'
  Sora_Sompeng: 'sora'
  Sundanese: 'sund'
  Syloti_Nagri: 'sylo'
  Syriac: 'syrc'
  Tagbanwa: 'tagb'
  Syloti_Nagri: 'takr'
  Tai_Le: 'tale'
  New_Tai_Lue: 'talu'
  Tamil: 'taml'
  Tai_Viet: 'tavt'
  Telugu: ['tel2', 'telu']
  Tifinagh: 'tfng'
  Tagalog: 'tglg'
  Thaana: 'thaa'
  Thai: 'thai'
  Tibetan: 'tibt'
  Tirhuta: 'tirh'
  Ugaritic: 'ugar'
  Vai: 'vai '
  Warang_Citi: 'wara'
  Old_Persian: 'xpeo'
  Cuneiform: 'xsux'
  Yi: 'yi  '
  Inherited: 'zinh'
  Common: 'zyyy'
  Unknown: 'zzzz'
  
exports.fromUnicode = (script) ->
  return UNICODE_SCRIPTS[script]
  
exports.forString = (string) ->
  len = string.length
  idx = 0
  while idx < len
    code = string.charCodeAt idx++
    
    # Check if this is a high surrogate
    if 0xd800 <= code <= 0xdbff and idx < len
      next = str.charCodeAt idx
      
      # Check if this is a low surrogate
      if 0xdc00 <= next <= 0xdfff
        idx++
        code = ((code & 0x3FF) << 10) + (next & 0x3FF) + 0x10000
        
    script = unicode.getScript code
    unless script in ['Common', 'Inherited', 'Unknown']
      return UNICODE_SCRIPTS[script]
      
  return UNICODE_SCRIPTS.Unknown
  
exports.forCodePoints = (codePoints) ->
  for codePoint in codePoints
    script = unicode.getScript codePoint
    unless script in ['Common', 'Inherited', 'Unknown']
      return UNICODE_SCRIPTS[script]
    
  return UNICODE_SCRIPTS.Unknown
  
# The scripts in this map are written from right to left
RTL =
  arab: true # Arabic
  hebr: true # Hebrew
  syrc: true # Syriac
  thaa: true # Thaana
  cprt: true # Cypriot Syllabary
  khar: true # Kharosthi
  phnx: true # Phoenician
  'nko ': true # N'Ko
  lydi: true # Lydian
  avst: true # Avestan
  armi: true # Imperial Aramaic
  phli: true # Inscriptional Pahlavi
  prti: true # Inscriptional Parthian
  sarb: true # Old South Arabian
  orkh: true # Old Turkic, Orkhon Runic
  samr: true # Samaritan
  mand: true # Mandaic, Mandaean
  merc: true # Meroitic Cursive
  mero: true # Meroitic Hieroglyphs

  # Unicode 7.0 (not listed on http://www.microsoft.com/typography/otspec/scripttags.htm)
  mani: true # Manichaean
  mend: true # Mende Kikakui
  nbat: true # Nabataean
  narb: true # Old North Arabian
  palm: true # Palmyrene
  phlp: true # Psalter Pahlavi

exports.direction = (script) ->
  if RTL[script]
    return 'rtl'
    
  return 'ltr'