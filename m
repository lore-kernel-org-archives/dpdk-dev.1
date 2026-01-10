Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F15D277EC
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Jan 2026 15:02:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A77FB4028E;
	Sat, 10 Jan 2026 16:02:04 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9E23440144
 for <dev@dpdk.org>; Sat, 10 Jan 2026 16:02:03 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id BFB5520679;
 Sat, 10 Jan 2026 16:02:02 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v12 2/3] eal: add workaround for UBSAN alignment false
 positive
Date: Sat, 10 Jan 2026 16:02:01 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65647@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20260110015651.26201-3-scott.k.mitch1@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v12 2/3] eal: add workaround for UBSAN alignment false
 positive
Thread-Index: AdyB1HLBoj/tfHRATBCH6J4zTMIYfwAa60Gw
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
 <20260110015651.26201-3-scott.k.mitch1@gmail.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: <scott.k.mitch1@gmail.com>, <dev@dpdk.org>, <stephen@networkplumber.org>
Cc: "Scott" <scott_mitchell@apple.com>
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

> From: Scott <scott_mitchell@apple.com>
>=20
> The optimized __rte_raw_cksum() uses unaligned_uint16_t pointer access
> which triggers UBSAN alignment warnings even though the access is safe
> due to the unaligned type definition.
>=20
> Add __rte_no_ubsan_alignment attribute to suppress these false =
positive
> warnings while preserving other UBSAN checks.

I think root cause of the false positive warnings is a faulty type =
definition of unaligned_uint16_t in rte_common.h [1].

For architectures with strict alignment requirements, the type is =
correctly defined as:
typedef uint16_t unaligned_uint16_t __rte_aligned(1);

But for architectures with relaxed alignment requirements, the type =
definition is incomplete:
typedef uint16_t unaligned_uint16_t;

When UBSAN runs with the latter definition (which doesn't remove the =
type's alignment requirement), UBSAN is correctly warning about the =
misalignment.

Either UBSAN should run with the first definition (i.e. with =
__rte_aligned(1)), or the type definitions with __rte_aligned(1) should =
be used for all architectures.

[1]: =
https://elixir.bootlin.com/dpdk/v25.11/source/lib/eal/include/rte_common.=
h#L124

Stephen, WDYT?

>=20
> Signed-off-by: Scott Mitchell <scott.k.mitch1@gmail.com>
> ---
>  lib/eal/include/rte_common.h | 9 +++++++++
>  lib/net/rte_cksum.h          | 1 +
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/lib/eal/include/rte_common.h
> b/lib/eal/include/rte_common.h
> index 9e7d84f929..00d428e295 100644
> --- a/lib/eal/include/rte_common.h
> +++ b/lib/eal/include/rte_common.h
> @@ -546,6 +546,15 @@ static void
> __attribute__((destructor(RTE_PRIO(prio)), used)) func(void)
>  #define __rte_no_asan
>  #endif
>=20
> +/**
> + * Disable UndefinedBehaviorSanitizer alignment check on some code
> + */
> +#if defined(RTE_CC_CLANG) || defined(RTE_CC_GCC)
> +#define __rte_no_ubsan_alignment
> __attribute__((no_sanitize("alignment")))
> +#else
> +#define __rte_no_ubsan_alignment
> +#endif
> +
>  /*********** Macros for pointer arithmetic ********/
>=20
>  /**
> diff --git a/lib/net/rte_cksum.h b/lib/net/rte_cksum.h
> index 8dbe1179e8..9a7fda563d 100644
> --- a/lib/net/rte_cksum.h
> +++ b/lib/net/rte_cksum.h
> @@ -39,6 +39,7 @@ extern "C" {
>   * @return
>   *   sum +=3D Sum of all words in the buffer.
>   */
> +__rte_no_ubsan_alignment
>  static inline uint32_t
>  __rte_raw_cksum(const void *buf, size_t len, uint32_t sum)
>  {
> --
> 2.39.5 (Apple Git-154)

