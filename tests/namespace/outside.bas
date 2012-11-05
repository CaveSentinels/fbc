#include "fbcu.bi"

namespace fbc_tests.ns.outside

'' Outside-of-namespace declarations should be allowed, as long as a prototype
'' was declared in the original namespace, and the proper namespace id is
'' used in the body's header.
'' (this is mostly a compile/link-time test)

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

namespace op
	type UDT
		as integer a
	end type

	declare sub test( )

	'' if global operators are allowed inside namespaces...
	declare operator +( a as UDT, b as UDT ) as integer

	operator -( a as UDT, b as UDT ) as integer
		operator = a.a - b.a - 2
	end operator
end namespace

'' and outside-of-namespace bodies like this are allowed...
sub op.test( )
end sub

'' then this outside-of-namespace operator body should be allowed too:
operator op.+( a as op.UDT, b as op.UDT ) as integer
	operator = a.a + b.a + 2
end operator

sub testOp cdecl( )
	dim as op.UDT a, b

	a.a = 1
	b.a = 1
	CU_ASSERT( a + b = 4 )
	CU_ASSERT( a - b = -2 )

	a.a = 3
	b.a = 7
	CU_ASSERT( a + b = 12 )
	CU_ASSERT( a - b = -6 )
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

namespace ctor
	type UDT1
		dummy1 as integer
		declare constructor( )
	end type

	constructor UDT1( )
		dummy1 = 1
	end constructor

	type UDT2
		dummy2 as integer
		declare constructor( )
	end type

	namespace nested
		type UDT1
			dummy3 as integer
			declare constructor( )
		end type

		type UDT2
			dummy4 as integer
			declare constructor( )
		end type
	end namespace

	constructor nested.UDT1( )
		dummy3 = 3
	end constructor
end namespace

constructor ctor.UDT2( )
	dummy2 = 2
end constructor

constructor ctor.nested.UDT2( )
	dummy4 = 4
end constructor

sub testCtor cdecl( )
	dim a as ctor.UDT1
	CU_ASSERT( a.dummy1 = 1 )

	dim b as ctor.UDT2
	CU_ASSERT( b.dummy2 = 2 )

	dim c as ctor.nested.UDT1
	CU_ASSERT( c.dummy3 = 3 )

	dim d as ctor.nested.UDT2
	CU_ASSERT( d.dummy4 = 4 )
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

namespace dtor
	dim shared as integer calls1, calls2, calls3, calls4

	type UDT1
		dummy1 as integer
		declare destructor( )
	end type

	destructor UDT1( )
		calls1 += 1
	end destructor

	type UDT2
		dummy2 as integer
		declare destructor( )
	end type

	namespace nested
		type UDT1
			dummy3 as integer
			declare destructor( )
		end type

		type UDT2
			dummy4 as integer
			declare destructor( )
		end type
	end namespace

	destructor nested.UDT1( )
		calls3 += 1
	end destructor
end namespace

destructor dtor.UDT2( )
	dtor.calls2 += 1
end destructor

destructor dtor.nested.UDT2( )
	dtor.calls4 += 1
end destructor

sub testDtor cdecl( )
	CU_ASSERT( dtor.calls1 = 0 )
	CU_ASSERT( dtor.calls2 = 0 )
	CU_ASSERT( dtor.calls3 = 0 )
	CU_ASSERT( dtor.calls4 = 0 )

	scope
		dim a as dtor.UDT1
		dim b as dtor.UDT2
		dim c as dtor.nested.UDT1
		dim d as dtor.nested.UDT2
	end scope

	CU_ASSERT( dtor.calls1 = 1 )
	CU_ASSERT( dtor.calls2 = 1 )
	CU_ASSERT( dtor.calls3 = 1 )
	CU_ASSERT( dtor.calls4 = 1 )
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

namespace prop
	type UDT1
		dummy1 as integer
		declare property foo( byval i as integer )
		declare property foo( ) as integer
	end type

	property UDT1.foo( byval i as integer )
		dummy1 = i
	end property

	property UDT1.foo( ) as integer
		property = dummy1
	end property

	type UDT2
		dummy2 as integer
		declare property foo( byval i as integer )
		declare property foo( ) as integer
	end type

	namespace nested
		type UDT1
			dummy3 as integer
			declare property foo( byval i as integer )
			declare property foo( ) as integer
		end type

		type UDT2
			dummy4 as integer
			declare property foo( byval i as integer )
			declare property foo( ) as integer
		end type
	end namespace

	property nested.UDT1.foo( byval i as integer )
		dummy3 = i
	end property

	property nested.UDT1.foo( ) as integer
		property = dummy3
	end property
end namespace

property prop.UDT2.foo( byval i as integer )
	dummy2 = i
end property

property prop.UDT2.foo( ) as integer
	property = dummy2
end property

property prop.nested.UDT2.foo( byval i as integer )
	dummy4 = i
end property

property prop.nested.UDT2.foo( ) as integer
	property = dummy4
end property

sub testProp cdecl( )
	dim a as prop.UDT1
	a.foo = 1
	CU_ASSERT( a.foo = 1 )

	dim b as prop.UDT2
	b.foo = 2
	CU_ASSERT( b.foo = 2 )

	dim c as prop.nested.UDT1
	c.foo = 3
	CU_ASSERT( c.foo = 3 )

	dim d as prop.nested.UDT2
	d.foo = 4
	CU_ASSERT( d.foo = 4 )
end sub

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

private sub modctor( ) constructor
	fbcu.add_suite( "tests/namespace/outside" )
	fbcu.add_test( "operator", @testOp )
	fbcu.add_test( "constructor", @testCtor )
	fbcu.add_test( "destructor", @testDtor )
	fbcu.add_test( "property", @testProp )
end sub

end namespace
