function zettelID --description 'Make a zettel ID per The Archive.app'
	echo -n (date "+%Y%m%d%H%M") | pbcopy
end
