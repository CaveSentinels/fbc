

#define VARIANT_NOASSIGNMENT
#include once "variant.bi"
#include once "intern.bi"

VAR_GEN_COMP( <, integer, I4 )
VAR_GEN_COMP( <, uinteger, UI4 )
VAR_GEN_COMP( <, longint, I8 )
VAR_GEN_COMP( <, ulongint, UI8 )
VAR_GEN_COMP( <, single, R4 )
VAR_GEN_COMP( <, double, R8 )

'':::::
operator < _
	( _
		byref lhs as CVariant, _
		byref rhs as CVariant _
	) as integer
	
	operator = VarCmp( @lhs.var, @rhs.var, NULL, 0 ) < VARCMP_EQ
	
end operator

'':::::
operator < _
	( _
		byref lhs as CVariant, _
		byref rhs as VARIANT _
	) as integer
	
	operator = VarCmp( @lhs.var, @rhs, NULL, 0 ) < VARCMP_EQ
	
end operator

'':::::
operator < _
	( _
		byref lhs as CVariant, _
		byval rhs as zstring ptr _
	) as integer
	
	dim as VARIANT tmp = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringByteLen( rhs, len( *rhs ) )
	
	operator = VarCmp( @lhs.var, @tmp, NULL, 0 ) < VARCMP_EQ
	
	VariantClear( @tmp )
	
end operator

'':::::
operator < _
	( _
		byref lhs as CVariant, _
		byval rhs as wstring ptr _
	) as integer
	
	dim as VARIANT tmp = any
	
	VariantInit( @tmp )
	V_VT(@tmp) = VT_BSTR
	V_BSTR(@tmp) = SysAllocStringLen( rhs, len( *rhs ) )
	
	operator = VarCmp( @lhs.var, @tmp, NULL, 0 ) < VARCMP_EQ
	
	VariantClear( @tmp )
	
end operator

