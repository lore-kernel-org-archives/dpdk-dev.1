Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0443CD6E57
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 07:07:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB313402C4;
	Tue,  2 Jun 2026 09:07:45 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id F074C40150
 for <dev@dpdk.org>; Tue,  2 Jun 2026 09:07:44 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gV21j1sy2zJ46Dc;
 Tue,  2 Jun 2026 15:06:33 +0800 (CST)
Received: from dubpeml100001.china.huawei.com (unknown [7.214.144.137])
 by mail.maildlp.com (Postfix) with ESMTPS id 781B840584;
 Tue,  2 Jun 2026 15:07:34 +0800 (CST)
Received: from dubpeml500001.china.huawei.com (7.214.147.241) by
 dubpeml100001.china.huawei.com (7.214.144.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Jun 2026 08:07:34 +0100
Received: from dubpeml500001.china.huawei.com ([7.214.147.241]) by
 dubpeml500001.china.huawei.com ([7.214.147.241]) with mapi id 15.02.1544.011; 
 Tue, 2 Jun 2026 08:07:33 +0100
From: Konstantin Ananyev <konstantin.ananyev@huawei.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "dev@dpdk.org"
 <dev@dpdk.org>
CC: Thomas Monjalon <thomas@monjalon.net>
Subject: RE: [PATCH v2] doc, eal, devtools: discourage new __rte_always_inline
Thread-Topic: [PATCH v2] doc, eal, devtools: discourage new __rte_always_inline
Thread-Index: AQHc8esWMN89WYtpCkm/NV7uDjUvrLYq0ySA
Date: Tue, 2 Jun 2026 07:07:33 +0000
Message-ID: <ec7bf0c51f9246eb9a36840db87d1b6f@huawei.com>
References: <20260527163734.599602-1-stephen@networkplumber.org>
 <20260601172104.311909-1-stephen@networkplumber.org>
In-Reply-To: <20260601172104.311909-1-stephen@networkplumber.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.195.245.94]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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



