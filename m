Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0EFFF8868
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 10:04:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74D6E40395;
	Tue, 28 Apr 2026 12:04:16 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0ADD0402A3
 for <dev@dpdk.org>; Tue, 28 Apr 2026 12:04:16 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BC63720778;
 Tue, 28 Apr 2026 12:04:15 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v24] eal: RTE_PTR_ADD/SUB API improvements
Date: Tue, 28 Apr 2026 12:04:11 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65826@smartserver.smartshare.dk>
In-Reply-To: <20260207014517.58671-1-scott.k.mitch1@gmail.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v24] eal: RTE_PTR_ADD/SUB API improvements
Thread-Index: AdyX03LVtmXqYmyBRDGArZfEXssSVw/H1Www
References: <20260206042814.24970-1-scott.k.mitch1@gmail.com>
 <20260207014517.58671-1-scott.k.mitch1@gmail.com>
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

> From: scott.k.mitch1@gmail.com [mailto:scott.k.mitch1@gmail.com]
> Sent: Saturday, 7 February 2026 02.45
>=20
> RTE_PTR_ADD and RTE_PTR_SUB APIs have a few limitations:
> 1. ptr cast to uintptr_t drops pointer provenance and
> prevents compiler optimizations
> 2. return cast discards qualifiers (const, volatile)
> which may hide correctness/concurrency issues.
> 3. Accepts both "pointers" and "integers as pointers" which
> overloads the use case and constrains the implementation
> to address other challenges.
>=20
> This patch removes support for integer types which allows
> addressing each of the challenges above. Examples:
> 1. Clang is able to optimize and improve __rte_raw_cksum
> (which uses RTE_PTR_ADD) by ~40% (100 bytes) to ~8x (1.5k bytes)
> TSC cycles/byte.
> 2. Refactoring discovered cases that dropped qualifiers (volatile)
> that the new API exposes.
>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>

IMHO, preserving const/volatile qualifiers with RTE_PTR_ADD/SUB etc. is =
a great improvement.

You have added NULL pointer checks to a lot of code using these macros.

If these NULL pointer checks are required, the requirement is probably =
an API break.
In this case, this patch should be postponed to DPDK 26.11 (the next =
API/ABI breaking release), and the requirement coming in DPDK 26.11 =
should be noted in the doc/guides/rel_notes/deprecation.rst file for the =
DPDK 26.07 release.

If these NULL pointer checks are not required, they are unrelated to =
this patch, and should be removed. (They can be submitted as independent =
patches.)
In this case, we should be able to proceed with this patch for DPDK =
26.07.

-Morten

