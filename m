Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEDBD48981
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 11:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA97842DD9;
	Fri, 16 Jan 2026 12:40:04 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D461C4279E
 for <dev@dpdk.org>; Fri, 16 Jan 2026 12:40:02 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E43002061A;
 Fri, 16 Jan 2026 12:40:00 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v7] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Date: Fri, 16 Jan 2026 12:39:57 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F6566B@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260114215648.47820-1-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v7] eal: RTE_PTR_ADD/SUB char* for compiler optimizations
Thread-Index: AdyFoN896op8MtOKTeeJQPbNYUmjfgBOlNuA
References: <20260114160750.12945-1-scott.k.mitch1@gmail.com>
 <20260114215648.47820-1-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>,
	<dev@dpdk.org>
Cc: <stephen@networkplumber.org>,
	<bruce.richardson@intel.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

> From: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> Modify RTE_PTR_ADD and RTE_PTR_SUB to use char* pointer arithmetic
> on Clang instead of uintptr_t casts. Benefits of this approach:
> - API compatibility: works for both integer and pointer inputs
> - Retains simple macros: no pragmas, no _Generic
> - Enables Clang optimizations: Clang can now unroll and vectorize
>   pointer loops. GCC uses uintptr_t to avoid false positive warnings.
>=20
> Example use case which benefits is __rte_raw_cksum. Performance
> results from cksum_perf_autotest on Intel Xeon (Cascade Lake,
> AVX-512) built with Clang 18.1 (TSC cycles/byte):
>   Block size    Before    After    Improvement
>          100      0.40     0.24        ~40%
>         1500      0.50     0.06        ~8x
>         9000      0.49     0.06        ~8x
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
>=20
> ---
> v7:
> - Fix tests: use TEST_BUFFER_SIZE macro for buffer allocation
> - Fix tests: ADD then SUB same amount to avoid out-of-bounds pointer
> arithmetic
> - All RTE_PTR_SUB tests now verify round-trip (ADD+SUB returns to
> original)
>=20
> v6:
> - Make char* optimization Clang-only to avoid GCC false positive
> warnings
> - Improve tests: use named constants instead of magic numbers
> - Improve tests: use void* casts on expected values instead of
> uintptr_t on results
>=20
> v5:
> - Initial implementation with char* arithmetic for all compilers
>=20
> v4:
> - Used _Generic for type-based dispatch with char* casts
> - Had warnings on both Clang and GCC due to _Generic type-checking all
> branches
> ---
>  app/test/meson.build         |   1 +
>  app/test/test_ptr_add_sub.c  | 197 =
+++++++++++++++++++++++++++++++++++
>  lib/eal/include/rte_common.h |  14 ++-
>  3 files changed, 208 insertions(+), 4 deletions(-)
>  create mode 100644 app/test/test_ptr_add_sub.c
>=20
> diff --git a/app/test/meson.build b/app/test/meson.build
> index efec42a6bf..80a19d65ba 100644
> --- a/app/test/meson.build
> +++ b/app/test/meson.build
> @@ -152,6 +152,7 @@ source_file_deps =3D {
>      'test_power_intel_uncore.c': ['power', 'power_intel_uncore'],
>      'test_power_kvm_vm.c': ['power', 'power_kvm_vm'],
>      'test_prefetch.c': [],
> +    'test_ptr_add_sub.c': [],
>      'test_ptr_compress.c': ['ptr_compress'],
>      'test_rand_perf.c': [],
>      'test_rawdev.c': ['rawdev', 'bus_vdev', 'raw_skeleton'],
> diff --git a/app/test/test_ptr_add_sub.c b/app/test/test_ptr_add_sub.c
> new file mode 100644
> index 0000000000..2956eabeb3
> --- /dev/null
> +++ b/app/test/test_ptr_add_sub.c
> @@ -0,0 +1,197 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright(c) 2026 Apple Inc.
> + */
> +
> +#include "test.h"
> +#include <stdint.h>
> +#include <stdbool.h>
> +
> +#include <rte_common.h>
> +
> +/* Test constants for large integer types (16-bit and wider) */
> +#define TEST_INITVAL_LARGE 0x1000
> +#define TEST_INCREMENT_LARGE 100
> +#define TEST_RETVAL_LARGE ((void *)0x1064)
> +#define TEST_SUBVAL_LARGE ((void *)(TEST_INITVAL_LARGE -
> TEST_INCREMENT_LARGE))
> +
> +/* Test constants for 8-bit types */
> +#define TEST_INITVAL_SMALL 100
> +#define TEST_INCREMENT_SMALL 50
> +#define TEST_RETVAL_SMALL ((void *)150)
> +#define TEST_SUBVAL_SMALL ((void *)50)
> +
> +/* Test constants for bool (1-bit) */
> +#define TEST_INITVAL_BOOL 1
> +#define TEST_INCREMENT_BOOL 99
> +#define TEST_RETVAL_BOOL ((void *)100)

