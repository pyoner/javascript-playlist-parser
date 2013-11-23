# http://gonze.com/playlists/playlist-format-survey.html#M3U

EXTENDED = '#EXTM3U'
COMMENT_RE = /:(-?\d+),(.+)\s*-\s*(.+)\n(.+)/
COMMENT_RE2 = /:(-?\d+),(.+)\n(.+)/

# #EXTINF:822,Iron Maiden - Rime of the Ancient Mariner
extended = (line) ->
  match = line.match COMMENT_RE
  if match and match.length is 5
    length: match[1]
    artist: match[2]
    title: match[3]
    file: match[4].trim()
  else
    match = line.match COMMENT_RE2
    if match
      length: match[1]
      artist: match[2]
      title: match[2]
      file: match[3].trim()

simple = (string) ->
  file: string.trim()

empty = (line) ->
  !!line.trim().length

comments = (line) ->
  line[0] isnt '#'

parse = (playlist) ->
  firstNewline = playlist.search '\n'
  if playlist.substr(0, firstNewline) is EXTENDED
    playlist.substr(firstNewline).split('#').filter(empty).map extended
  else
    playlist.split('\n').filter(empty).filter(comments).map simple

(if module? then module.exports else window).M3U =
  name: 'm3u'
  parse: parse

