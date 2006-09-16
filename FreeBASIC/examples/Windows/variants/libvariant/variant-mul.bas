

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_BOP( *, VarMul, integer, I4 )
VAR_GEN_BOP( *, VarMul, uinteger, UI4 )
VAR_GEN_BOP( *, VarMul, longint, I8 )
VAR_GEN_BOP( *, VarMul, ulongint, UI8 )
VAR_GEN_BOP( *, VarMul, single, R4 )
VAR_GEN_BOP( *, VarMul, double, R8 )

'':::::
operator * _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarMul( @lhs.var, @rhs.var, @res )
	
	return CVariant( res )
	
end operator

'':::::
operator * _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as CVariant
	
	dim as VARIANT res = any
	
	VarMul( @lhs.var, @rhs, @res )
	
	return CVariant( res )
	
end operator

