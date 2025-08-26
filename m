Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56EECA0FE9
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 07:27:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D8DC4029E;
	Tue, 26 Aug 2025 09:27:34 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DE93F4021E
 for <dev@dpdk.org>; Tue, 26 Aug 2025 09:27:31 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B2DE92071D;
 Tue, 26 Aug 2025 09:27:31 +0200 (CEST)
Subject: RE: [PATCH 1/2] net/intel: avoid allocating from mempool directly
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 Aug 2025 09:27:30 +0200
Content-class: urn:content-classes:message
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35E9FE6F@smartserver.smartshare.dk>
In-Reply-To: <20250822170656.454571-2-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] net/intel: avoid allocating from mempool directly
X-MimeOLE: Produced By Microsoft Exchange V6.5
Thread-Index: AdwThzRrca8bq1FeSvSf2myeFYPMpwC0Hi6g
References: <20250822170656.454571-1-bruce.richardson@intel.com>
 <20250822170656.454571-2-bruce.richardson@intel.com>
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
> Sent: Friday, 22 August 2025 19.07
>=20
> Rather than calling the mempool function rte_mempool_get_bulk we =
update
> the code to use the mbuf function rte_mbuf_raw_alloc_bulk, which
> properly supports debug flags and checks - when enabled.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

Acked-by: Morten Br=F8rup <mb@smartsharesystems.com>

With a slightly unrelated comment inline below.

> ---
>=20
> diff --git a/drivers/net/intel/common/rx_vec_arm.h
> b/drivers/net/intel/common/rx_vec_arm.h
> index 2e48d4b6c0..f7e7b8c396 100644
> --- a/drivers/net/intel/common/rx_vec_arm.h
> +++ b/drivers/net/intel/common/rx_vec_arm.h
> @@ -16,19 +16,19 @@
>  static inline int
>  _ci_rxq_rearm_get_bufs(struct ci_rx_queue *rxq)
>  {
> -	struct ci_rx_entry *rxp =3D &rxq->sw_ring[rxq->rxrearm_start];
> +	struct rte_mbuf **rxp =3D &rxq->sw_ring[rxq->rxrearm_start].mbuf;

A comment not directly related to this patch, and something I noticed =
before without mentioning it...

The "ci_rx_entry" is defined as follows [1]:
struct ci_rx_entry {
	struct rte_mbuf *mbuf; /* mbuf associated with RX descriptor. */
};

Which makes it equivalent to an mbuf pointer.
Type casting an array of "struct ci_rx_entry" to an array of "struct =
rte_mbuf *" relies on the "struct ci_rx_entry" not having any more =
fields.
Having this extra (technically superfluous) wrapper makes it somewhat =
difficult to review the code, and requires more type casting.
I suppose there are good reasons for having this extra wrapper. (Perhaps =
something like the reason for the rte_atomic32_t type being a struct =
with an integer counter field, instead of a simple typedef.)

Anyway, for the benefit of the reviewer, you should consider adding a =
"static_assert(sizeof(struct ci_rx_entry) =3D=3D sizeof(struct rte_mbuf =
*))" and a comment when you do this type casting.

[1]: =
https://elixir.bootlin.com/dpdk/v25.07/source/drivers/net/intel/common/rx=
.h#L25

