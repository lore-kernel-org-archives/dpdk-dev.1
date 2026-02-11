Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1539ECD6F1
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 21:52:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E07C0402B5;
	Wed, 11 Feb 2026 22:52:04 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 67FD2402AB
 for <dev@dpdk.org>; Wed, 11 Feb 2026 22:52:03 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4760A208FB;
 Wed, 11 Feb 2026 22:52:02 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [PATCH v5 23/35] net/intel: use separate array for desc status
 tracking
Date: Wed, 11 Feb 2026 22:51:56 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.5
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65711@smartserver.smartshare.dk>
In-Reply-To: <20260211181309.2838042-24-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH v5 23/35] net/intel: use separate array for desc status
 tracking
Thread-Index: AdybgneeIF0CJ064R3qULwEkVezrhgAGzcIg
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260211181309.2838042-1-bruce.richardson@intel.com>
 <20260211181309.2838042-24-bruce.richardson@intel.com>
From: =?iso-8859-1?Q?Morten_Br=F8rup?= <mb@smartsharesystems.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>,
	<dev@dpdk.org>
Cc: "Anatoly Burakov" <anatoly.burakov@intel.com>,
 "Praveen Shetty" <praveen.shetty@intel.com>,
 "Vladimir Medvedkin" <vladimir.medvedkin@intel.com>,
 "Jingjing Wu" <jingjing.wu@intel.com>
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

> Rather than writing a last_id for each individual descriptor, we can
> write one only for places where the "report status" (RS) bit is set,
> i.e. the descriptors which will be written back when done. The method
> used for marking what descriptors are free is also changed in the
> process, even if the last descriptor with the "done" bits set is past
> the expected point, we only track up to the expected point, and leave
> the rest to be counted as freed next time. This means that we always
> have the RS/DD bits set at fixed intervals, and we always track free
> slots in units of the same tx_free_thresh intervals.

I'm not saying it's good or bad, I'm simply trying to understand the =
performance tradeoff...
I'm wondering if spreading fields over two separate arrays is beneficial =
when considering cache misses.

This patch introduces a separate array, uint16_t txq->rs_last_id[], =
which is not in the same cache line as the txe array.

So now, two separate cache lines must be updated, rs_last_id and txe.

Previously, only txe needed updating.

Assuming both rings are cold, how many cache misses would a burst of 32 =
(single-segment) packets cause...
Number of cache misses in the txe ring (before this patch, and after)?
Number of cache misses in the rs_last_id ring (after this patch)?


