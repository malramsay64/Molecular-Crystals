var doc = app.activeDocument;
for(var i = 0; i < doc.layers.length; i++){
    doc.activeLayer = doc.layers[i];
    app.doAction("Remove Black", "Default Actions");
    doc.activeLayer.visible = false;
}  
