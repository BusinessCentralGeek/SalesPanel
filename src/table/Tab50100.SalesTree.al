table 50100 "Sales Tree"
{
    Caption = 'Sales Tree';
    DataClassification = SystemMetadata;
    TableType = Temporary;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
        }
        field(2; Indentation; Integer)
        {
            Caption = 'Indentation';
            DataClassification = SystemMetadata;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = SystemMetadata;
        }
        field(4; "Document Type"; Enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = SystemMetadata;
        }
        field(5; "Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = SystemMetadata;
        }
        field(6; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = SystemMetadata;
        }
        field(7; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(8; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = SystemMetadata;
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(10; Type; Enum "Sales Line Type")
        {
            Caption = 'Type';
            DataClassification = SystemMetadata;
        }
        field(11; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.';
            DataClassification = SystemMetadata;
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}