> ---
> Depends-on: patch-160679 ("eal: add __rte_may_alias and __rte_aligned
> to unaligned typedefs")
>=20
> v24:
> - test_common.c move defines outside function scope
>=20
> v23:
> - Fix RTE_PTR_ALIGN_CEIL and RTE_PTR_ALIGN_FLOOR compiler errors
> on some platforms by pop pragma then return temp
> - Fix checkpatch style issues in test_common.c
>=20
> v22:
> - msvc fix RTE_PTR_ALIGN_FLOOR compile issue
>=20
> v21:
> - Fix PTR_ALIGN to preserve return type correctly, avoid void* cast
> because alignment is known
> - Remove unecessary PTR_DIFF usage with PTR_ALIGN due to prior fix
> - Remove RTE_INT_PTR and PLT_PTR_UNQUAL
> - Consistent !=3D NULL usage, add __rte_assume
> - Add edge case tests to test_common.c
>=20
> v20:
> - Fix test_common.c test_ptr_add_sub_align failure due to alignas
>=20
> v19:
> - Remove first patch from series (already merged)
> - Fix test_common.c test_ptr_add_sub_align failure, enhance test
>=20
> v18:
> - Removed RTE_INT_PTR* macros
> - Explicit NULL compare in asserts
> - Consolidated test_ptr_add_sub.c into test_common.c
>=20
> v17:
> - Improved release notes to explicitly list macro names for
> search/indexing
> - eal_common_fbarray.c RTE_ASSERT to runtime NULL check
>=20
> v16:
> - Fixed test_common.c: parenthesize PTR_DIFF in RTE_INT_PTR tests
>=20
> v15:
> - Fixed __rte_alloc_size, spilt into 2 patch series
> - Replaced RTE_INT_PTR_ADD/SUB with simpler RTE_INT_PTR(val) macro
> users do int arithmetic directly: RTE_INT_PTR(addr + offset)
>=20
> v14:
> - fixed cpp compiler error, avoiding array pointer decay
> which is implicitly done in cpp (but not c)
> - fixed MALLOC_ELEM_TRAILER const preservation compile error
>=20
> v13:
> - Added release notes documenting API changes
> - Fixed alignment in test file: use alignas(uint32_t) for buffer
> - Fixed NULL pointer handling in cdx_vfio.c: check base_va before
> RTE_PTR_ADD
> - Added GCC array-bounds diagnostic suppression in
> malloc_elem_from_data()
> - Added bug tracker reference for volatile cast issue in idxd_pci.c
> - Improved __rte_auto_type documentation: added C++11 and C23 support
> - Moved doxygen rationale for void* return type to @return blocks
> - Fixed MALLOC_ELEM_TRAILER to use RTE_PTR_UNQUAL for write operations
>=20
> v12:
> - void* return type to avoid optimizations assuming
> aligned access which isn't generally safe/true.
>=20
> v11:
> - Split API into PTR and INT_PTR variants, update all usage
> of PTR API for new APIs.
>=20
> v10:
> - Use unit_test_suite_runner for easier subtest failure identification
>=20
> v9:
> - Fix include order: system includes, then DPDK includes, then
> application includes
> - Use NOHUGE_OK and ASAN_OK constants in REGISTER_FAST_TEST (instead =
of
> true, true)
>=20
> v8:
> - Remove tests for types < 32-bit (bool, char, short, uint8_t,
> uint16_t)
> - Merge test_ptr_add_sub_typedefs() into
> test_ptr_add_sub_integer_types()
> - Separate RTE_PTR_ADD and RTE_PTR_SUB documentation
> - Move Clang/GCC implementation note from Doxygen to regular comment
> - Tests verify both intermediate ADD result and SUB round-trip
> - Use uintptr_t cast consistently for all integer-to-pointer
> conversions
> - Make TEST_RETVAL calculated from TEST_INITVAL + TEST_INCREMENT
>=20
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
>=20
>  app/test-pmd/cmdline_flow.c                 |   4 +-
>  app/test/test_common.c                      | 504 =
+++++++++++++++++++-
>  doc/guides/rel_notes/release_26_03.rst      |  13 +
>  drivers/bus/cdx/cdx_vfio.c                  |  13 +-
>  drivers/bus/pci/linux/pci.c                 |   6 +-
>  drivers/bus/vmbus/linux/vmbus_uio.c         |   6 +-
>  drivers/common/cnxk/roc_cpt_debug.c         |  12 +-
>  drivers/common/cnxk/roc_ml.c                |   4 +-
>  drivers/common/cnxk/roc_nix_bpf.c           |   2 +-
>  drivers/common/cnxk/roc_nix_inl.h           |   4 +-
>  drivers/common/cnxk/roc_nix_inl_dp.h        |   8 +-
>  drivers/common/mlx5/mlx5_common_mr.c        |   2 +-
>  drivers/dma/idxd/idxd_pci.c                 |  11 +-
>  drivers/dma/odm/odm_dmadev.c                |   4 +-
>  drivers/event/cnxk/cn10k_worker.c           |  32 +-
>  drivers/event/cnxk/cn20k_worker.c           |  32 +-
>  drivers/mempool/bucket/rte_mempool_bucket.c |   7 +-
>  drivers/net/cxgbe/sge.c                     |   4 +-
>  drivers/net/ena/ena_ethdev.c                |   9 +-
>  drivers/net/mlx4/mlx4_txq.c                 |   3 +-
>  lib/eal/common/eal_common_fbarray.c         |   3 +-
>  lib/eal/common/eal_common_memory.c          |  32 +-
>  lib/eal/common/eal_common_options.c         |   3 +-
>  lib/eal/common/malloc_elem.h                |  34 +-
>  lib/eal/freebsd/eal_memory.c                |   4 +
>  lib/eal/include/rte_common.h                | 179 ++++++-
>  lib/eal/linux/eal_memalloc.c                |   6 +
>  lib/eal/linux/eal_memory.c                  |   7 +
>  lib/eal/windows/eal_memalloc.c              |   6 +
>  lib/graph/rte_graph.h                       |   4 +-
>  lib/latencystats/rte_latencystats.c         |   3 +
>  lib/mbuf/rte_mbuf.c                         |   2 +
>  lib/mbuf/rte_mbuf.h                         |   4 +
>  lib/member/rte_xxh64_avx512.h               |   6 +-
>  lib/mempool/rte_mempool.h                   |   6 +
>  lib/pdcp/pdcp_entity.h                      |   8 +-
>  lib/vhost/vhost_user.c                      |  13 +-
>  37 files changed, 861 insertions(+), 139 deletions(-)
>=20



> diff --git a/doc/guides/rel_notes/release_26_03.rst
> b/doc/guides/rel_notes/release_26_03.rst
> index 031eaa657e..dda0cec591 100644
> --- a/doc/guides/rel_notes/release_26_03.rst
> +++ b/doc/guides/rel_notes/release_26_03.rst
> @@ -116,6 +116,19 @@ API Changes
>    * cfgfile: name must be less than CFG_NAME_LEN
>      and value must be less than CFG_VALUE_LEN.
>=20
> +* **eal: Improved pointer arithmetic macros.**
> +
> +  * ``RTE_PTR_ADD``, ``RTE_PTR_SUB``, ``RTE_PTR_ALIGN``,
> ``RTE_PTR_ALIGN_CEIL``,
> +    and ``RTE_PTR_ALIGN_FLOOR`` now preserve const/volatile =
qualifiers
> and use
> +    pointer arithmetic instead of integer casts to enable compiler
> optimizations. These
> +    macros do not nest infinitely and may require intermediate
> variables.
> +  * Passing NULL to ``RTE_PTR_ADD``, ``RTE_PTR_SUB``,
> ``RTE_PTR_ALIGN``,
> +    ``RTE_PTR_ALIGN_CEIL``, or ``RTE_PTR_ALIGN_FLOOR`` clarified as
> undefined behavior.
> +  * Existing code passing integer types as pointer to ``RTE_PTR_ADD``
> or ``RTE_PTR_SUB``
> +    should use native operators (e.g. + -).
> +  * Existing code passing integer types as pointer to
> ``RTE_PTR_ALIGN``,
> +    ``RTE_PTR_ALIGN_CEIL`` or ``RTE_PTR_ALIGN_FLOOR`` should use
> +    ``RTE_ALIGN``, ``RTE_ALIGN_CEIL`` or ``RTE_ALIGN_FLOOR``.



> diff --git a/lib/eal/include/rte_common.h
> b/lib/eal/include/rte_common.h
> index 573bf4f2ce..86b0a75bb3 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -103,6 +103,34 @@ extern "C" {
>  		__GNUC_PATCHLEVEL__)
>  #endif
>=20
> +/*
> + * Type inference for use in macros.
> + */
> +#if (defined(__cplusplus) && __cplusplus >=3D 201103L) || \
> +		(defined(__STDC_VERSION__) && __STDC_VERSION__ >=3D 202311L)
> +#define __rte_auto_type auto
> +#elif defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
> +#define __rte_auto_type __auto_type
> +#endif
> +
> +/*
> + * Helper macro for array decay in pointer arithmetic macros.
> + * Example: char arr[10]; RTE_PTR_ADD(arr, 5) needs arr to decay to
> char*.
> + *
> + * GCC/Clang in C mode need "+ 0" to force arrays to decay to
> pointers.
> + * Not needed for C++ (automatic decay) or MSVC (ternary checks both
> branches).
> + *
> + * Note: This must be an object-like macro (not function-like) =
because
> it gets
> + * used with nested macro expansion (e.g.,
> RTE_PTR_ALIGN_FLOOR(RTE_PTR_ADD(...))).
> + * A function-like macro would wrap the argument in parentheses,
> causing _Pragma
> + * directives from nested statement expressions to appear in invalid
> contexts.
> + */
> +#if !defined(RTE_TOOLCHAIN_MSVC) && !defined(__cplusplus)
> +#define __rte_ptr_arith_add_zero + 0
> +#else
> +#define __rte_ptr_arith_add_zero
> +#endif
> +
>  /**
>   * Force type alignment
>   *
> @@ -210,6 +238,16 @@ typedef uint16_t unaligned_uint16_t;
>  #define __rte_diagnostic_ignored_wcast_qual
>  #endif
>=20
> +/**
> + * Macro to disable compiler warnings about invalid array bounds
> access.
> + */
> +#if !defined(RTE_TOOLCHAIN_MSVC)
> +#define __rte_diagnostic_ignored_array_bounds \
> +	_Pragma("GCC diagnostic ignored \"-Warray-bounds\"")
> +#else
> +#define __rte_diagnostic_ignored_array_bounds
> +#endif
> +
>  /**
>   * Mark a function or variable to a weak reference.
>   */
> @@ -549,14 +587,72 @@ static void
> __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
>  /*********** Macros for pointer arithmetic ********/
>=20
>  /**
> - * add a byte-value offset to a pointer
> + * Add a byte-value offset to a pointer.
> + *
> + * @param ptr
> + *   The pointer (must be non-NULL)
> + * @param x
> + *   Byte offset to add
> + * @return
> + *   void* (or const void* / volatile void* / const volatile void*
> preserving qualifiers).
> + *   Returning void* prevents the compiler from making alignment
> assumptions based
> + *   on the pointer type, which is important when doing byte-offset
> arithmetic that
> + *   may cross struct boundaries or result in unaligned pointers.
>   */
> -#define RTE_PTR_ADD(ptr, x) ((void*)((uintptr_t)(ptr) + (x)))
> +#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
> +#define RTE_PTR_ADD(ptr, x) \
> +(__extension__ ({ \
> +	/* (1) Force array decay and ensure single evaluation */ \
> +	__rte_auto_type __rte_ptr_add =3D (ptr) __rte_ptr_arith_add_zero; \
> +	__rte_diagnostic_push \
> +	__rte_diagnostic_ignored_wcast_qual \
> +	/* (2) Calculate result, preserving const/volatile via ternary */
> \
> +	__rte_auto_type __rte_ptr_add_res =3D \
> +		(1 ? (void *)((char *)__rte_ptr_add + (x)) :
> __rte_ptr_add); \
> +	__rte_diagnostic_pop \
> +	/* (3) Return the result */ \
> +	__rte_ptr_add_res; \
> +}))
> +#else
> +/* MSVC fallback (ternary preserves const, no statement exprs) */
> +#define RTE_PTR_ADD(ptr, x) \
> +	(1 ? (void *)((char *)((ptr) __rte_ptr_arith_add_zero) + (x)) : \
> +		((ptr) __rte_ptr_arith_add_zero))
> +#endif
>=20
>  /**
> - * subtract a byte-value offset from a pointer
> + * Subtract a byte-value offset from a pointer.
> + *
> + * @param ptr
> + *   The pointer (must be non-NULL)
> + * @param x
> + *   Byte offset to subtract
> + * @return
> + *   void* (or const void* / volatile void* / const volatile void*
> preserving qualifiers).
> + *   Returning void* prevents the compiler from making alignment
> assumptions based
> + *   on the pointer type, which is important when doing byte-offset
> arithmetic that
> + *   may cross struct boundaries or result in unaligned pointers.
>   */
> -#define RTE_PTR_SUB(ptr, x) ((void *)((uintptr_t)(ptr) - (x)))
> +#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
> +#define RTE_PTR_SUB(ptr, x) \
> +(__extension__ ({ \
> +	/* (1) Force array decay and ensure single evaluation */ \
> +	__rte_auto_type __rte_ptr_sub =3D (ptr) __rte_ptr_arith_add_zero; \
> +	__rte_diagnostic_push \
> +	__rte_diagnostic_ignored_wcast_qual \
> +	/* (2) Calculate result, preserving const/volatile via ternary */
> \
> +	__rte_auto_type __rte_ptr_sub_res =3D \
> +		(1 ? (void *)((char *)__rte_ptr_sub - (x)) :
> __rte_ptr_sub); \
> +	__rte_diagnostic_pop \
> +	/* (3) Return the result */ \
> +	__rte_ptr_sub_res; \
> +}))
> +#else
> +/* MSVC fallback (ternary preserves const, no statement exprs) */
> +#define RTE_PTR_SUB(ptr, x) \
> +	(1 ? (void *)((char *)((ptr) __rte_ptr_arith_add_zero) - (x)) : \
> +		((ptr) __rte_ptr_arith_add_zero))
> +#endif
>=20
>  /**
>   * get the difference between two pointer values, i.e. how far apart
> @@ -602,13 +698,40 @@ static void
> __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
>=20
>=20
>  /**
> - * Macro to align a pointer to a given power-of-two. The resultant
> - * pointer will be a pointer of the same type as the first parameter,
> and
> - * point to an address no higher than the first parameter. Second
> parameter
> - * must be a power-of-two value.
> + * Macro to align a pointer to a given power-of-two.
> + *
> + * Aligns the pointer down to the specified alignment boundary.
> + *
> + * @param ptr
> + *   The pointer (must be non-NULL)
> + * @param align
> + *   Alignment boundary (must be a power-of-two value)
> + * @return
> + *   Aligned pointer of the same type as ptr, pointing to an address
> no higher than ptr.
> + *   Returns pointer of same type as input, preserving const/volatile
> qualifiers.
> + *   Since alignment operations guarantee proper alignment, the =
return
> type matches
> + *   the input type.
>   */
> +#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
>  #define RTE_PTR_ALIGN_FLOOR(ptr, align) \
> -	((typeof(ptr))RTE_ALIGN_FLOOR((uintptr_t)(ptr), align))
> +(__extension__ ({ \
> +	/* (1) Force array decay and ensure single evaluation */ \
> +	__rte_auto_type __rte_ptr_floor =3D (ptr) __rte_ptr_arith_add_zero;
> \
> +	/* (2) Compute misalignment as integer, but adjust pointer using
> pointer arithmetic */ \
> +	size_t __rte_ptr_floor_misalign =3D (uintptr_t)__rte_ptr_floor &
> ((align) - 1); \
> +	__rte_diagnostic_push \
> +	__rte_diagnostic_ignored_wcast_qual \
> +	/* (3) Return the aligned result, cast to preserve input type. We
> avoid RTE_PTR_SUB */ \
> +	/*  to skip the void* cast which may defeat compiler alignment
> optimizations. */ \
> +	__rte_auto_type __rte_ptr_floor_res =3D \
> +		(typeof(__rte_ptr_floor))((char *)__rte_ptr_floor -
> __rte_ptr_floor_misalign); \
> +	__rte_diagnostic_pop \
> +	__rte_ptr_floor_res; \
> +}))
> +#else
> +#define RTE_PTR_ALIGN_FLOOR(ptr, align) \
> +	((typeof(ptr))RTE_ALIGN_FLOOR((uintptr_t) ((ptr)
> __rte_ptr_arith_add_zero), align))
> +#endif
>=20
>  /**
>   * Macro to align a value to a given power-of-two. The resultant =
value
> @@ -620,13 +743,43 @@ static void
> __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
>  	(typeof(val))((val) & (~((typeof(val))((align) - 1))))
>=20
>  /**
> - * Macro to align a pointer to a given power-of-two. The resultant
> - * pointer will be a pointer of the same type as the first parameter,
> and
> - * point to an address no lower than the first parameter. Second
> parameter
> - * must be a power-of-two value.
> + * Macro to align a pointer to a given power-of-two.
> + *
> + * Aligns the pointer up to the specified alignment boundary.
> + *
> + * @param ptr
> + *   The pointer (must be non-NULL)
> + * @param align
> + *   Alignment boundary (must be a power-of-two value)
> + * @return
> + *   Aligned pointer of the same type as ptr, pointing to an address
> no lower than ptr.
> + *   Returns pointer of same type as input, preserving const/volatile
> qualifiers.
> + *   Since alignment operations guarantee proper alignment, the =
return
> type matches
> + *   the input type.
>   */
> +#if defined(RTE_CC_GCC) || defined(RTE_CC_CLANG)
> +#define RTE_PTR_ALIGN_CEIL(ptr, align) \
> +(__extension__ ({ \
> +	/* (1) Force array decay and ensure single evaluation */ \
> +	__rte_auto_type __rte_ptr_ceil =3D (ptr) __rte_ptr_arith_add_zero;
> \
> +	/* (2) Compute alignment as integer, but adjust pointer using
> pointer arithmetic */ \
> +	size_t __rte_ptr_ceil_align_m1 =3D (align) - 1; \
> +	uintptr_t __rte_ptr_ceil_aligned =3D ((uintptr_t)__rte_ptr_ceil +
> __rte_ptr_ceil_align_m1) \
> +						& ~__rte_ptr_ceil_align_m1; \
> +	size_t __rte_ptr_ceil_offset =3D __rte_ptr_ceil_aligned -
> (uintptr_t)__rte_ptr_ceil; \
> +	__rte_diagnostic_push \
> +	__rte_diagnostic_ignored_wcast_qual \
> +	/* (3) Return the aligned result, cast to preserve input type. We
> avoid RTE_PTR_SUB */ \
> +	/*  to skip the void* cast which may defeat compiler alignment
> optimizations. */ \
> +	__rte_auto_type __rte_ptr_ceil_res =3D \
> +		(typeof(__rte_ptr_ceil))((char *)__rte_ptr_ceil +
> __rte_ptr_ceil_offset); \
> +	__rte_diagnostic_pop \
> +	__rte_ptr_ceil_res; \
> +}))
> +#else
>  #define RTE_PTR_ALIGN_CEIL(ptr, align) \
>  	RTE_PTR_ALIGN_FLOOR((typeof(ptr))RTE_PTR_ADD(ptr, (align) - 1),
> align)
> +#endif
>=20
>  /**
>   * Macro to align a value to a given power-of-two. The resultant =
value

