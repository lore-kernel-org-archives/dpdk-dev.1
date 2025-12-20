Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E4DE6689E
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Dec 2025 08:43:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25B0240276;
	Sat, 20 Dec 2025 09:43:52 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 7CD994026A
 for <dev@dpdk.org>; Sat, 20 Dec 2025 09:43:50 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AAF1D22B35;
 Sat, 20 Dec 2025 09:43:49 +0100 (CET)
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: RE: [RFC PATCH 20/27] net/intel: write descriptors using non-volatile
 pointers
Date: Sat, 20 Dec 2025 09:43:46 +0100
Message-ID: <98CBD80474FA8B44BF855DF32C47DC35F65602@smartserver.smartshare.dk>
X-MimeOLE: Produced By Microsoft Exchange V6.5
In-Reply-To: <20251219172548.2660777-21-bruce.richardson@intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC PATCH 20/27] net/intel: write descriptors using
 non-volatile pointers
Thread-Index: AdxxDOOKirC2XkWkS7+cOCtmYLBMZAAfha0w
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20251219172548.2660777-21-bruce.richardson@intel.com>
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
> Sent: Friday, 19 December 2025 18.26
>=20
> Use a non-volatile uint64_t pointer to store to the descriptor ring.
> This will allow the compiler to optionally merge the stores as it sees
> best.

I suppose there was a reason for the volatile.
Is removing it really safe?
E.g. this will also allow the compiler to reorder stores; not just the =
pair of 64-bits, but also stores to multiple descriptors.

One more comment inline below.

>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  drivers/net/intel/common/tx_scalar_fns.h | 24 =
++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/intel/common/tx_scalar_fns.h
> b/drivers/net/intel/common/tx_scalar_fns.h
> index 7b643fcf44..95e9acbe60 100644
> --- a/drivers/net/intel/common/tx_scalar_fns.h
> +++ b/drivers/net/intel/common/tx_scalar_fns.h
> @@ -184,6 +184,15 @@ struct ci_timesstamp_queue_fns {
>  	write_ts_tail_t write_ts_tail;
>  };
>=20
> +static inline void
> +write_txd(volatile void *txd, uint64_t qw0, uint64_t qw1)
> +{
> +	uint64_t *txd_qw =3D RTE_CAST_PTR(void *, txd);

If the descriptors are 16-byte aligned, you could mark them as such, so =
the compiler can use 128-bit stores on architectures where alignment =
matters.

> +
> +	txd_qw[0] =3D rte_cpu_to_le_64(qw0);
> +	txd_qw[1] =3D rte_cpu_to_le_64(qw1);
> +}
> +
>  static inline uint16_t
>  ci_xmit_pkts(struct ci_tx_queue *txq,
>  	     struct rte_mbuf **tx_pkts,
> @@ -313,8 +322,7 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  				txe->mbuf =3D NULL;
>  			}
>=20
> -			ctx_txd[0] =3D cd_qw0;
> -			ctx_txd[1] =3D cd_qw1;
> +			write_txd(ctx_txd, cd_qw0, cd_qw1);
>=20
>  			txe->last_id =3D tx_last;
>  			tx_id =3D txe->next_id;
> @@ -361,12 +369,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>=20
>  			while ((ol_flags & (RTE_MBUF_F_TX_TCP_SEG |
> RTE_MBUF_F_TX_UDP_SEG)) &&
>  					unlikely(slen > CI_MAX_DATA_PER_TXD)) {
> -				txd->buffer_addr =3D
> rte_cpu_to_le_64(buf_dma_addr);
> -				txd->cmd_type_offset_bsz =3D
> rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
> +				const uint64_t cmd_type_offset_bsz =3D
> CI_TX_DESC_DTYPE_DATA |
>  					((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
>  					((uint64_t)td_offset <<
> CI_TXD_QW1_OFFSET_S) |
>  					((uint64_t)CI_MAX_DATA_PER_TXD <<
> CI_TXD_QW1_TX_BUF_SZ_S) |
> -					((uint64_t)td_tag <<
> CI_TXD_QW1_L2TAG1_S));
> +					((uint64_t)td_tag <<
> CI_TXD_QW1_L2TAG1_S);
> +				write_txd(txd, buf_dma_addr,
> cmd_type_offset_bsz);
>=20
>  				buf_dma_addr +=3D CI_MAX_DATA_PER_TXD;
>  				slen -=3D CI_MAX_DATA_PER_TXD;
> @@ -382,12 +390,12 @@ ci_xmit_pkts(struct ci_tx_queue *txq,
>  			if (m_seg->next =3D=3D NULL)
>  				td_cmd |=3D CI_TX_DESC_CMD_EOP;
>=20
> -			txd->buffer_addr =3D rte_cpu_to_le_64(buf_dma_addr);
> -			txd->cmd_type_offset_bsz =3D
> rte_cpu_to_le_64(CI_TX_DESC_DTYPE_DATA |
> +			const uint64_t cmd_type_offset_bsz =3D
> CI_TX_DESC_DTYPE_DATA |
>  				((uint64_t)td_cmd << CI_TXD_QW1_CMD_S) |
>  				((uint64_t)td_offset << CI_TXD_QW1_OFFSET_S) |
>  				((uint64_t)slen << CI_TXD_QW1_TX_BUF_SZ_S) |
> -				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S));
> +				((uint64_t)td_tag << CI_TXD_QW1_L2TAG1_S);
> +			write_txd(txd, buf_dma_addr, cmd_type_offset_bsz);
>=20
>  			txe->last_id =3D tx_last;
>  			tx_id =3D txe->next_id;
> --
> 2.51.0

