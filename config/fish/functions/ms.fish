# Defined in - @ line 2
function ms --description 'Replace non-newline whitespace into monospace'
	string replace -ar '[^\S\r\n]+' ' ' $argv
end
