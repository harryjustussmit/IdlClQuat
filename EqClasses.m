/* vim: set syntax=magma :*/

freeze;

////////////////////////
// AlgQuatOrd
////////////////////////

declare attributes AlgQuatOrd : LeftEquivalenceClassesWithPrescribedOrder,
                                RightEquivalenceClassesWithPrescribedOrder;

intrinsic EquivalenceClassesWithPrescribedOrder(O::AlgQuatOrd : Side:="Left") -> List
{
  Given an order in an algebra, compute representatives for the left/right equivalence classes of lattices with left/right multiplicator ring equal to O.
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";
  require IsIntrinsic("RightClassSet") : "make sure that you have downloaded and attached https://github.com/dansme/hermite.";

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
      inv_cl:=LeftClassSet(OI);
      classes cat:= [* I*J : J in inv_cl *];
    else
      OI:=LeftOrder(I);
      inv_cl:=RightClassSet(OI);
      classes cat:= [* J*I : J in inv_cl *];
    end if;
  end for;

  // TESTS
  debug:=true;
  if debug then
      if Side eq "Left" then
        for i,j in [1..#classes] do
            if i ne j then
                I:=classes[i];
                J:=classes[j];
                assert not IsLeftIsomorphic(I,J);
            end if;
        end for;
      end if;

      if Side eq "Right" then
        for i,j in [1..#classes] do
            if i ne j then
                I:=classes[i];
                J:=classes[j];
                assert not IsRightIsomorphic(I,J);
            end if;
        end for;
      end if;
  end if;

  // assign attributes
  if Side eq "Left" then
    O`LeftEquivalenceClassesWithPrescribedOrder:=classes;
  end if;

  if Side eq "Right" then
    O`RightEquivalenceClassesWithPrescribedOrder:=classes;
  end if;
  return classes;
end intrinsic;

////////////////////////
// AlgAssVOrd
////////////////////////

declare attributes AlgAssVOrd : LeftEquivalenceClassesWithPrescribedOrder,
                                RightEquivalenceClassesWithPrescribedOrder;

intrinsic EquivalenceClassesWithPrescribedOrder(O::AlgAssVOrd : Side:="Left") -> List
{
  Given an order in an algebra, compute representatives for the left/right equivalence classes of lattices with left/right multiplicator ring equal to O.
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";
  require IsIntrinsic("RightClassSet") : "make sure that you have downloaded and attached https://github.com/dansme/hermite.";
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
      inv_cl:=LeftClassSet(OI);
      classes cat:= [* I*J : J in inv_cl *];
    else
      OI:=LeftOrder(I);
      inv_cl:=RightClassSet(OI);
      classes cat:= [* J*I : J in inv_cl *];
    end if;
  end for;

  // TESTS
  debug:=true;
  if debug then
      if Side eq "Left" then
        for i,j in [1..#classes] do
            if i ne j then
                I:=lideal<O|ZBasis(classes[i])>;
                J:=lideal<O|ZBasis(classes[j])>;
                assert not IsLeftIsomorphic(I,J);
            end if;
        end for;
      end if;

      if Side eq "Right" then
        for i,j in [1..#classes] do
            if i ne j then
                I:=rideal<O|ZBasis(classes[i])>;
                J:=rideal<O|ZBasis(classes[j])>;
                assert not IsRightIsomorphic(I,J);
            end if;
        end for;
      end if;
  end if;

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

