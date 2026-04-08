Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E549910F9969
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Apr 2026 19:27:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CADAE40269;
	Wed,  8 Apr 2026 21:27:13 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 097B24027A
 for <dev@dpdk.org>; Wed,  8 Apr 2026 21:27:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id D0D772041E;
 Wed,  8 Apr 2026 21:27:12 +0200 (CEST)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v2] net/intel: optimize for fast-free hint
Date: Wed, 8 Apr 2026 21:27:11 +0200
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F657DE@smartserver.smartshare.dk>
In-Reply-To: <20260408132515.1314728-1-bruce.richardson@intel.com>
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v2] net/intel: optimize for fast-free hint
Thread-Index: AdzHWzGYEPYq3Y1zT4quJiqeGegHggALB5Tw
References: <20260123112032.2174361-1-bruce.richardson@intel.com>
 <20260408132515.1314728-1-bruce.richardson@intel.com>
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
> Sent: Wednesday, 8 April 2026 15.25
>=20
> When the fast-free hint is provided to the driver we know that the
> mbufs
> have refcnt of 1 and are from the same mempool. Therefore, we can
> optimize a bit for this case by:
>=20
> * resetting the necessary mbuf fields, ie. nb_seg and next pointer =
when
>   we are accessing the mbuf on writing the descriptor.
> * on cleanup of buffers after transmit, we can just write those =
buffers
>   straight to the mempool without accessing them.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

A bunch of review thoughts inline below.
The ones regarding instrumentation should be fixed.
The rest might be irrelevant and/or nonsense.

> ---
> V2: Fix issues with original submission:
> * missed check for NULL mbufs
> * fixed issue with freeing directly from sw_ring in scalar path which
>   doesn't work as thats not a flag array of pointers
> * fixed missing null assignment in case of large segments for TSO
> ---
>  drivers/net/intel/common/tx.h        | 21 ++++--
>  drivers/net/intel/common/tx_scalar.h | 95 =
++++++++++++++++++++++------
>  2 files changed, 90 insertions(+), 26 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h
> b/drivers/net/intel/common/tx.h
> index 283bd58d5d..f2123f069c 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -363,13 +363,22 @@ ci_txq_release_all_mbufs(struct ci_tx_queue =
*txq,
> bool use_ctx)
>  		return;
>=20
>  	if (!txq->use_vec_entry) {
> -		/* Regular scalar path uses sw_ring with ci_tx_entry */
> -		for (uint16_t i =3D 0; i < txq->nb_tx_desc; i++) {
> -			if (txq->sw_ring[i].mbuf !=3D NULL) {
> -				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> -				txq->sw_ring[i].mbuf =3D NULL;
> -			}
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
> +				if (txq->sw_ring[i].mbuf !=3D NULL)
> +					rte_pktmbuf_free_seg(txq-
> >sw_ring[i].mbuf);
> +			i =3D 0;
>  		}
> +		for (; i < end; i++)
> +			if (txq->sw_ring[i].mbuf !=3D NULL)
> +				rte_pktmbuf_free_seg(txq->sw_ring[i].mbuf);
> +		memset(txq->sw_ring, 0, sizeof(txq->sw_ring[0]) * nb_desc);
>  		return;
>  	}

The above LGTM.
IIRC, we already discussed it - or something very similar.

