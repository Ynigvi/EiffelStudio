/*-----------------------------------------------------------
"Automatically generated by the EiffelCOM Wizard."Added Record _COAUTHINFO
	dwAuthnSvc: ULONG
			-- No description available.
	dwAuthzSvc: ULONG
			-- No description available.
	pwszServerPrincName: LPWSTR
			-- No description available.
	dwAuthnLevel: ULONG
			-- No description available.
	dwImpersonationLevel: ULONG
			-- No description available.
	pAuthIdentityData: Pointed Type
			-- No description available.
	dwCapabilities: ULONG
			-- No description available.
	
-----------------------------------------------------------*/

#ifndef __ECOM_CONTROL_LIBRARY__COAUTHINFO_S_H__
#define __ECOM_CONTROL_LIBRARY__COAUTHINFO_S_H__
#ifdef __cplusplus
extern "C" {
#endif


namespace ecom_control_library
{
struct tag_COAUTHINFO;
typedef struct ecom_control_library::tag_COAUTHINFO _COAUTHINFO;
}

namespace ecom_control_library
{
struct tag_COAUTHIDENTITY;
typedef struct ecom_control_library::tag_COAUTHIDENTITY _COAUTHIDENTITY;
}

#ifdef __cplusplus
}
#endif

#include "eif_com.h"

#include "eif_eiffel.h"

#ifdef __cplusplus
extern "C" {
#endif



namespace ecom_control_library
{
struct tag_COAUTHINFO
{	ULONG dwAuthnSvc;
	ULONG dwAuthzSvc;
	LPWSTR pwszServerPrincName;
	ULONG dwAuthnLevel;
	ULONG dwImpersonationLevel;
	ecom_control_library::_COAUTHIDENTITY * pAuthIdentityData;
	ULONG dwCapabilities;
};
}
#ifdef __cplusplus
}
#endif

#endif