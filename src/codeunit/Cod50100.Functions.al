codeunit 50100 "Functions"
{

    procedure FindLastInvoicedPrice(BilltoCustomerNo: Code[20]; ItemNo: Code[20]): Decimal
    var
        SalesInvLine: Record "Sales Invoice Line";
    begin
        SalesInvLine.SetRange("Bill-to Customer No.", BilltoCustomerNo);
        SalesInvLine.SetRange("No.", ItemNo);
        if SalesInvLine.FindLast() then
            exit(SalesInvLine."Unit Price");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payment Terms", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure OnDelete()
    begin
        Message('stop');
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'GetDatabaseTableTriggerSetup', '', false, false)]
    local procedure GetDatabaseTableTriggerSetup(TableId: Integer; var OnDatabaseInsert: Boolean; var OnDatabaseModify: Boolean; var OnDatabaseDelete: Boolean)
    begin
        if TableID = Database::"Payment Method" then begin
            OnDatabaseInsert := true;
            OnDatabaseModify := true;
            OnDatabaseDelete := true;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'OnDatabaseInsert', '', false, false)]
    local procedure OnDatabaseInsert()
    begin
        Message('Global Trigger Event OnDatabaseInsert');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'OnDatabaseModify', '', false, false)]
    local procedure OnDatabaseModify()
    begin
        Message('Global Trigger Event OnDatabaseModify');
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Global Triggers", 'OnDatabaseDelete', '', false, false)]
    local procedure OnDatabaseDelete()
    begin
        Message('Global Trigger Event OnDatabaseDelete');
    end;


    procedure CreateEntries()
    var
        SalesHeader: Record "Sales Header";
        rlSalesTree: Record "Sales Tree";
    begin
        rlSalesTree.DeleteAll();
        //SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        if SalesHeader.FindSet() then begin
            repeat
                CreateLevel0(SalesHeader, rlSalesTree);
                CreateLevel1(SalesHeader, rlSalesTree);
            until SalesHeader.Next() = 0;
        end;

    end;

    local procedure CreateLevel0(var SalesHeader: Record "Sales Header"; var rlSalesTree: Record "Sales Tree" temporary)
    begin
        rlSalesTree.Init();
        rlSalesTree."Entry No." := EntryNo;
        rlSalesTree.Level := 0;
        rlSalesTree."Document No." := SalesHeader."No.";
        rlSalesTree."Document Type" := SalesHeader."Document Type";
        rlSalesTree."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
        rlSalesTree.Date := SalesHeader."Document Date";
        rlSalesTree.Insert();
        EntryNo += 1;
    end;

    local procedure CreateLevel1(var SalesHeader: Record "Sales Header"; var rlSalesTree: Record "Sales Tree" temporary)
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        if SalesLine.FindSet() then begin
            repeat
                rlSalesTree.Init();
                rlSalesTree."Entry No." := EntryNo;
                rlSalesTree.Level := 1;
                rlSalesTree."Document No." := SalesHeader."No.";
                rlSalesTree."Document Type" := SalesHeader."Document Type";
                rlSalesTree."No." := SalesLine."No.";
                rlSalesTree.Description := SalesLine.Description;
                rlSalesTree.Quantity := SalesLine.Quantity;
                rlSalesTree."Line No" := SalesLine."Line No.";
                rlSalesTree.Type := SalesLine.Type;
                rlSalesTree.Insert();
                EntryNo += 1;
            until SalesLine.Next() = 0;
        end;
    end;

    // local procedure GetNextEntryNo(rlSalesTree: Record "Sales Tree" temporary): Integer
    // begin
    //     rlSalesTree.Reset();
    //     if rlSalesTree.FindLast() then
    //         exit(rlSalesTree."Entry No." + 1)
    //     else
    //         exit(0);
    // end;

    var
        EntryNo: Integer;
}