>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
>  drivers/net/intel/common/tx.h             |  4 ++
>  drivers/net/intel/common/tx_scalar.h      | 66 =
+++++++++++------------
>  drivers/net/intel/cpfl/cpfl_rxtx.c        | 16 ++++++
>  drivers/net/intel/i40e/i40e_rxtx.c        | 20 +++++++
>  drivers/net/intel/iavf/iavf_rxtx.c        | 19 +++++++
>  drivers/net/intel/ice/ice_rxtx.c          | 20 +++++++
>  drivers/net/intel/idpf/idpf_common_rxtx.c |  7 +++
>  drivers/net/intel/idpf/idpf_rxtx.c        | 12 +++++
>  8 files changed, 130 insertions(+), 34 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx.h
> b/drivers/net/intel/common/tx.h
> index 5da6c7c15d..acd362dca3 100644
> --- a/drivers/net/intel/common/tx.h
> +++ b/drivers/net/intel/common/tx.h
> @@ -134,6 +134,8 @@ struct ci_tx_queue {
>  		struct ci_tx_entry *sw_ring; /* virtual address of SW ring
> */
>  		struct ci_tx_entry_vec *sw_ring_vec;
>  	};
> +	/* Scalar TX path: Array tracking last_id at each RS threshold
> boundary */
> +	uint16_t *rs_last_id;
>  	uint16_t nb_tx_desc;           /* number of TX descriptors */
>  	uint16_t tx_tail; /* current value of tail register */
>  	uint16_t nb_tx_used; /* number of TX desc used since RS bit set
> */
> @@ -147,6 +149,8 @@ struct ci_tx_queue {
>  	uint16_t tx_free_thresh;
>  	/* Number of TX descriptors to use before RS bit is set. */
>  	uint16_t tx_rs_thresh;
> +	/* Scalar TX path: log2 of tx_rs_thresh for efficient bit
> operations */
> +	uint8_t log2_rs_thresh;
>  	uint16_t port_id;  /* Device port identifier. */
>  	uint16_t queue_id; /* TX queue index. */
>  	uint16_t reg_idx;
> diff --git a/drivers/net/intel/common/tx_scalar.h
> b/drivers/net/intel/common/tx_scalar.h
> index 0bc2956dcf..7499e5ed20 100644
> --- a/drivers/net/intel/common/tx_scalar.h
> +++ b/drivers/net/intel/common/tx_scalar.h
> @@ -22,33 +22,25 @@
>  static __rte_always_inline int
>  ci_tx_xmit_cleanup(struct ci_tx_queue *txq)
>  {
> -	struct ci_tx_entry *sw_ring =3D txq->sw_ring;
>  	volatile struct ci_tx_desc *txd =3D txq->ci_tx_ring;
> -	uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> -	uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> -	uint16_t desc_to_clean_to;
> -	uint16_t nb_tx_to_clean;
> -
> -	/* Determine the last descriptor needing to be cleaned */
> -	desc_to_clean_to =3D (uint16_t)(last_desc_cleaned + txq-
> >tx_rs_thresh);
> -	if (desc_to_clean_to >=3D nb_tx_desc)
> -		desc_to_clean_to =3D (uint16_t)(desc_to_clean_to -
> nb_tx_desc);
> -
> -	/* Check if descriptor is done */
> -	desc_to_clean_to =3D sw_ring[desc_to_clean_to].last_id;
> -	if ((txd[desc_to_clean_to].cmd_type_offset_bsz &
> rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> -			rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
> +	const uint16_t last_desc_cleaned =3D txq->last_desc_cleaned;
> +	const uint16_t nb_tx_desc =3D txq->nb_tx_desc;
> +
> +	/* Calculate where the next descriptor write-back will occur */
> +	const uint16_t rs_idx =3D (last_desc_cleaned =3D=3D nb_tx_desc - 1) =
?
> +			0 :
> +			(last_desc_cleaned + 1) >> txq->log2_rs_thresh;
> +	uint16_t desc_to_clean_to =3D (rs_idx << txq->log2_rs_thresh) +
> (txq->tx_rs_thresh - 1);
> +
> +	/* Check if descriptor is done  */
> +	if ((txd[txq->rs_last_id[rs_idx]].cmd_type_offset_bsz &
> +			rte_cpu_to_le_64(CI_TXD_QW1_DTYPE_M)) !=3D
> +				rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DESC_DONE))
>  		return -1;
>=20
> -	/* Figure out how many descriptors will be cleaned */
> -	if (last_desc_cleaned > desc_to_clean_to)
> -		nb_tx_to_clean =3D (uint16_t)((nb_tx_desc -
> last_desc_cleaned) + desc_to_clean_to);
> -	else
> -		nb_tx_to_clean =3D (uint16_t)(desc_to_clean_to -
> last_desc_cleaned);
> -
>  	/* Update the txq to reflect the last descriptor that was cleaned
> */
>  	txq->last_desc_cleaned =3D desc_to_clean_to;
> -	txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free + nb_tx_to_clean);
> +	txq->nb_tx_free +=3D txq->tx_rs_thresh;
>=20
>  	return 0;
>  }
> @@ -219,6 +211,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  		uint16_t nb_ipsec =3D 0;
>  		uint64_t ipsec_qw0 =3D 0, ipsec_qw1 =3D 0;
>  		uint64_t cd_qw0 =3D 0, cd_qw1 =3D 0;
> +		uint16_t pkt_rs_idx;
>  		tx_pkt =3D *tx_pkts++;
>=20
>  		ol_flags =3D tx_pkt->ol_flags;
> @@ -262,6 +255,9 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  		if (tx_last >=3D txq->nb_tx_desc)
>  			tx_last =3D (uint16_t)(tx_last - txq->nb_tx_desc);
>=20
> +		/* Track the RS threshold bucket at packet start */
> +		pkt_rs_idx =3D (uint16_t)(tx_id >> txq->log2_rs_thresh);
> +
>  		if (nb_used > txq->nb_tx_free) {
>  			if (ci_tx_xmit_cleanup(txq) !=3D 0) {
>  				if (nb_tx =3D=3D 0)
> @@ -302,10 +298,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>=20
>  			if (txe->mbuf)
>  				rte_pktmbuf_free_seg(txe->mbuf);
> -			*txe =3D (struct ci_tx_entry){
> -				.mbuf =3D tx_pkt, .last_id =3D tx_last, .next_id =3D
> tx_id
> -			};
> -
> +			txe->mbuf =3D tx_pkt;
>  			/* Setup TX Descriptor */
>  			td_cmd |=3D CI_TX_DESC_CMD_EOP;
>  			const uint64_t cmd_type_offset_bsz =3D
> CI_TX_DESC_DTYPE_DATA |
> @@ -332,7 +325,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>=20
>  			write_txd(ctx_txd, cd_qw0, cd_qw1);
>=20
> -			txe->last_id =3D tx_last;
>  			tx_id =3D txe->next_id;
>  			txe =3D txn;
>  		}
> @@ -351,7 +343,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  			ipsec_txd[0] =3D ipsec_qw0;
>  			ipsec_txd[1] =3D ipsec_qw1;
>=20
> -			txe->last_id =3D tx_last;
>  			tx_id =3D txe->next_id;
>  			txe =3D txn;
>  		}
> @@ -387,7 +378,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  				buf_dma_addr +=3D CI_MAX_DATA_PER_TXD;
>  				slen -=3D CI_MAX_DATA_PER_TXD;
>=20
> -				txe->last_id =3D tx_last;
>  				tx_id =3D txe->next_id;
>  				txe =3D txn;
>  				txd =3D &ci_tx_ring[tx_id];
> @@ -405,7 +395,6 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
>  			write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
>=20
> -			txe->last_id =3D tx_last;
>  			tx_id =3D txe->next_id;
>  			txe =3D txn;
>  			m_seg =3D m_seg->next;
> @@ -414,13 +403,22 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  		txq->nb_tx_used =3D (uint16_t)(txq->nb_tx_used + nb_used);
>  		txq->nb_tx_free =3D (uint16_t)(txq->nb_tx_free - nb_used);
>=20
> -		/* set RS bit on the last descriptor of one packet */
> -		if (txq->nb_tx_used >=3D txq->tx_rs_thresh) {
> +		/* Check if packet crosses into a new RS threshold bucket.
> +		 * The RS bit is set on the last descriptor when we move
> from one bucket to another.
> +		 * For example, with tx_rs_thresh=3D32 and a 5-descriptor
> packet using slots 30-34:
> +		 *   - pkt_rs_idx =3D 30 >> 5 =3D 0 (started in bucket 0)
> +		 *   - tx_last =3D 34, so 35 >> 5 =3D 1 (next packet is in
> bucket 1)
> +		 *   - Since 0 !=3D 1, set RS bit on descriptor 34, and
> record rs_last_id[0] =3D 34
> +		 */
> +		uint16_t next_rs_idx =3D ((tx_last + 1) >> txq-
> >log2_rs_thresh);
> +
> +		if (next_rs_idx !=3D pkt_rs_idx) {
> +			/* Packet crossed into a new bucket - set RS bit on
> last descriptor */
>  			txd->cmd_type_offset_bsz |=3D
>  					rte_cpu_to_le_64(CI_TX_DESC_CMD_RS <<
> CI_TXD_QW1_CMD_S);
>=20
> -			/* Update txq RS bit counters */
> -			txq->nb_tx_used =3D 0;
> +			/* Record the last descriptor ID for the bucket we're
> leaving */
> +			txq->rs_last_id[pkt_rs_idx] =3D tx_last;
>  		}
>=20
>  		if (ts_fns !=3D NULL)
> diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c
> b/drivers/net/intel/cpfl/cpfl_rxtx.c
> index a4d15b7f9c..e7a98ed4f6 100644
> --- a/drivers/net/intel/cpfl/cpfl_rxtx.c
> +++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
> @@ -5,6 +5,7 @@
>  #include <ethdev_driver.h>
>  #include <rte_net.h>
>  #include <rte_vect.h>
> +#include <rte_bitops.h>
>=20
>  #include "cpfl_ethdev.h"
>  #include "cpfl_rxtx.h"
> @@ -330,6 +331,7 @@ cpfl_tx_queue_release(void *txq)
>=20
>  	ci_txq_release_all_mbufs(q, q->vector_tx);
>  	rte_free(q->sw_ring);
> +	rte_free(q->rs_last_id);
>  	rte_memzone_free(q->mz);
>  	rte_free(cpfl_txq);
>  }
> @@ -572,6 +574,7 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>=20
>  	txq->nb_tx_desc =3D nb_desc;
>  	txq->tx_rs_thresh =3D tx_rs_thresh;
> +	txq->log2_rs_thresh =3D rte_log2_u32(tx_rs_thresh);
>  	txq->tx_free_thresh =3D tx_free_thresh;
>  	txq->queue_id =3D vport->chunks_info.tx_start_qid + queue_idx;
>  	txq->port_id =3D dev->data->port_id;
> @@ -605,6 +608,17 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>  		goto err_sw_ring_alloc;
>  	}
>=20
> +	/* Allocate RS last_id tracking array */
> +	uint16_t num_rs_buckets =3D nb_desc / tx_rs_thresh;
> +	txq->rs_last_id =3D rte_zmalloc_socket("cpfl tx rs_last_id",
> +			sizeof(txq->rs_last_id[0]) * num_rs_buckets,
> +			RTE_CACHE_LINE_SIZE, socket_id);
> +	if (txq->rs_last_id =3D=3D NULL) {
> +		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id
> array");
> +		ret =3D -ENOMEM;
> +		goto err_rs_last_id_alloc;
> +	}
> +
>  	if (!is_splitq) {
>  		txq->ci_tx_ring =3D mz->addr;
>  		idpf_qc_single_tx_queue_reset(txq);
> @@ -628,6 +642,8 @@ cpfl_tx_queue_setup(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>  	return 0;
>=20
>  err_complq_setup:
> +	rte_free(txq->rs_last_id);
> +err_rs_last_id_alloc:
>  	rte_free(txq->sw_ring);
>  err_sw_ring_alloc:
>  	cpfl_dma_zone_release(mz);
> diff --git a/drivers/net/intel/i40e/i40e_rxtx.c
> b/drivers/net/intel/i40e/i40e_rxtx.c
> index dfd2213020..b554bc6c31 100644
> --- a/drivers/net/intel/i40e/i40e_rxtx.c
> +++ b/drivers/net/intel/i40e/i40e_rxtx.c
> @@ -24,6 +24,7 @@
>  #include <rte_ip.h>
>  #include <rte_net.h>
>  #include <rte_vect.h>
> +#include <rte_bitops.h>
>=20
>  #include "i40e_logs.h"
>  #include "base/i40e_prototype.h"
> @@ -2280,6 +2281,13 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev =
*dev,
>  			     (int)queue_idx);
>  		return I40E_ERR_PARAM;
>  	}
> +	if (!rte_is_power_of_2(tx_rs_thresh)) {
> +		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2.
> (tx_rs_thresh=3D%u port=3D%d queue=3D%d)",
> +			     (unsigned int)tx_rs_thresh,
> +			     (int)dev->data->port_id,
> +			     (int)queue_idx);
> +		return I40E_ERR_PARAM;
> +	}
>  	if ((tx_rs_thresh > 1) && (tx_conf->tx_thresh.wthresh !=3D 0)) {
>  		PMD_INIT_LOG(ERR, "TX WTHRESH must be set to 0 if "
>  			     "tx_rs_thresh is greater than 1. "
> @@ -2321,6 +2329,7 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  	txq->mz =3D tz;
>  	txq->nb_tx_desc =3D nb_desc;
>  	txq->tx_rs_thresh =3D tx_rs_thresh;
> +	txq->log2_rs_thresh =3D rte_log2_u32(tx_rs_thresh);
>  	txq->tx_free_thresh =3D tx_free_thresh;
>  	txq->queue_id =3D queue_idx;
>  	txq->reg_idx =3D reg_idx;
> @@ -2346,6 +2355,16 @@ i40e_dev_tx_queue_setup(struct rte_eth_dev =
*dev,
>  		return -ENOMEM;
>  	}
>=20
> +	/* Allocate RS last_id tracking array */
> +	uint16_t num_rs_buckets =3D nb_desc / tx_rs_thresh;
> +	txq->rs_last_id =3D rte_zmalloc_socket(NULL, sizeof(txq-
> >rs_last_id[0]) * num_rs_buckets,
> +			RTE_CACHE_LINE_SIZE, socket_id);
> +	if (txq->rs_last_id =3D=3D NULL) {
> +		i40e_tx_queue_release(txq);
> +		PMD_DRV_LOG(ERR, "Failed to allocate memory for RS last_id
> array");
> +		return -ENOMEM;
> +	}
> +
>  	i40e_reset_tx_queue(txq);
>  	txq->q_set =3D TRUE;
>=20
> @@ -2391,6 +2410,7 @@ i40e_tx_queue_release(void *txq)
>=20
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->sw_ring);
> +	rte_free(q->rs_last_id);
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
>  }
> diff --git a/drivers/net/intel/iavf/iavf_rxtx.c
> b/drivers/net/intel/iavf/iavf_rxtx.c
> index 67906841da..d63590d660 100644
> --- a/drivers/net/intel/iavf/iavf_rxtx.c
> +++ b/drivers/net/intel/iavf/iavf_rxtx.c
> @@ -25,6 +25,7 @@
>  #include <rte_ip.h>
>  #include <rte_net.h>
>  #include <rte_vect.h>
> +#include <rte_bitops.h>
>  #include <rte_vxlan.h>
>  #include <rte_gtp.h>
>  #include <rte_geneve.h>
> @@ -194,6 +195,11 @@ check_tx_thresh(uint16_t nb_desc, uint16_t
> tx_rs_thresh,
>  			     tx_rs_thresh, nb_desc);
>  		return -EINVAL;
>  	}
> +	if (!rte_is_power_of_2(tx_rs_thresh)) {
> +		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2.
> (tx_rs_thresh=3D%u)",
> +			     tx_rs_thresh);
> +		return -EINVAL;
> +	}
>=20
>  	return 0;
>  }
> @@ -801,6 +807,7 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>=20
>  	txq->nb_tx_desc =3D nb_desc;
>  	txq->tx_rs_thresh =3D tx_rs_thresh;
> +	txq->log2_rs_thresh =3D rte_log2_u32(tx_rs_thresh);
>  	txq->tx_free_thresh =3D tx_free_thresh;
>  	txq->queue_id =3D queue_idx;
>  	txq->port_id =3D dev->data->port_id;
> @@ -826,6 +833,17 @@ iavf_dev_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>=20
> +	/* Allocate RS last_id tracking array */
> +	uint16_t num_rs_buckets =3D nb_desc / tx_rs_thresh;
> +	txq->rs_last_id =3D rte_zmalloc_socket(NULL, sizeof(txq-
> >rs_last_id[0]) * num_rs_buckets,
> +			RTE_CACHE_LINE_SIZE, socket_id);
> +	if (txq->rs_last_id =3D=3D NULL) {
> +		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id
> array");
> +		rte_free(txq->sw_ring);
> +		rte_free(txq);
> +		return -ENOMEM;
> +	}
> +
>  	/* Allocate TX hardware ring descriptors. */
>  	ring_size =3D sizeof(struct ci_tx_desc) * IAVF_MAX_RING_DESC;
>  	ring_size =3D RTE_ALIGN(ring_size, IAVF_DMA_MEM_ALIGN);
> @@ -1050,6 +1068,7 @@ iavf_dev_tx_queue_release(struct rte_eth_dev
> *dev, uint16_t qid)
>=20
>  	ci_txq_release_all_mbufs(q, q->use_ctx);
>  	rte_free(q->sw_ring);
> +	rte_free(q->rs_last_id);
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
>  }
> diff --git a/drivers/net/intel/ice/ice_rxtx.c
> b/drivers/net/intel/ice/ice_rxtx.c
> index 111cb5e37f..2915223397 100644
> --- a/drivers/net/intel/ice/ice_rxtx.c
> +++ b/drivers/net/intel/ice/ice_rxtx.c
> @@ -5,6 +5,7 @@
>  #include <ethdev_driver.h>
>  #include <rte_net.h>
>  #include <rte_vect.h>
> +#include <rte_bitops.h>
>=20
>  #include "ice_rxtx.h"
>  #include "ice_rxtx_vec_common.h"
> @@ -1589,6 +1590,13 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  			     (int)queue_idx);
>  		return -EINVAL;
>  	}
> +	if (!rte_is_power_of_2(tx_rs_thresh)) {
> +		PMD_INIT_LOG(ERR, "tx_rs_thresh must be a power of 2.
> (tx_rs_thresh=3D%u port=3D%d queue=3D%d)",
> +			     (unsigned int)tx_rs_thresh,
> +			     (int)dev->data->port_id,
> +			     (int)queue_idx);
> +		return -EINVAL;
> +	}
>  	if (tx_rs_thresh > 1 && tx_conf->tx_thresh.wthresh !=3D 0) {
>  		PMD_INIT_LOG(ERR, "TX WTHRESH must be set to 0 if "
>  			     "tx_rs_thresh is greater than 1. "
> @@ -1631,6 +1639,7 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  	txq->mz =3D tz;
>  	txq->nb_tx_desc =3D nb_desc;
>  	txq->tx_rs_thresh =3D tx_rs_thresh;
> +	txq->log2_rs_thresh =3D rte_log2_u32(tx_rs_thresh);
>  	txq->tx_free_thresh =3D tx_free_thresh;
>  	txq->queue_id =3D queue_idx;
>=20
> @@ -1657,6 +1666,16 @@ ice_tx_queue_setup(struct rte_eth_dev *dev,
>  		return -ENOMEM;
>  	}
>=20
> +	/* Allocate RS last_id tracking array */
> +	uint16_t num_rs_buckets =3D nb_desc / tx_rs_thresh;
> +	txq->rs_last_id =3D rte_zmalloc_socket(NULL, sizeof(txq-
> >rs_last_id[0]) * num_rs_buckets,
> +			RTE_CACHE_LINE_SIZE, socket_id);
> +	if (txq->rs_last_id =3D=3D NULL) {
> +		ice_tx_queue_release(txq);
> +		PMD_INIT_LOG(ERR, "Failed to allocate memory for RS last_id
> array");
> +		return -ENOMEM;
> +	}
> +
>  	if (vsi->type =3D=3D ICE_VSI_PF && (offloads &
> RTE_ETH_TX_OFFLOAD_SEND_ON_TIMESTAMP)) {
>  		if (hw->phy_model !=3D ICE_PHY_E830) {
>  			ice_tx_queue_release(txq);
> @@ -1729,6 +1748,7 @@ ice_tx_queue_release(void *txq)
>=20
>  	ci_txq_release_all_mbufs(q, false);
>  	rte_free(q->sw_ring);
> +	rte_free(q->rs_last_id);
>  	if (q->tsq) {
>  		rte_memzone_free(q->tsq->ts_mz);
>  		rte_free(q->tsq);
> diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c
> b/drivers/net/intel/idpf/idpf_common_rxtx.c
> index 77f4099f2b..04db8823eb 100644
> --- a/drivers/net/intel/idpf/idpf_common_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
> @@ -5,6 +5,7 @@
>  #include <eal_export.h>
>  #include <rte_mbuf_dyn.h>
>  #include <rte_errno.h>
> +#include <rte_bitops.h>
>=20
>  #include "idpf_common_rxtx.h"
>  #include "idpf_common_device.h"
> @@ -73,6 +74,11 @@ idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t
> tx_rs_thresh,
>  			tx_rs_thresh, nb_desc);
>  		return -EINVAL;
>  	}
> +	if (!rte_is_power_of_2(tx_rs_thresh)) {
> +		DRV_LOG(ERR, "tx_rs_thresh must be a power of 2.
> (tx_rs_thresh=3D%u)",
> +			tx_rs_thresh);
> +		return -EINVAL;
> +	}
>=20
>  	return 0;
>  }
> @@ -333,6 +339,7 @@ idpf_qc_tx_queue_release(void *txq)
>  	}
>=20
>  	ci_txq_release_all_mbufs(q, false);
> +	rte_free(q->rs_last_id);
>  	rte_free(q->sw_ring);
>  	rte_memzone_free(q->mz);
>  	rte_free(q);
> diff --git a/drivers/net/intel/idpf/idpf_rxtx.c
> b/drivers/net/intel/idpf/idpf_rxtx.c
> index 7d9c885458..9420200f6d 100644
> --- a/drivers/net/intel/idpf/idpf_rxtx.c
> +++ b/drivers/net/intel/idpf/idpf_rxtx.c
> @@ -447,6 +447,7 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>=20
>  	txq->nb_tx_desc =3D nb_desc;
>  	txq->tx_rs_thresh =3D tx_rs_thresh;
> +	txq->log2_rs_thresh =3D rte_log2_u32(tx_rs_thresh);
>  	txq->tx_free_thresh =3D tx_free_thresh;
>  	txq->queue_id =3D vport->chunks_info.tx_start_qid + queue_idx;
>  	txq->port_id =3D dev->data->port_id;
> @@ -480,6 +481,15 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>  		goto err_sw_ring_alloc;
>  	}
>=20
> +	txq->rs_last_id =3D rte_zmalloc_socket("idpf tx rs_last_id",
> +			sizeof(txq->rs_last_id[0]) * (nb_desc >> txq-
> >log2_rs_thresh),
> +			RTE_CACHE_LINE_SIZE, socket_id);
> +	if (txq->rs_last_id =3D=3D NULL) {
> +		PMD_INIT_LOG(ERR, "Failed to allocate memory for TX RS
> tracking");
> +		ret =3D -ENOMEM;
> +		goto err_rs_last_id_alloc;
> +	}
> +
>  	if (!is_splitq) {
>  		txq->ci_tx_ring =3D mz->addr;
>  		idpf_qc_single_tx_queue_reset(txq);
> @@ -502,6 +512,8 @@ idpf_tx_queue_setup(struct rte_eth_dev *dev,
> uint16_t queue_idx,
>  	return 0;
>=20
>  err_complq_setup:
> +	rte_free(txq->rs_last_id);
> +err_rs_last_id_alloc:
>  	rte_free(txq->sw_ring);
>  err_sw_ring_alloc:
>  	idpf_dma_zone_release(mz);
> --
> 2.51.0

