page 50104 "Sales Tree Cr. Memos"
{
    Caption = 'Sales Cr. Memos';
    PageType = ListPart;
    SourceTable = "Sales Tree";
    UsageCategory = Lists;
    Editable = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = Rec.Indentation;
                ShowAsTree = true;

                field(Level; Rec.Indentation)
                {
                    ToolTip = 'Specifies the value of the Level field.';
                    ApplicationArea = All;
                    Visible = false;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                    HideValue = HideValues;
                    StyleExpr = StyleExpr;
                    Editable = false;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                    ApplicationArea = All;
                    HideValue = HideValues;
                    StyleExpr = StyleExpr;
                    Editable = false;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                    Editable = false;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                    HideValue = not HideValues;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(Open)
            {
                Image = ShowChart;
                ApplicationArea = all;
                Caption = 'Open document';

                trigger OnAction()
                var
                    SalesHeader: Record "Sales Header";
                    SalesOrder: Page "Sales Credit Memo";
                begin
                    SalesHeader.SetRange("No.", Rec."Document No.");
                    if SalesHeader.FindFirst() then begin
                        SalesOrder.SetTableView(SalesHeader);
                        SalesOrder.RunModal();
                    end;
                end;
            }

            action(Open2)
            {
                Image = Customer;
                ApplicationArea = all;
                Caption = 'Open customer';

                trigger OnAction()
                var
                    Customer: Record "Customer";
                    CustomerCard: Page "Customer Card";
                begin
                    Customer.SetRange("No.", Rec."Sell-to Customer No.");
                    if Customer.FindFirst() then begin
                        CustomerCard.SetTableView(Customer);
                        CustomerCard.RunModal();
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        case Rec.Indentation of
            0:
                begin
                    HideValues := false;
                    StyleExpr := 'Strong';
                end;
            1:
                begin
                    HideValues := true;
                end;
        end;
    end;

    trigger OnInit()
    begin
        LoadMemos();
        Rec.FindFirst();
    end;

    procedure LoadMemos()
    var
        SalesTreePanelFunctions: Codeunit SalesTreePanelFunctions;
    begin
        SalesTreePanelFunctions.CreateCrMemoEntries(Rec);
    end;

    var
        HideValues: Boolean;
        StyleExpr: Text;
}
