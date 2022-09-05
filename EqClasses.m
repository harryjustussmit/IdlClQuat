/* vim: set syntax=magma :*/

freeze;

declare attributes AlgQuatOrd : LeftEquivalenceClassesWithPrescribedOrder,
                                RightEquivalenceClassesWithPrescribedOrder;

intrinsic EquivalenceClassesWithPrescribedOrder(O::AlgQuatOrd : Side:="Left") -> List
{
  Given an order in an algebra, compute representatives for the left/right equivalence classes of lattices with left/right multiplicator ring equal to O.
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  // early exit
  if Side eq "Left" and assigned O`LeftEquivalenceClassesWithPrescribedOrder then
    return O`LeftEquivalenceClassesWithPrescribedOrder;
  end if;

  if Side eq "Right" and assigned O`RightEquivalenceClassesWithPrescribedOrder then
    return O`RightEquivalenceClassesWithPrescribedOrder;
  end if;

  classes:=[* *];
  wk_classes:=WeakEquivalenceClassesWithPrescribedOrder(O : Side:=Side);
  for I in wk_classes do
    if Side eq "Left" then
      OI:=RightOrder(I);
      inv_cl:=LeftIdealClasses(OI);
      classes cat:= [* I*J : J in inv_cl *];
    else
      OI:=LeftOrder(I);
      inv_cl:=RightIdealClasses(OI);
      classes cat:= [* J*I : J in inv_cl *];
    end if;
  end for;

  // assign attributes
  if Side eq "Left" then
    O`LeftEquivalenceClassesWithPrescribedOrder:=classes;
  end if;

  if Side eq "Right" then
    O`RightEquivalenceClassesWithPrescribedOrder:=classes;
  end if;
  return classes;
end intrinsic;

/* TEST
 
*/

