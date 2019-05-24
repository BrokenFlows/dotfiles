# Defined in - @ line 2
function ms --description 'Replace non-newline whitespace into monospace'
	echo -n (string replace -ar '[^\S\r\n]+' ' ' $argv) | pbcopy
end
