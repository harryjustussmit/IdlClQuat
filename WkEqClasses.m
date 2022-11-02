/* vim: set syntax=magma :*/

freeze;

declare attributes AlgAssVOrd : LeftWeakEquivalenceClassesWithPrescribedOrder,
                                RightWeakEquivalenceClassesWithPrescribedOrder;

hnf:=function(M)
//input: a matrix over RationalsOverNumberField()
//output: the matrix in HNF and the denominator
  M:=ChangeRing(M,Rationals());
  d:=Denominator(M);
  M:=ChangeRing(d*M,Integers());
  N:=Rank(M);
  H:=HermiteForm(M);
  H:=Matrix(Rows(H)[1..N]);
  H:=(1/d)*H;
  d:=Denominator(H);
  return <d,d*H>;
end function;

my_eq:=function(I,J)
// given lattices I and J check if I = J
    return hnf(Matrix(ZBasis(I))) eq hnf(Matrix(ZBasis(J)));
end function;

intrinsic IsWeaklyEquivalent(I::AlgAssVOrdIdl, J::AlgAssVOrdIdl : Side:="Both") -> Bool, Bool
{
  Returns two booleans by default: firstly whether or not the lattices I and J are weakly left equivalent, secondly whether or not I and J are weakly right equivalent. When "Side" is set to "Left" or "Right", only one of these is returned.
}
  require Algebra(Order(I)) cmpeq Algebra(Order(J)) : "Arguments must be ideals of orders in the same algebra";
  require Side in {"Left", "Right", "Both"} : "The optional argument \"Side\" should be \"Left\", \"Right\", or \"Both\".";

  if Side ne "Left" then
    IcolonJleft := LeftColonIdeal(I, J);
    JcolonIleft := LeftColonIdeal(J, I);
    OL:=LeftOrder(IcolonJleft);
    OR:=RightOrder(IcolonJleft);
    weaklyrightequivalent := IsCompatible(IcolonJleft, JcolonIleft) and
    IsCompatible(JcolonIleft, IcolonJleft) and
    ((IcolonJleft * JcolonIleft) eq ideal<LeftOrder(IcolonJleft) | 1>) and
    ((JcolonIleft * IcolonJleft) eq ideal<RightOrder(IcolonJleft) | 1>);   
    //my_eq((IcolonJleft * JcolonIleft),OL) and 
    //my_eq((JcolonIleft * IcolonJleft),OR);
  end if;

  if Side ne "Right" then
    IcolonJright := RightColonIdeal(I, J);
    JcolonIright := RightColonIdeal(J, I);
    weaklyleftequivalent := IsCompatible(IcolonJright, JcolonIright) and
    IsCompatible(JcolonIright, IcolonJright) and
    ((IcolonJright * JcolonIright) eq ideal<LeftOrder(IcolonJright) | 1>) and
    ((JcolonIright * IcolonJright) eq ideal<RightOrder(IcolonJright) | 1>);
  end if;

  if Side eq "Left" then
    return weaklyleftequivalent;
  end if;
  if Side eq "Right" then
    return weaklyrightequivalent;
  end if;
  if Side eq "Both" then
    return weaklyleftequivalent, weaklyrightequivalent;
  end if;
end intrinsic;