TEST_RETVAL_BOOL is incorrect if typeof(ptr) is bool.
(int)(bool)(true+99) =3D=3D 1

Now that _Generic is not used anymore, I suggest you remove test cases =
for other types than pointers.
At your preference, you may also keep pointer compatible types, i.e. 32 =
bit integers when building for 32-bit architecture and 64 bit integers =
when building for 64-bit architecture.

> +
> +/* Buffer size for pointer tests */
> +#define TEST_BUFFER_SIZE (TEST_INCREMENT_LARGE + TEST_INCREMENT_SMALL
> + 256)
> +
> +/* Test all C11 standard integer types */
> +static int
> +test_ptr_add_sub_integer_types(void)
> +{
> +	unsigned long long ull =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(ull, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for unsigned long long");
> +	TEST_ASSERT_EQUAL(RTE_PTR_SUB(ull, TEST_INCREMENT_LARGE),
> TEST_SUBVAL_LARGE,
> +		"RTE_PTR_SUB failed for unsigned long long");
> +
> +	long long ll =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(ll, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for long long");
> +
> +	unsigned long ul =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(ul, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for unsigned long");
> +
> +	long l =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(l, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for long");
> +
> +	unsigned int ui =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(ui, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for unsigned int");
> +
> +	int i =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(i, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for int");
> +
> +	unsigned short us =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(us, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for unsigned short");
> +
> +	short s =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(s, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for short");
> +
> +	unsigned char uc =3D TEST_INITVAL_SMALL;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(uc, TEST_INCREMENT_SMALL),
> TEST_RETVAL_SMALL,
> +		"RTE_PTR_ADD failed for unsigned char");
> +
> +	signed char sc =3D TEST_INITVAL_SMALL;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(sc, TEST_INCREMENT_SMALL),
> TEST_RETVAL_SMALL,
> +		"RTE_PTR_ADD failed for signed char");
> +
> +	char c =3D TEST_INITVAL_SMALL;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(c, TEST_INCREMENT_SMALL),
> TEST_RETVAL_SMALL,
> +		"RTE_PTR_ADD failed for char");
> +
> +	_Bool b =3D TEST_INITVAL_BOOL;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(b, TEST_INCREMENT_BOOL),
> TEST_RETVAL_BOOL,
> +		"RTE_PTR_ADD failed for _Bool");
> +
> +	bool b2 =3D TEST_INITVAL_BOOL;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(b2, TEST_INCREMENT_BOOL),
> TEST_RETVAL_BOOL,
> +		"RTE_PTR_ADD failed for bool");
> +
> +	return 0;
> +}
> +
> +/* Test pointer types including const correctness */
> +static int
> +test_ptr_add_sub_pointer_types(void)
> +{
> +	char buffer[TEST_BUFFER_SIZE];
> +	void *result;
> +
> +	/* Test void* and const void* */
> +	void *vp =3D buffer;
> +	result =3D RTE_PTR_ADD(vp, TEST_INCREMENT_LARGE);
> +	result =3D RTE_PTR_SUB(result, TEST_INCREMENT_LARGE);
> +	TEST_ASSERT_EQUAL(result, vp, "RTE_PTR_ADD/SUB failed for
> void*");
> +
> +	const void *cvp =3D buffer;
> +	result =3D RTE_PTR_ADD(cvp, TEST_INCREMENT_SMALL);
> +	result =3D RTE_PTR_SUB(result, TEST_INCREMENT_SMALL);
> +	TEST_ASSERT_EQUAL(result, (const void *)cvp,
> +		"RTE_PTR_ADD/SUB failed for const void*");
> +
> +	/* Test char* and const char* */
> +	char *cp =3D buffer;
> +	result =3D RTE_PTR_ADD(cp, TEST_INCREMENT_LARGE);
> +	result =3D RTE_PTR_SUB(result, TEST_INCREMENT_LARGE);
> +	TEST_ASSERT_EQUAL(result, (void *)cp, "RTE_PTR_ADD/SUB failed for
> char*");
> +
> +	const char *ccp =3D buffer;
> +	result =3D RTE_PTR_ADD(ccp, TEST_INCREMENT_SMALL);
> +	result =3D RTE_PTR_SUB(result, TEST_INCREMENT_SMALL);
> +	TEST_ASSERT_EQUAL(result, (const void *)ccp,
> +		"RTE_PTR_ADD/SUB failed for const char*");
> +
> +	/* Test uint32_t* and const uint32_t* */
> +	uint32_t *u32p =3D (uint32_t *)buffer;
> +	result =3D RTE_PTR_ADD(u32p, TEST_INCREMENT_LARGE);
> +	result =3D RTE_PTR_SUB(result, TEST_INCREMENT_LARGE);
> +	TEST_ASSERT_EQUAL(result, (void *)u32p,
> +		"RTE_PTR_ADD/SUB failed for uint32_t*");
> +
> +	const uint32_t *cu32p =3D (const uint32_t *)buffer;
> +	result =3D RTE_PTR_ADD(cu32p, TEST_INCREMENT_SMALL);
> +	result =3D RTE_PTR_SUB(result, TEST_INCREMENT_SMALL);
> +	TEST_ASSERT_EQUAL(result, (const void *)cu32p,
> +		"RTE_PTR_ADD/SUB failed for const uint32_t*");
> +
> +	/* Verify assigning to const pointer works (adding const is safe)
> */
> +	const void *result_const =3D RTE_PTR_ADD(cvp,
> TEST_INCREMENT_LARGE);
> +	result_const =3D RTE_PTR_SUB(result_const, TEST_INCREMENT_LARGE);
> +	TEST_ASSERT_EQUAL(result_const, cvp,
> +		"RTE_PTR_ADD/SUB failed when assigning to const void*");
> +
> +	return 0;
> +}
> +
> +/* Test that typedefs resolve to native types correctly */
> +static int
> +test_ptr_add_sub_typedefs(void)
> +{
> +	uint64_t u64 =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(u64, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for uint64_t");
> +
> +	uint32_t u32 =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(u32, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for uint32_t");
> +
> +	uint16_t u16 =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(u16, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for uint16_t");
> +
> +	uint8_t u8 =3D TEST_INITVAL_SMALL;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(u8, TEST_INCREMENT_SMALL),
> TEST_RETVAL_SMALL,
> +		"RTE_PTR_ADD failed for uint8_t");
> +
> +	uintptr_t uptr =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(uptr, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for uintptr_t");
> +
> +	size_t sz =3D TEST_INITVAL_LARGE;
> +	TEST_ASSERT_EQUAL(RTE_PTR_ADD(sz, TEST_INCREMENT_LARGE),
> TEST_RETVAL_LARGE,
> +		"RTE_PTR_ADD failed for size_t");
> +
> +	return 0;
> +}
> +
> +/* Main test function that runs all subtests */
> +static int
> +test_ptr_add_sub(void)
> +{
> +	int ret;
> +
> +	ret =3D test_ptr_add_sub_integer_types();
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	ret =3D test_ptr_add_sub_pointer_types();
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	ret =3D test_ptr_add_sub_typedefs();
> +	if (ret !=3D 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +REGISTER_FAST_TEST(ptr_add_sub_autotest, true, true,
> test_ptr_add_sub);
> diff --git a/lib/eal/include/rte_common.h
> b/lib/eal/include/rte_common.h
> index 9e7d84f929..b525110b06 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -549,14 +549,20 @@ static void
> __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
>  /*********** Macros for pointer arithmetic ********/
>=20
>  /**
> - * add a byte-value offset to a pointer
> + * add and subtract a byte-value offset from a pointer
>   */
> -#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
> -
> +#ifdef RTE_CC_CLANG
>  /**
> - * subtract a byte-value offset from a pointer
> + * Clang doesn't optimize through uintptr_t, (char*) enables
> + * optimizations and doesn't generate warnings. GCC does optimize
> + * through uintptr_t but throws warnings (e.g. array-bounds) when =
cast
> to char*.
>   */
> +#define RTE_PTR_ADD(ptr, x) ((void *)((char *)(uintptr_t)(ptr) + =
(x)))
> +#define RTE_PTR_SUB(ptr, x) ((void *)((char *)(uintptr_t)(ptr) - =
(x)))
> +#else
> +#define RTE_PTR_ADD(ptr, x) ((void *)((uintptr_t)(ptr) + (x)))
>  #define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
> +#endif

Please keep descriptions for RTE_PTR_ADD and RTE_PTR_SUB separate, so =
they show up for both macros in the API documentation:
https://doc.dpdk.org/api/rte__common_8h.html#a96c6294ef6a307980f78899fe8a=
5813e

>=20
>  /**
>   * get the difference between two pointer values, i.e. how far apart
> --
> 2.39.5 (Apple Git-154)

