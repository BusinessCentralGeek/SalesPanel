page 50103 "Sales Tree Invoices"
{
    Caption = 'Sales Invoices';
    PageType = ListPart;
    SourceTable = "Sales Tree";
    UsageCategory = Lists;
    SourceTableView = where("Document Type" = filter(Invoice));


    layout
    {
        area(content)
        {
            repeater(General)
            {
                IndentationColumn = Indentation;
                ShowAsTree = true;
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Level; Rec.Level)
                {
                    ToolTip = 'Specifies the value of the Level field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ToolTip = 'Specifies the value of the Document No. field.';
                    ApplicationArea = All;
                    HideValue = HideValues;
                    StyleExpr = StyleExpr;
                }
                field("Sell-to Customer No."; Rec."Sell-to Customer No.")
                {
                    ToolTip = 'Specifies the value of the Sell-to Customer No. field.';
                    ApplicationArea = All;
                    HideValue = HideValues;
                    StyleExpr = StyleExpr;
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Date field.';
                    ApplicationArea = All;
                    StyleExpr = StyleExpr;
                }
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                    ApplicationArea = All;
                    HideValue = not HideValues;
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
                    SalesOrder: Page "Sales Invoice";
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

    trigger OnInit()
    begin
        Rec.DeleteAll();
    end;

    trigger OnAfterGetRecord()
    begin
        Indentation := Rec.Level;

        case Indentation of
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

    var
        Indentation: Integer;
        HideValues: Boolean;
        StyleExpr: Text;
}