intrinsic WeakEquivalenceClassesWithPrescribedOrder(O::AlgAssVOrd : Side:="Left") -> List
{
  Given an order in an algebra, compute representatives for the weak left/right equivalence classes of lattices with left/right multiplicator ring equal to O.
}
  require Side in {"Left","Right"} : "Side should be either \"Left\" or \"Right\".";
    
  method:="IntermediateRightIdealsWithPrescribedRightOrder";
  // method:="LowIndexProcess"; //for debug
  method:="Subgroups"; //for debug
   
  "Using method : ",method; 

  // early exit
  if Side eq "Left" and assigned O`LeftWeakEquivalenceClassesWithPrescribedOrder then
    return O`LeftWeakEquivalenceClassesWithPrescribedOrder;
  end if;

  if Side eq "Right" and assigned O`RightWeakEquivalenceClassesWithPrescribedOrder then
    return O`RightWeakEquivalenceClassesWithPrescribedOrder;
  end if;

  T := MaximalOrder(O); // Only works over number fields or function fields.
  // faster if T is instead the smallest overorder T of O such that T*TraceDual(O) is invertible

  if Side eq "Left" then
    ff := RightColonIdeal(O, T);
  end if;

  if Side eq "Right" then
    ff := LeftColonIdeal(O, T);
  end if;
  classes:=[* *];
  if method eq "IntermediateRightIdealsWithPrescribedRightOrder" then
      ///////////////////////////////////////////////
      // Using IntermediateIdealsWithPrescribediRightOrder
      //TODO the Left case
      assert Side eq "Right";
      candidates:=IntermediateIdealsWithPrescribedRightOrder(O,1*T,ff);
      for I in candidates do
        if not exists{ J : J in classes | IsWeaklyEquivalent(I,J : Side:=Side)} then
            Append(~classes,I);
        end if;
      end for;
      ///////////////////////////////////////////////
  end if; 
  if method eq "LowIndexProcess" then
      ///////////////////////////////////////////////
      // LowIndexProcess seems to produce more subgroups than Subgroups, and it is slower. This is very weird.
      T_ZBasis := ZBasis(T);
      ff_ZBasis := ZBasis(ff);
      F:=FreeAbelianGroup(Degree(Algebra(O)));
      matT:=Matrix(T_ZBasis);
      matff:=Matrix(ff_ZBasis);
      rel:=[F ! Eltseq(x) : x in Rows(matff*matT^-1)];
      Q,q:=quo<F|rel>; 
      QP,f:=FPGroup(Q);
      "QP=",QP;
      subg:=LowIndexProcess(QP,<1,#QP>);

      iH:=0;
      while not IsEmpty(subg) do
        iH +:=1;
        H := ExtractGroup(subg);
        NextSubgroup(~subg);
        geninF:=[(f(QP ! x))@@q : x in Generators(H)];
        coeff:=[Eltseq(x) : x in geninF];

        if Side eq "Left" then
          I:=lideal<O| [&+[T_ZBasis[i]*x[i] : i in [1..#T_ZBasis]] : x in coeff] cat ff_ZBasis>;
          OI:=LeftOrder(I);
        end if;

        if Side eq "Right" then
          I:=rideal<O| [&+[T_ZBasis[i]*x[i] : i in [1..#T_ZBasis]] : x in coeff] cat ff_ZBasis>;
          OI:=RightOrder(I);
        end if;

        if OI eq O and not exists{J : J in classes | IsWeaklyEquivalent(I, J : Side:=Side)} then
          Append(~classes,I);
        end if;
      end while;
      ///////////////////////////////////////////////
  end if; 
  if method eq "Subgroups" then
      ///////////////////////////////////////////////
      // using Subgroups. Kept for debug purposes.
      T_ZBasis := ZBasis(T);
      ff_ZBasis := ZBasis(ff);
      F:=FreeAbelianGroup(Degree(Algebra(O)));
      matT:=Matrix(T_ZBasis);
      matff:=Matrix(ff_ZBasis);
      rel:=[F ! Eltseq(x) : x in Rows(matff*matT^-1)];
      Q,q:=quo<F|rel>; 
      "Q=",Q;
      subg:=Subgroups(Q);
      "subg=",#subg;
      for H in subg do
        gensinF:=[(Q!g)@@q : g in Generators(H`subgroup)];
        coeff:=[Eltseq(x) : x in gensinF];

        if Side eq "Left" then
          I:=lideal<O| [&+[T_ZBasis[i]*x[i] : i in [1..#T_ZBasis]] : x in coeff] cat ff_ZBasis>;
          OI:=LeftOrder(I);
        end if;

        if Side eq "Right" then
          I:=rideal<O| [&+[T_ZBasis[i]*x[i] : i in [1..#T_ZBasis]] : x in coeff] cat ff_ZBasis>;
          OI:=RightOrder(I);
        end if;

        if OI eq O and not exists{J : J in classes | IsWeaklyEquivalent(I, J : Side:=Side)} then
          Append(~classes,I);
        end if;
      end for;
      ///////////////////////////////////////////////
  end if;

  // assign attributes
  if Side eq "Left" then
    O`LeftWeakEquivalenceClassesWithPrescribedOrder:=classes;
  end if;

  if Side eq "Right" then
    O`RightWeakEquivalenceClassesWithPrescribedOrder:=classes;
  end if;

  return classes;
end intrinsic;

/* TEST

*/

