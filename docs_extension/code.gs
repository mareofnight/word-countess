function doTest() {
  Logger.log(getFolderWordCount(""));
}





function showFolderWordCount() {
  var ui = DocumentApp.getUi(); // Same variations.
  var result = ui.alert('Word count for this folder: '+ getFolderWordCount(""));
}



function countWords(text) {
  return text.split(" ").length;
}

function getFileWordCount(id) {
  var doc,
      content = '';
  try {
    Logger.log(DriveApp.getFileById(id).getEditors());
    doc = DocumentApp.openById(id);// need to catch the exception that happens when this is not a doc
    content = doc.getBody().getText();
    return countWords(content);
  }
  catch (err) {//TODO: check the type of error, possibly display a message if it's something other than the wrong sort of file
    return null;
  }
  return countWords(content);
}

function getFolderWordCount(id) {
  var words = 0;
  var folder = DriveApp.getFolderById(id);
  var files = folder.getFiles();

  while(files.hasNext()) {
    var fileId = files.next().getId();
    Logger.log(fileId);
    words = words + getFileWordCount(fileId);
  }
  return words;
}



function showSidebar() {
  var ui = HtmlService.createHtmlOutputFromFile('Sidebar')
      .setTitle('Word Counter');
  DocumentApp.getUi().showSidebar(ui);
}

function onOpen() {
  DocumentApp.getUi().createAddonMenu()
      .addItem('Open', 'showSidebar')
      .addItem('Quick word count', 'showSidebar')//TODO: replace with correct function
  .addItem('Manage projects', 'showSidebar')//TODO: build interface for this
      .addToUi();
}

function onInstall(e) {
  onOpen(e);
  //TODO: add other install stuff here
}
