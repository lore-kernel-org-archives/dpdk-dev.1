Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7AFCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 21:39:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A31640649;
	Thu, 28 May 2026 23:39:11 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6198A4021F
 for <dev@dpdk.org>; Thu, 28 May 2026 23:39:10 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4B97B2098F;
 Thu, 28 May 2026 23:39:10 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC] doc, devtools: discourage new __rte_always_inline
Date: Thu, 28 May 2026 23:39:08 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F658B4@smartserver.smartshare.dk>
In-Reply-To: <20260527163734.599602-1-stephen@networkplumber.org>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] doc, devtools: discourage new __rte_always_inline
Thread-Index: Adzt9yZ82aQNPl1SR4mFWLIeDmY7AwA8Cp7A
References: <20260527163734.599602-1-stephen@networkplumber.org>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Stephen Hemminger" <stephen@networkplumber.org>,
	<dev@dpdk.org>
Cc: "Thomas Monjalon" <thomas@monjalon.net>
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

> From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> Sent: Wednesday, 27 May 2026 18.38
>=20
> Modern compilers at -O2 make good inlining decisions for small
> static inline functions; forced inlining via __rte_always_inline
> should be reserved for cases where it is required for correctness
> or for documented measured performance reasons.
>=20
> Document the policy in the coding style guide and add a
> checkpatches.sh entry that warns when new uses of the attribute
> are introduced.
>=20
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Plenty of code in DPDK is based on ancient compiler behavior; let's not =
add new code based on old compiler behavior.
I guess developers keep blindly adding __rte_always_inline, only because =
it's already everywhere.

Good initiative to stop that bad habit.
Slightly extreme forbidding it in checkpatches.sh, but it's probably the =
only way to force people to stop and think.

> ---
>  devtools/checkpatches.sh                 |  8 ++++++++
>  doc/guides/contributing/coding_style.rst | 25 =
+++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>=20
> diff --git a/devtools/checkpatches.sh b/devtools/checkpatches.sh
> index f5dd77443f..2a3d364178 100755
> --- a/devtools/checkpatches.sh
> +++ b/devtools/checkpatches.sh
> @@ -137,6 +137,14 @@ check_forbidden_additions() { # <patch>
>  		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk
> \
>  		"$1" || res=3D1
>=20
> +	# forbid new use of __rte_always_inline
> +	awk -v FOLDERS=3D"lib drivers app examples" \
> +		-v EXPRESSIONS=3D'\\<__rte_always_inline\\>' \
> +		-v RET_ON_FAIL=3D1 \
> +		-v MESSAGE=3D'Adding __rte_always_inline; prefer plain
> inline' \
> +		-f $(dirname $(readlink -f $0))/check-forbidden-tokens.awk
> \
> +		"$1" || res=3D1
> +
>  	# refrain from using compiler __rte_atomic_thread_fence()
>  	# It should be avoided on x86 for SMP case.
>  	awk -v FOLDERS=3D"lib drivers app examples" \
> diff --git a/doc/guides/contributing/coding_style.rst
> b/doc/guides/contributing/coding_style.rst
> index 243a3c2959..97e459853c 100644
> --- a/doc/guides/contributing/coding_style.rst
> +++ b/doc/guides/contributing/coding_style.rst
> @@ -747,11 +747,34 @@ Static Variables and Functions
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
>  * All functions and variables that are local to a file must be
> declared as ``static`` because it can often help the compiler to do
> some optimizations (such as, inlining the code).
> -* Functions that should be inlined should to be declared as ``static
> inline`` and can be defined in a .c or a .h file.
> +* Functions that should be inlined should be declared as ``static
> inline`` and can be defined in a .c or a .h file.
>=20
>  .. note::
>  	Static functions defined in a header file must be declared as
> ``static inline`` in order to prevent compiler warnings about the
> function being unused.
>=20
> +Use of ``__rte_always_inline``
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``__rte_always_inline`` attribute forces the compiler to inline a
> function regardless of its size or call-graph heuristics.
> +Prefer plain ``inline`` (or no annotation at all for static =
functions)
> and let the compiler decide.
> +Modern compilers at ``-O2`` make good inlining decisions for small
> ``static inline`` functions in headers,
> +and forced inlining can hurt performance by inflating function =
bodies,
> increasing register pressure, and overriding profile-guided
> optimization.
> +
> +``__rte_always_inline`` should only be used when one of the following
> applies:
> +
> +* The function contains ``__builtin_constant_p`` checks that gate a

__builtin_constant_p -> __rte_constant

> constant-folded fast path, and the optimization is lost if the =
function
> is not inlined into the caller.
> +  Examples include byte-order helpers and length-dispatched
> copy/compare routines.
> +
> +* The function wraps inline assembly or a compiler intrinsic whose
> correctness depends on being inlined into the caller's register =
context
> (for example, intrinsics requiring a compile-time constant argument).
> +
> +* Measurement on a representative workload shows that the annotation
> is required to retain performance, and the reason is documented in the
> commit message that introduces it.
> +
> +Each use must be justified at the point it is introduced. Adding
> ``__rte_always_inline`` because nearby code uses it is not a
> justification;
> +if the constant or intrinsic that requires inlining is several call
> levels up the call chain,
> +restructure the code rather than annotating the entire chain.

Please add something similar to the description of the macro in =
rte_common.h.

> +
> +The complementary attribute ``__rte_noinline`` is useful for
> explicitly marking cold paths (error handling, initialization, slow-
> path fallbacks) where outlining the function can reduce instruction-
> cache pressure on the hot path.

Same comment:
Please add something similar to the description of the macro in =
rte_common.h.

<feature creep>
Many macros in rte_common.h have insufficient descriptions.
</feature creep>

> +
>  Const Attribute
>  ~~~~~~~~~~~~~~~
>=20
> --
> 2.53.0

With comments above fixed,
Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>
