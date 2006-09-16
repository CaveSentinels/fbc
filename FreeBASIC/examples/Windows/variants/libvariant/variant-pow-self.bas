

#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_SELFOP( ^=, VarPow, integer, I4 )
VAR_GEN_SELFOP( ^=, VarPow, uinteger, UI4 )
VAR_GEN_SELFOP( ^=, VarPow, longint, I8 )
VAR_GEN_SELFOP( ^=, VarPow, ulongint, UI8 )
VAR_GEN_SELFOP( ^=, VarPow, single, R4 )
VAR_GEN_SELFOP( ^=, VarPow, double, R8 )

operator CVariant.^= _
	( _
		byref rhs as CVariant _
	)
		
	dim as VARIANT res = any
	
	VarPow( @this.var, @rhs.var, @res )
		
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
		
end operator

operator CVariant.^= _
	( _
		byref rhs as VARIANT _
	)
		
	dim as VARIANT res = any
	
	VarPow( @this.var, @rhs, @res )
		
	VariantClear( @this.var )
	VariantCopy( @this.var, @res )
		
end operator