> Modern compilers at -O2 make good inlining decisions for small
> static inline functions; forced inlining via __rte_always_inline
> should be reserved for cases where it is required for correctness
> or for documented measured performance reasons.
>=20
> Document the policy in the coding style guide and add a
> checkpatches.sh entry that flags when new uses of the attribute
> are introduced. Checkpatches is not an absolute blocker to
> acceptance, only an indicator that more review is needed.
>=20
> Add additional comments about use of __rte_always_inline,
> __rte_noinline, __rte_hot, and __rte_cold to the rte_common.h
> to aid developers.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  devtools/checkpatches.sh                 |  8 +++++
>  doc/guides/contributing/coding_style.rst | 26 ++++++++++++++++-
>  lib/eal/include/rte_common.h             | 37 ++++++++++++++++++++++--
>  3 files changed, 68 insertions(+), 3 deletions(-)
>=20
> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index f5dd77443f..2a3d364178 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -137,6 +137,14 @@ check_forbidden_additions() { # <patch>
>  		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
>  		"$1" || res=3D1
>=20
> +	# forbid new use of __rte_always_inline
> +	awk -v FOLDERS=3D"lib drivers app examples" \
> +		-v EXPRESSIONS=3D'\\<__rte_always_inline\\>' \
> +		-v RET_ON_FAIL=3D1 \
> +		-v MESSAGE=3D'Adding __rte_always_inline; prefer plain inline' \
> +		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk \
> +		"$1" || res=3D1
> +
>  	# refrain from using compiler __rte_atomic_thread_fence()
>  	# It should be avoided on x86 for SMP case.
>  	awk -v FOLDERS=3D"lib drivers app examples" \
> diff --git a/doc/guides/contributing/coding_style.rst
> b/doc/guides/contributing/coding_style.rst
> index 243a3c2959..8f9e77d1c1 100644
> --- a/doc/guides/contributing/coding_style.rst
> +++ b/doc/guides/contributing/coding_style.rst
> @@ -747,11 +747,35 @@ Static Variables and Functions
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>  * All functions and variables that are local to a file must be declared =
as ``static``
> because it can often help the compiler to do some optimizations (such as,=
 inlining
> the code).
> -* Functions that should be inlined should to be declared as ``static inl=
ine`` and
> can be defined in a .c or a .h file.
> +* Functions that should be inlined should be declared as ``static inline=
`` and can
> be defined in a .c or a .h file.
>=20
>  .. note::
>  	Static functions defined in a header file must be declared as ``static
> inline`` in order to prevent compiler warnings about the function being u=
nused.
>=20
> +Use of ``__rte_always_inline``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``__rte_always_inline`` attribute forces the compiler to inline a fu=
nction
> regardless of its size or call-graph heuristics.
> +Prefer plain ``inline`` (or no annotation at all for static functions) a=
nd let the
> compiler decide.
> +Modern compilers at ``-O2`` make good inlining decisions for small ``sta=
tic
> inline`` functions in headers,
> +and forced inlining can hurt performance by inflating function bodies, i=
ncreasing
> register pressure, and overriding profile-guided optimization.
> +
> +``__rte_always_inline`` should only be used when one of the following ap=
plies:
> +
> +* The function contains ``__rte_constant()`` checks that gate a constant=
-folded
> fast path,
> +  and the optimization is lost if the function is not inlined into the c=
aller.
> +  Examples include byte-order helpers and length-dispatched copy/compare
> routines.
> +
> +* The function wraps inline assembly or a compiler intrinsic whose corre=
ctness
> depends on being inlined into the caller's register context (for example,=
 intrinsics
> requiring a compile-time constant argument).
> +
> +* Measurement on a representative workload shows that the annotation is
> required to retain performance, and the reason is documented in the commi=
t
> message that introduces it.
> +
> +Each use must be justified at the point it is introduced. Adding
> ``__rte_always_inline`` because nearby code uses it is not a justificatio=
n;
> +if the constant or intrinsic that requires inlining is several call leve=
ls up the call
> chain,
> +restructure the code rather than annotating the entire chain.
> +
> +The complementary attribute ``__rte_noinline`` is useful for explicitly =
marking
> cold paths (error handling, initialization, slow-path fallbacks) where ou=
tlining the
> function can reduce instruction-cache pressure on the hot path.
> +
>  Const Attribute
>  ~~~~~~~~~~~~~~~
>=20
> diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
> index 71415346cf..e358be7fcf 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -482,7 +482,22 @@ static void __attribute__((destructor(RTE_PRIO(prio)=
),
> used)) func(void)
>  #endif
>=20
>  /**
> - * Force a function to be inlined
> + * Force a function to be inlined, regardless of the compiler's size and
> + * call-graph heuristics.
> + *
> + * Prefer plain @c inline (or no annotation on a static function) and le=
t the
> compiler decide.
> + * Modern compilers at -O2 inline small static functions well,
> + * and forcing it can hurt by inflating call sites, raising register pre=
ssure,
> + * and overriding profile-guided optimization.
> + *
> + * Reserve this attribute for cases where inlining is required for
> + * correctness, or for a documented and measured performance reason, e.g=
.
> + *  - a constant-folded fast path gated by @c __rte_constant() that is l=
ost
> + *    unless the function is inlined into the caller;
> + *  - a wrapper around inline asm or an intrinsic that needs a
> + *    compile-time-constant argument from the caller's context.
> + *
> + * See the DPDK coding style guide for the full policy.
>   */
>  #ifdef RTE_TOOLCHAIN_MSVC
>  #define __rte_always_inline __forceinline
> @@ -491,7 +506,11 @@ static void __attribute__((destructor(RTE_PRIO(prio)=
),
> used)) func(void)
>  #endif
>=20
>  /**
> - * Force a function to be noinlined
> + * Force a function not to be inlined.
> + *
> + * Useful for explicitly outlining cold paths such as error handling,
> + * initialization, slow-path fallbacks, so they do not bloat the hot pat=
h
> + * or add to its instruction-cache footprint.
>   */
>  #ifdef RTE_TOOLCHAIN_MSVC
>  #define __rte_noinline __declspec(noinline)
> @@ -501,6 +520,12 @@ static void __attribute__((destructor(RTE_PRIO(prio)=
),
> used)) func(void)
>=20
>  /**
>   * Hint function in the hot path
> + *
> + * The compiler may optimize the function more aggressively, treat calls
> + * to it as likely for branch prediction, and group it with other hot
> + * functions to improve instruction-cache locality. This affects code
> + * placement and prediction, not inlining; combine with an inline
> + * annotation if both are wanted.
>   */
>  #ifdef RTE_TOOLCHAIN_MSVC
>  #define __rte_hot
> @@ -510,6 +535,14 @@ static void __attribute__((destructor(RTE_PRIO(prio)=
),
> used)) func(void)
>=20
>  /**
>   * Hint function in the cold path
> + *
> + * The compiler optimizes the function for size rather than speed,
> + * marks branches that reach it as unlikely, and may move it to a separa=
te
> + * section to keep it off the hot path and reduce instruction-cache
> + * pressure there.
> + *
> + * Suitable for error handling, logging, and setup/teardown code.
> + * Functions marked @c __rte_noreturn are already treated as cold.
>   */
>  #ifdef RTE_TOOLCHAIN_MSVC
>  #define __rte_cold
> --

Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>

> 2.53.0

