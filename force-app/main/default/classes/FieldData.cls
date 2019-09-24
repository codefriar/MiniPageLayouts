public with sharing class FieldData {
  public FieldData(Schema.DescribeFieldResult f) {
    this.DBRequired = f.isNillable();
    this.APIName = f.getName();
    this.Label = f.getLabel();
    this.Required = f.isNillable();
    this.Type = String.valueOf(f.getType());
  }

  public FieldData(Boolean DBRequired) {
    this.DBRequired = DBRequired;
  }

  @AuraEnabled
  public Boolean DBRequired { get; set; }

  @AuraEnabled
  public String APIName { get; set; }

  @AuraEnabled
  public String Label { get; set; }

  @AuraEnabled
  public Boolean Required { get; set; }

  @AuraEnabled
  public String Type { get; set; }
}