>=20
> diff --git a/drivers/net/intel/common/tx_scalar.h
> b/drivers/net/intel/common/tx_scalar.h
> index 9fcd2e4733..adbc4bafee 100644
> --- a/drivers/net/intel/common/tx_scalar.h
> +++ b/drivers/net/intel/common/tx_scalar.h
> @@ -197,16 +197,63 @@ ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
>  	const uint16_t rs_idx =3D (last_desc_cleaned =3D=3D nb_tx_desc - 1) =
?
>  			0 :
>  			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
> -	uint16_t desc_to_clean_to =3D (rs_idx << txq->log2_rs_thresh) +
> (txq->tx_rs_thresh - 1);
> +	const uint16_t dd_idx =3D txq->rs_last_id[rs_idx];
> +	const uint16_t first_to_clean =3D rs_idx << txq->log2_rs_thresh;
>=20
> -	/* Check if descriptor is done  */
> -	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
> -			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> -				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> +	/* Check if descriptor is done - all drivers use 0xF as done
> value in bits 3:0 */
> +	if ((txd[dd_idx].cmd_type_offset_bsz &
> rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> +			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> +		/* Descriptor not yet processed by hardware */
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

Depending on which cache lines from txq have already been loaded, unless =
txq->offloads is hot in the CPU cache and txq->fast_free_mp is not, =
consider testing (mp !=3D NULL) instead of (txq->offloads & =
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE).
Like here:
https://elixir.bootlin.com/dpdk/v26.03/source/drivers/net/intel/common/tx=
.h#L281

> +		void *free[CI_TX_MAX_FREE_BUF_SZ];
> +		uint16_t nb_free =3D 0;
> +
> +		/* Get cached mempool pointer, or cache it on first use */
> +		struct rte_mempool *mp =3D
> +			likely(txq->fast_free_mp !=3D (void *)UINTPTR_MAX) ?
> +			txq->fast_free_mp :
> +			(txq->fast_free_mp =3D sw_ring[dd_idx].mbuf->pool);
> +
> +		/* Pack non-NULL mbufs in-place at start of sw_ring range.
> +		 * No modulo needed in loop since we're guaranteed not to
> wrap.
> +		 */
> +		for (uint16_t i =3D 0; i < nb_to_clean; i++) {
> +			struct rte_mbuf *m =3D sw_ring[first_to_clean +
> i].mbuf;
> +			if (m =3D=3D NULL)
> +				continue;
> +			free[nb_free++] =3D m;

Should sw_ring[first_to_clean + i].mbuf be set to NULL here, instead of =
in ci_xmit_pkts()?
I don't know, just want you to consider it.

> +			if (unlikely(nb_free =3D=3D CI_TX_MAX_FREE_BUF_SZ)) {
> +				rte_mempool_put_bulk(mp, free, nb_free);

rte_mempool_put_bulk() -> rte_mbuf_raw_free_bulk(),
for instrumentation.

> +				nb_free =3D 0;
> +			}
> +		}
> +
> +		/* Bulk return to mempool using packed sw_ring entries
> directly */
> +		if (nb_free > 0)
> +			rte_mempool_put_bulk(mp, free, nb_free);

rte_mempool_put_bulk() -> rte_mbuf_raw_free_bulk(),
for instrumentation.

> +	} else {
> +		/* Non-FAST_FREE path: use prefree_seg for refcount checks
> */
> +		for (uint16_t i =3D 0; i < nb_to_clean; i++) {
> +			struct rte_mbuf *m =3D sw_ring[first_to_clean +
> i].mbuf;
> +			if (m !=3D NULL)
> +				rte_pktmbuf_free_seg(m);

Should sw_ring[first_to_clean + i].mbuf be set to NULL here, instead of =
in ci_xmit_pkts()?
I don't know, just want you to consider it.

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
> @@ -450,8 +497,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  			txd =3D &ci_tx_ring[tx_id];
>  			tx_id =3D txe->next_id;
>=20
> -			if (txe->mbuf)
> -				rte_pktmbuf_free_seg(txe->mbuf);
>  			txe->mbuf =3D tx_pkt;
>  			/* Setup TX Descriptor */
>  			td_cmd |=3D CI_TX_DESC_CMD_EOP;
> @@ -472,10 +517,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>=20
>  			txn =3D &sw_ring[txe->next_id];
>  			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);

RTE_MBUF_PREFETCH_TO_FREE() doesn't seem relevant here anymore.
I don't know if it fits into ci_tx_xmit_cleanup() instead.

> -			if (txe->mbuf) {
> -				rte_pktmbuf_free_seg(txe->mbuf);
> -				txe->mbuf =3D NULL;
> -			}
> +			txe->mbuf =3D NULL;

Already mentioned: Should txe->mbuf be set to NULL in =
ci_tx_xmit_cleanup() instead of in ci_tx_xmit_pkts()?

>=20
>  			write_txd(ctx_txd, cd_qw0, cd_qw1);
>=20
> @@ -489,10 +531,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>=20
>  			txn =3D &sw_ring[txe->next_id];
>  			RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);

RTE_MBUF_PREFETCH_TO_FREE() doesn't seem relevant here anymore.
I don't know if it fits into ci_tx_xmit_cleanup() instead.

> -			if (txe->mbuf) {
> -				rte_pktmbuf_free_seg(txe->mbuf);
> -				txe->mbuf =3D NULL;
> -			}
> +			txe->mbuf =3D NULL;

Already mentioned: Should txe->mbuf be set to NULL in =
ci_tx_xmit_cleanup() instead of in ci_tx_xmit_pkts()?

>=20
>  			ipsec_txd[0] =3D ipsec_qw0;
>  			ipsec_txd[1] =3D ipsec_qw1;
> @@ -507,10 +546,21 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  			txd =3D &ci_tx_ring[tx_id];
>  			txn =3D &sw_ring[txe->next_id];
>=20
> -			if (txe->mbuf)
> -				rte_pktmbuf_free_seg(txe->mbuf);
>  			txe->mbuf =3D m_seg;
>=20
> +			/* For FAST_FREE: reset mbuf fields while we have it
> in cache.
> +			 * FAST_FREE guarantees refcnt=3D1 and direct mbufs, so
> we only
> +			 * need to reset nb_segs and next pointer as per
> rte_pktmbuf_prefree_seg.
> +			 * Save next pointer before resetting since we need
> it for loop iteration.
> +			 */
> +			struct rte_mbuf *next_seg =3D m_seg->next;
> +			if (txq->offloads &
> RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) {

Similar to comment further above: Is txq->offloads or txq->fast_free_mp =
hotter in the CPU cache here?

> +				if (m_seg->nb_segs !=3D 1)
> +					m_seg->nb_segs =3D 1;
> +				if (next_seg !=3D NULL)
> +					m_seg->next =3D NULL;
> +			}
> +
>  			/* Setup TX Descriptor */
>  			/* Calculate segment length, using IPsec callback if
> provided */
>  			if (ipsec_ops !=3D NULL)
> @@ -528,18 +578,23 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  					((uint64_t)CI_MAX_DATA_PER_TXD <<
> CI_TXD_QW1_TX_BUF_SZ_S) |
>  					((uint64_t)td_tag <<
> CI_TXD_QW1_L2TAG1_S);
>  				write_txd(txd, buf_dma_addr,
> cmd_type_offset_bsz);
> +				/* txe for this slot has already been written
> (e.g. above outside
> +				 * loop), so we write the extra NULL mbuf
> pointer for this
> +				 * descriptor after we increment txe below.
> +				 */
>=20
>  				buf_dma_addr +=3D CI_MAX_DATA_PER_TXD;
>  				slen -=3D CI_MAX_DATA_PER_TXD;
>=20
>  				tx_id =3D txe->next_id;
>  				txe =3D txn;
> +				txe->mbuf =3D NULL;
>  				txd =3D &ci_tx_ring[tx_id];
>  				txn =3D &sw_ring[txe->next_id];
>  			}
>=20
>  			/* fill the last descriptor with End of Packet (EOP)
> bit */
> -			if (m_seg->next =3D=3D NULL)
> +			if (next_seg =3D=3D NULL)
>  				td_cmd |=3D CI_TX_DESC_CMD_EOP;
>=20
>  			const uint64_t cmd_type_offset_bsz =3D
> CI_TX_DESC_DTYPE_DATA |
> @@ -551,7 +606,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>=20
>  			tx_id =3D txe->next_id;
>  			txe =3D txn;
> -			m_seg =3D m_seg->next;
> +			m_seg =3D next_seg;
>  		} while (m_seg);
>  end_pkt:
>  		txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free - nb_used);
> --
> 2.51.0

