Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DF6E9461B
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 22:35:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 87098402C4;
	Mon,  9 Feb 2026 23:35:31 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3A038402C3
 for <dev@dpdk.org>; Mon,  9 Feb 2026 23:35:30 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 2CC43206E4;
 Mon,  9 Feb 2026 23:35:29 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v4 19/35] eal: add macro for marking assumed alignment
Date: Mon, 9 Feb 2026 23:35:26 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F656F5@smartserver.smartshare.dk>
In-Reply-To: <20260209164538.1428499-20-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v4 19/35] eal: add macro for marking assumed alignment
Thread-Index: AdyZ49/gPsUYjDG9Qq6CZ97wg3/bnQALcMGw
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260209164538.1428499-1-bruce.richardson@intel.com>
 <20260209164538.1428499-20-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
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

> From: Bruce Richardson [mailto:bruce.richardson@intel.com]
> Sent: Monday, 9 February 2026 17.45
>=20
> Provide a common DPDK macro for the gcc/clang builtin
> __rte_assume_aligned to mark pointers as pointing to something with
> known minimum alignment.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  lib/eal/include/rte_common.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/lib/eal/include/rte_common.h
> b/lib/eal/include/rte_common.h
> index 573bf4f2ce..51a2eaf8b4 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -121,6 +121,12 @@ extern "C" {
>  #define __rte_aligned(a) __attribute__((__aligned__(a)))
>  #endif
>=20
> +#ifdef RTE_TOOLCHAIN_MSVC
> +#define __rte_assume_aligned(ptr, align) (ptr)
> +#else
> +#define __rte_assume_aligned __builtin_assume_aligned
> +#endif

The GCC/Clang macro supports the optional 3rd parameter (offset), but =
the MSVC doesn't.
Maybe it's better to pass (ptr, align) to the GCC/Clang variant, so the =
API consistently only supports two parameters.

If the 3rd parameter ever becomes needed, it can be implemented as a new =
macro.

Also, a short description of the macro would be nice.


Did you look into using e.g. __rte_assume((ptr % 16) =3D=3D 0) instead?
It's relevant if it has the desired effect for MSVC, which the macro in =
this patch doesn't.

