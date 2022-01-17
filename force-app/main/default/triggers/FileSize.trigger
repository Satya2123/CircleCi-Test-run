trigger FileSize on ContentDocument (before insert) {
    System.debug('Trigger Check');
	for (ContentDocument cd : trigger.new) {
        System.debug(cd.ContentSize+cd.FileExtension+cd.Id);
        if (cd.ContentSize > 3000000) {
            cd.addError('Sorry, you cannot share this file.');
        }
    }
}