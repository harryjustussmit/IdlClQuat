/* vim: set syntax=magma :*/

    AttachSpec("~/IdlClQuat/spec");
    Attach("~/IdlClQuat/dev/IntermediateIdeals.m");
    Attach("~/IdlClQuat/dev/BrandtMat_naive.m");
    Attach("~/IdlClQuat/dev/InvBrandtMat.m");

    p:=3; s:=2; //example in the paper
    //p:=23; s:=2;
    QQ:=RationalsAsNumberField();
    ZZ:=Integers(QQ);
    B<i, j, k> := QuaternionAlgebra(QQ, -1, -p);
    O := Order([s*i,s*j,s*k]);
    IsEichler(O);

    import "/../../opt/magma/current/package/Algebra/AlgAss/enum.m" : RightIdealClassesAndOrders;
    Is := RightIdealClassesAndOrders(O : Support :=[ ], compute_order_classes := false);
    #Is;


