page 50105 "Sales Panel"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            grid(Mygrid)
            {
                group(OrdersGroup)
                {
                    ShowCaption = false;
                    part(Orders; "Sales Tree Orders")
                    {
                        ApplicationArea = all;
                    }

                }
                group(QuotesGroup)
                {
                    ShowCaption = false;
                    part(Quotes; "Sales Tree Quotes")
                    {
                        ApplicationArea = all;
                    }

                }
            }
            grid(Mygrid2)
            {
                group(InvoicesGroup)
                {
                    ShowCaption = false;
                    part(Invoices; "Sales Tree Invoices")
                    {
                        ApplicationArea = all;
                    }

                }
                group(MemosGroup)
                {
                    ShowCaption = false;
                    part(Memos; "Sales Tree Cr. Memo")
                    {
                        ApplicationArea = all;
                    }
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;
                Image = WorkCenterLoad;
                Caption = 'Load Panel';

                trigger OnAction();
                var
                    cduFuncs: Codeunit Functions;
                begin
                    cduFuncs.CreateEntries();
                end;
            }
        }
    }

}