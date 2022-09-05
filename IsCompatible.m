/* vim: set syntax=magma :*/

freeze;


intrinsic IsCompatible(I::AlgQuatOrdIdl, J::AlgQuatOrdIdl) -> Bool
{
    Given two lattices I and J, returns whether or not they are compatible, i.e. if O_R(I) = O_L(J).
}
  return RightOrder(I) eq LeftOrder(J);
end intrinsic;

/* TEST
 
*/

