Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E54D7237B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 12:05:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72A5C4026F;
	Fri, 23 Jan 2026 13:05:16 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id D37AC40269
 for <dev@dpdk.org>; Fri, 23 Jan 2026 13:05:14 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id EDE362071A;
 Fri, 23 Jan 2026 13:05:13 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH] net/intel: optimize for fast-free hint
Date: Fri, 23 Jan 2026 13:05:10 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65694@smartserver.smartshare.dk>
In-Reply-To: <20260123112032.2174361-1-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] net/intel: optimize for fast-free hint
Thread-Index: AdyMWlJWUIyPHglUSVy3fiWDAdMPlgABHVvw
References: <98CBD80474FA8B44BF855DF32C47DC35F6565B@smartserver.smartshare.dk>
 <20260123112032.2174361-1-bruce.richardson@intel.com>
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

I haven't looked into the details yet, but have a quick question inline =
below.

> @@ -345,12 +345,20 @@ ci_txq_release_all_mbufs(struct ci_tx_queue =
*txq,
> bool use_ctx)
>  		return;
>=20
>  	if (!txq->vector_tx) {
> -		for (uint16_t i =3D 0; i < txq->nb_tx_desc; i++) {
> -			if (txq->sw_ring[i].mbuf !=3D NULL) {

You changed this loop to only operate on not-yet-cleaned descriptors.

Here comes the first part of my question:
You removed the NULL check for txq->sw_ring[i].mbuf, thereby assuming =
that it is never NULL for not-yet-cleaned descriptors.

> +		/* Free mbufs from (last_desc_cleaned + 1) to (tx_tail -
> 1). */
> +		const uint16_t start =3D (txq->last_desc_cleaned + 1) % txq-
> >nb_tx_desc;
> +		const uint16_t nb_desc =3D txq->nb_tx_desc;
> +		const uint16_t end =3D txq->tx_tail;
> +
> +		uint16_t i =3D start;
> +		if (end < i) {
> +			for (; i < nb_desc; i++)
>  				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> -				txq->sw_ring[i].mbuf =3D NULL;
> -			}
> +			i =3D 0;
>  		}
> +		for (; i < end; i++)
> +			rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> +		memset(txq->sw_ring, 0, sizeof(txq->sw_ring[0]) * nb_desc);
>  		return;
>  	}
>=20
> diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> b/drivers/net/intel/common/tx_scalar_fns.h
> index 82dc54438f..47ddcf411b 100644
> --- a/drivers/net/intel/common/tx_scalar_fns.h
> +++ b/drivers/net/intel/common/tx_scalar_fns.h
> @@ -30,16 +30,60 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
>  	const uint16_t rs_idx =3D (last_desc_cleaned =3D=3D nb_tx_desc - 1) =
?
>  			0 :
>  			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
> -	uint16_t desc_to_clean_to =3D (rs_idx << txq->log2_rs_thresh) +
> (txq->tx_rs_thresh - 1);
> +	const uint16_t dd_idx =3D txq->rs_last_id[rs_idx];
> +	const uint16_t first_to_clean =3D rs_idx << txq->log2_rs_thresh;
>=20
>  	/* Check if descriptor is done - all drivers use 0xF as done
> value in bits 3:0 */
> -	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
> rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> +	if ((txd[dd_idx].cmd_type_offset_bsz &
> rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
>  			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
>  		/* Descriptor not yet processed by hardware */
>  		return -1;
>=20
> +	/* DD bit is set, descriptors are done. Now free the mbufs. */
> +	/* Note: nb_tx_desc is guaranteed to be a multiple of
> tx_rs_thresh,
> +	 * validated during queue setup. This means cleanup never wraps
> around
> +	 * the ring within a single burst (e.g., ring=3D256, rs_thresh=3D32
> gives
> +	 * bursts of 0-31, 32-63, ..., 224-255).
> +	 */
> +	const uint16_t nb_to_clean =3D txq->tx_rs_thresh;
> +	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
> +
> +	if (txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {
> +		/* FAST_FREE path: mbufs are already reset, just return to
> pool */
> +		uint16_t nb_free =3D 0;
> +
> +		/* Get cached mempool pointer, or cache it on first use */
> +		struct rte_mempool *mp =3D
> +			likely(txq->fast_free_mp !=3D (void *)UINTPTR_MAX) ?
> +			txq->fast_free_mp :
> +			(txq->fast_free_mp =3D sw_ring[dd_idx].mbuf->pool);
> +
> +		/* Pack non-NULL mbufs in-place at start of sw_ring range.

Here is the second part of my question:
How can they (sw_ring[X].mbuf) be NULL here, when they cannot be NULL in =
ci_txq_release_all_mbufs()?

> +		 * No modulo needed in loop since we're guaranteed not to
> wrap.
> +		 */
> +		for (uint16_t i =3D 0; i < nb_to_clean; i++) {
> +			struct rte_mbuf *m =3D sw_ring[first_to_clean +
> i].mbuf;
> +			if (m !=3D NULL) {
> +				/* Pack into sw_ring at packed position */
> +				sw_ring[first_to_clean + nb_free].mbuf =3D m;
> +				nb_free++;
> +			}
> +		}
> +
> +		/* Bulk return to mempool using packed sw_ring entries
> directly */
> +		if (nb_free > 0)
> +			rte_mempool_put_bulk(mp, (void
> **)&sw_ring[first_to_clean].mbuf, nb_free);
> +	} else {
> +		/* Non-FAST_FREE path: use prefree_seg for refcount checks
> */
> +		for (uint16_t i =3D 0; i < nb_to_clean; i++) {
> +			struct rte_mbuf *m =3D sw_ring[first_to_clean +
> i].mbuf;
> +			if (m !=3D NULL)
> +				rte_pktmbuf_free_seg(m);
> +		}
> +	}
> +
>  	/* Update the txq to reflect the last descriptor that was cleaned
> */
> -	txq->last_desc_cleaned =3D desc_to_clean_to;
> +	txq->last_desc_cleaned =3D first_to_clean + txq->tx_rs_thresh - 1;
>  	txq->nb_tx_free +=3D txq->tx_rs_thresh;
>=20
>  	return 0;
