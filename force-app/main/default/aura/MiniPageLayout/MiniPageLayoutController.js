({
  doInit: function (cmp, event, helper) {
    var fieldSetName = cmp.get('v.fieldSetName');
    var recordId     = cmp.get('v.recordId');

    var getFormAction = cmp.get('c.getFormElements');
    getFormAction.setParams({
      FSName  : fieldSetName,
      recordId: recordId
    });

    getFormAction.setCallback(this,
      function (response) {
        var state = response.getState();
        if (cmp.isValid() && state === "SUCCESS") {
          var form = response.getReturnValue();
          cmp.set('v.fields', form.fields);
        }
      }
    );
    $A.enqueueAction(getFormAction);
  }
})