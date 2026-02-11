Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFAFECD6EF
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 21:14:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE61C402B5;
	Wed, 11 Feb 2026 22:14:25 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id B5986402AB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 22:14:24 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 75914208FB;
 Wed, 11 Feb 2026 22:14:24 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 20/35] net/intel: write descriptors using non-volatile
 pointers
Date: Wed, 11 Feb 2026 22:14:20 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65710@smartserver.smartshare.dk>
In-Reply-To: <20260211181309.2838042-21-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 20/35] net/intel: write descriptors using non-volatile
 pointers
Thread-Index: Adybgm6pQV9UOMUvRgq8Gak233NZPgAGHJaA
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-21-bruce.richardson@intel.com>
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

> +static inline void
> +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> +{
> +	/* we use an aligned structure and cast away the volatile to
> allow the compiler
> +	 * to opportunistically optimize the two 64-bit writes as a
> single 128-bit write.
> +	 */
> +	__rte_aligned(16) struct txdesc {
> +		uint64_t qw0, qw1;

The documentation for __rte_aligned() says [1] it must be between the =
"struct" keyword and the name of the structure.
I.e. it should be:
struct __rte_aligned(16) txdesc {

[1]: =
https://elixir.bootlin.com/dpdk/v25.11/source/lib/eal/include/rte_common.=
h#L109

> +	} *txdesc =3D RTE_CAST_PTR(struct txdesc *, txd);
> +	txdesc->qw0 =3D rte_cpu_to_le_64(qw0);
> +	txdesc->qw1 =3D rte_cpu_to_le_64(qw1);
> +}


