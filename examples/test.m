/* vim: set syntax=magma :*/

    AttachSpec("~/IdlClQuat/spec");

    p:=3;
    s:=2;
    B<i, j, k> := QuaternionAlgebra(RationalField(), -1, -p);
    O1 := MaximalOrder(B);
    printf "We create the order O = ZZ + %o*O1 in the algebra B=(-1,-%o/QQ), where O1 is the maximal order Z[i,j,k] of B.\n",s,p;
    O := QuaternionOrder([s*i,s*j,s*k]);
    print "We compute the weak right equivalence classes of O1...\n";
    time weak_right_classes:= WeakEquivalenceClassesWithPrescribedOrder(O : Side:="Right");
    printf "...there are %o of them.\n",#weak_right_classes;
    print "We compute the right equivalence classes of O1...\n";
    time right_classes := EquivalenceClassesWithPrescribedOrder(O : Side:="Right");
    printf "...there are %o of them.\n",#right_classes;

    #[* I : I in right_classes | IsRightInvertible(I) *];

    Nmax:=11;
    printf "For n in [1..%o] we compute the n-th extended Brandt matrix, where extended stand for the fact we consider also non-invertible classes\n",Nmax;
    for n in [1..Nmax] do
        B:=BrandtMatrix(n,O : Side:="Right");
        printf "%o:\n%o \n\n",n,B;
    end for;

    printf "We compute the coefficients of the modular forms corresponding to each i,j-entry of the Brandt matrices computed above:\n";
    mfs:=[];
    prec_max := 50;
    for i in [1..#right_classes] do
        mfsi:=[];
        for j in [1..#right_classes] do
            u:=#Units(LeftOrder(right_classes[i]));
            time mf:=[1/u] cat [ Rationals()!BrandtMatrix(n,O : Side:="Right")[i,j] : n in [1..prec_max] ];
            Append(~mfsi,mf);

            pp:=PrimesUpTo(#mf-1);
            traces:=&cat([ Sprintf("a%o=%o, ",p,mf[p+1]) : p in pp]);
            printf "Traces for i=%o,j=%o: %o\n",i,j,traces;
        end for;
        Append(~mfs,mfsi);
    end for;

/*  //the following code is useful to print the output of the above in LaTex format
    latex_print:=function(B)
    // this function helps to print the Brandt matrices into latex code. Some small modifications by hand are needed.
        B:=[Eltseq(r) : r in Rows(B) ];
        n := #B;
        S:="\\begin{pmatrix}\n";
        for i in [1..n] do
            for j in [1..n] do
                S cat:=Sprintf("%o & ",B[i,j]);
            end for;
            Prune(~S);
            Prune(~S);
            S cat:="\\\\\n";
        end for;
        Prune(~S);
        Prune(~S);
        Prune(~S);
        S cat:="\n";
        S cat:="\\end{pmatrix}";
        return S;
    end function;

    // we print the Brandts matrices in latex code
    for n in [1..20] do
        B:=BrandtMatrix(n,O : Side:="Right");
        printf "T(%o) = \n%o \n",n,latex_print(B);
    end for;

    // we print the theta series in latex code
    for i,j in [1..#full_class_set] do
        mf:=mfs[i,j];
        str:=Sprintf("\\frac{%o}{%o}+",Numerator(mf[1]),Denominator(mf[1])) cat 
            Sprintf("%oq+",mf[2] eq 1 select "" else mf[2]) cat
            &cat[ Sprintf("%oq^{%o}+",mf[i+1] eq 1 select "" else mf[i+1],i) : i in [2..11]];
        Prune(~str);
        printf "\\Theta_{%o,%o}(q) & = %o \\\\\n",i,j,str;
    end for;
*/



