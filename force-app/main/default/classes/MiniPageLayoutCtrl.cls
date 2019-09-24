public with sharing class MiniPageLayoutCtrl { 
  public class FormFromMetadata {
    @AuraEnabled
    public List<FieldData> fields { get; set; }

    public FormFromMetadata() {
      this.fields = new List<FieldData>();
    }
  }

  public class MiniPageLayoutException extends Exception {}

  @AuraEnabled
  public static FormFromMetadata getFormElements(Id recordId, String fsName) {
    FormFromMetadata form = new FormFromMetadata();
    form.fields = getFieldsFromMetadata(recordId, fsName);
    return form;
  }

  @TestVisible
  private static list<FieldData> getFieldsFromMetadata(Id recordId, String fsName) {
    //Guard
    if (recordId == null) {
      throw new MiniPageLayoutException('Failed to find Record Id, cannot infer field data');
    }

    Schema.DescribeSObjectResult sObj = recordId.getSobjectType().getDescribe();
    Map<String, Schema.SObjectField> fieldMap = sObj.fields.getMap();

    List<Fieldset_Item__mdt> fieldset;
    try {
      fieldset = [
        SELECT Fieldset__r.object_API_Name__c, field_api_name__c
        FROM FieldSet_item__mdt
        WHERE fieldset__r.label = :fsName
      ];
    } catch (QueryException qe) {
      throw new MiniPageLayoutException('Failed to find any rows for Fieldset Name: ' + fsName + ' have you defined that feildset in metadata?');
    }

    List<FieldData> fields = new List<FieldData>();
    for (Fieldset_Item__mdt fi: fieldset) {
      Schema.DescribeFieldResult fieldDescribe = fieldMap.get(fi.Field_API_Name__c).getDescribe();
      fields.add(new FieldData(fieldDescribe));
    }
    return fields;
  }
}
