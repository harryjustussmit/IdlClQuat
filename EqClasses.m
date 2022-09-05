/* vim: set syntax=magma :*/

freeze;

declare attributes AlgQuatOrd : LeftEquivalenceClasses,
                                RightEquivalenceClasses;

intrinsic EquivalenceClasses(O::AlgQuatOrd : Side:="Left") -> List
{
  Given an order in an algebra, compute representatives for the left/right equivalence classes of lattices with left/right multiplicator ring equal to O.
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";

  // early exit
  if Side eq "Left" and assigned O`LeftEquivalenceClasses then
    return O`LeftEquivalenceClasses;
  end if;

  if Side eq "Right" and assigned O`RightEquivalenceClasses then
    return O`RightEquivalenceClasses;
  end if;

  classes:=[* *];
  wk_classes:=WeakEquivalenceClasses(O : Side:=Side);
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
    O`LeftEquivalenceClasses:=classes;
  end if;

  if Side eq "Right" then
    O`RightEquivalenceClasses:=classes;
  end if;
  return classes;
end intrinsic;

/* TEST
 
    Attach("attempt1.m");
    B<i, j, k> := QuaternionAlgebra(RationalField(), -1, -7);
    OB := MaximalOrder(B);
    scale := 2;
    Oq := QuaternionOrder([scale * i, scale * j, k]);
    IsGorenstein(Oq);
    #WeakEquivalenceClasses(Oq : Side:="Left");
    #WeakEquivalenceClasses(Oq : Side:="Right");

*/

