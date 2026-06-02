Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F7CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:51:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7491B406B8;
	Tue,  2 Jun 2026 23:50:52 +0200 (CEST)
Received: from fhigh-b1-smtp.messagingengine.com
 (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
 by mails.dpdk.org (Postfix) with ESMTP id 57012406B8
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:50:51 +0200 (CEST)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9E05A7A006C;
 Tue,  2 Jun 2026 17:50:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Tue, 02 Jun 2026 17:50:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437050; x=
 1780523450; bh=9gbrEGrqu7MPbY6p72Vxtokq9nNGxUd3APac1dDWrcA=; b=j
 shSxrM4QlLwxaCcInjOndlAxKy8Sz/C/GKhuUHm6KH/1RfQeawpAYp7BO+zmsbpf
 yAWxZXBvzt5l+EqOqDEhLKXAn3mr/kPHNQK0nwCwxtuVJOPrqy311n4YLVLuc0aG
 sy2RxD9Ad4V2J9lHv/9Dxl1PVlyWdp1gg447a7p9wntr1kQnBTLuYmc4vvEf2Fp7
 46djzumrJGN0LTOpGb5Cavd772la42xAZGLRvA7IaOuA9dCNQGoou/NZgQkMfTnL
 FymHFGulbSEvHUxHiCMjpgoJUZxJccZ62/A/E27ZSHNebt0h3I84+cqWVK2zif2D
 yklZuEH0Y5UyZ44J1E1uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437050; x=1780523450; bh=9
 gbrEGrqu7MPbY6p72Vxtokq9nNGxUd3APac1dDWrcA=; b=UEkG7o/bT9qCiljaK
 Hl10cSqTLdOE5BAaVPn7tkU1Fh0dR4q2N4Rlq+vPzpvitDfS+o0o4QqpzdYG3dLb
 b6DSUt0trmjP6nr0iX66+StS3C6iqsBw8czw1qC1D59j2Vvq6UNyTjN5SWhQa0Yd
 W7+VoB7bHl5dfVlmDdVJcZltptvCvVPwzuuSBiPOXw5CBbdmLPUMmrdI6idCVnf1
 9NSw0IGbQdUWOIXcVEfNz5LLgfxrnVpYPVgrPifH048yGUYnqzQtXklKNVhfkqcA
 qne0smooFBRm8bsb5nTo51hltFBSgTYkWiW0cF6lbXy4854Fx11PkYR+/MeuKg3S
 SN2mg==
X-ME-Sender: <xms:OlAfaoTNJPusfbk8MWdmglB-hGAXDzFhffJTG7UtapUOV8eAiMP69w>
 <xme:OlAfav14TT-2xVY-Xl3Jjt5m1GO4RA2do8MRSC95fRRAulTeAapvGC8LZYd8mRqMv
 ByCVYsZq61FcoPNZyQXheO1GE38RikCHTe3puPPB-NMmim26SV2aw>
X-ME-Received: <xmr:OlAfalstxvEukSNpaoFpqHKj1_J_unPswVxNnRfi15jZhIsHlJR_gwujEWFTIB2e6fX8cCibTR-GSiGXIbvaeNH2Zwges5c>
X-ME-Proxy-Cause: dmFkZTEKaC632oHj5ecumL/3NkutYbElBH+Ytvs1Z1w6t24wNLIxPbcTkWRDWlz1jPWl1A
 KqcuDF11qY8uH74ZTIIvZhx6vHfq/CfxXR74uC4G6PQmPvhgxoaRyMIF4JwjDvEEVc1HeV
 +2igkiWfn1n9lnOELkLU9kFNhV/ohiNjAlf+v1qPFr14Gr0fYxtwrFoz/xRSBYKDHo4UJb
 UVbItIDuvw+LzLolXPJEi088GbU6gN6w/lL/GQ2uOAicgThCRf6j0gDRu3DJoc/Bht7DhN
 1LJEELpOiaQLqT1YHQbzqFRObY37kzUiYVSg8SqkYTdpdSXq5M/nmnMQcfT1SEiGEerJJJ
 +3yluazP8RZNGU2nri+D88qC2d1MZUUr1CDJ2ee3mAQU3wE4AK4gtyBPC/5ZuNqL3+cDX5
 CxnAIQRqvO/dKi8y1wdKVAH4GIj3y2cLgtTAJeuJhNa89NAWuCP4ak8cRDj/ymXZTH3uOm
 ZFDQzjVZEcFhYK6zY7rV5UmyX69LM36qVPgDQ/n2yajFNqWovuKL8wMalhvtYo9LLeFDsP
 DZiCOZz8VYQPqnVT3RXgVzCWNL/O0/pEqd9ODnGLpgGpvi/JU1KM822RB0V0CeUkqA0GKl
 uxSMGK8sv7lp+sx+BO7wXAdvbwIgc0NHHrtWGnxUCynOGEEg0HME6SzH4wmA
X-ME-Proxy: <xmx:OlAfatgMbkZhnbxYSeC7_2NNNVh-L0jWCRVMHXgjpcBKkiNAe2ZvUQ>
 <xmx:OlAfau9FEpewb5aR1JqpxRcR9Wf86wI-OVxzobVvh7ZWh9mJFzhFWg>
 <xmx:OlAfaoue2exEWj_ZbJhCyvj9_sWerToZP0T6x8EAQsGxwlHZBvQ5IQ>
 <xmx:OlAfaqrxezc3N0IMmF1dJeUUQr7OBeoIRjiQpseDJIWthI4DdJLdhg>
 <xmx:OlAfagD7I9quY-ubEvD6FtbbegyiOysnYJRix4Bn9hkAzuIetGdEoX15>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:49 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v6 07/10] net/mlx5: reindent previous changes
Date: Tue,  2 Jun 2026 23:49:19 +0200
Message-ID: <20260602215022.3698662-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fix indent which was left untouched to help reviews.
This must be squashed before merging.

Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 drivers/net/mlx5/mlx5_rx.c      | 162 ++++++++++++++++----------------
 drivers/net/mlx5/mlx5_rxq.c     |  32 +++----
 drivers/net/mlx5/mlx5_trigger.c |  18 ++--
 3 files changed, 105 insertions(+), 107 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 6aeab8d423..b8c3b27db6 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1071,106 +1071,106 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		rte_prefetch0(cqe);
 		rte_prefetch0(wqe);
 		if (seg->pool) {
-		/* Allocate the buf from the same pool. */
-		rep = rte_mbuf_raw_alloc(seg->pool);
-		if (unlikely(rep == NULL)) {
-			++rxq->stats.rx_nombuf;
-			if (!pkt) {
-				/*
-				 * no buffers before we even started,
-				 * bail out silently.
-				 */
-				break;
-			}
-			while (pkt != seg) {
-				MLX5_ASSERT(pkt != (*rxq->elts)[idx]);
-				rep = NEXT(pkt);
-				NEXT(pkt) = NULL;
-				NB_SEGS(pkt) = 1;
-				rte_mbuf_raw_free(pkt);
-				pkt = rep;
-			}
-			rq_ci >>= sges_n;
-			++rq_ci;
-			rq_ci <<= sges_n;
-			break;
-		}
-		}
-		if (!pkt) {
-		if (len == 0) { /* no CQE polled yet */
-			cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
-			len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
-					       &mcqe, &skip_cnt, false, NULL);
-			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
-				/* We drop packets with non-critical errors */
-				if (seg->pool)
-				rte_mbuf_raw_free(rep);
-				if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
-					rq_ci = rxq->rq_ci << sges_n;
+			/* Allocate the buf from the same pool. */
+			rep = rte_mbuf_raw_alloc(seg->pool);
+			if (unlikely(rep == NULL)) {
+				++rxq->stats.rx_nombuf;
+				if (!pkt) {
+					/*
+					 * no buffers before we even started,
+					 * bail out silently.
+					 */
 					break;
 				}
-				/* Skip specified amount of error CQEs packets */
+				while (pkt != seg) {
+					MLX5_ASSERT(pkt != (*rxq->elts)[idx]);
+					rep = NEXT(pkt);
+					NEXT(pkt) = NULL;
+					NB_SEGS(pkt) = 1;
+					rte_mbuf_raw_free(pkt);
+					pkt = rep;
+				}
 				rq_ci >>= sges_n;
-				rq_ci += skip_cnt;
+				++rq_ci;
 				rq_ci <<= sges_n;
-				MLX5_ASSERT(!pkt);
-				continue;
-			}
-			if (len == 0) {
-				if (seg->pool)
-				rte_mbuf_raw_free(rep);
 				break;
 			}
-			MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
-			if (rxq->crc_present)
-				len -= RTE_ETHER_CRC_LEN;
 		}
-		if (seg->pool) { /* first real segment */
-			pkt = seg;
-			tail = seg;
-			pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
-			if (rxq->cqe_comp_layout && mcqe)
-				cqe = &rxq->title_cqe;
-			rxq_cq_to_mbuf(rxq, pkt, cqe, mcqe);
-			PKT_LEN(pkt) = len;
-			if (cqe->lro_num_seg > 1) {
-				mlx5_lro_update_hdr
-					(rte_pktmbuf_mtod(pkt, uint8_t *), cqe,
-					 mcqe, rxq, len);
-				pkt->ol_flags |= RTE_MBUF_F_RX_LRO;
-				pkt->tso_segsz = len / cqe->lro_num_seg;
+		if (!pkt) { /* new packet */
+			if (len == 0) { /* no CQE polled yet */
+				cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
+				len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
+							   &mcqe, &skip_cnt, false, NULL);
+				if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
+					/* We drop packets with non-critical errors */
+					if (seg->pool)
+						rte_mbuf_raw_free(rep);
+					if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
+						rq_ci = rxq->rq_ci << sges_n;
+						break;
+					}
+					/* Skip specified amount of error CQEs packets */
+					rq_ci >>= sges_n;
+					rq_ci += skip_cnt;
+					rq_ci <<= sges_n;
+					MLX5_ASSERT(!pkt);
+					continue;
+				}
+				if (len == 0) {
+					if (seg->pool)
+						rte_mbuf_raw_free(rep);
+					break;
+				}
+				MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
+				if (rxq->crc_present)
+					len -= RTE_ETHER_CRC_LEN;
+			}
+			if (seg->pool) { /* first real segment */
+				pkt = seg;
+				tail = seg;
+				pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
+				if (rxq->cqe_comp_layout && mcqe)
+					cqe = &rxq->title_cqe;
+				rxq_cq_to_mbuf(rxq, pkt, cqe, mcqe);
+				PKT_LEN(pkt) = len;
+				if (cqe->lro_num_seg > 1) {
+					mlx5_lro_update_hdr
+						(rte_pktmbuf_mtod(pkt, uint8_t *), cqe,
+						 mcqe, rxq, len);
+					pkt->ol_flags |= RTE_MBUF_F_RX_LRO;
+					pkt->tso_segsz = len / cqe->lro_num_seg;
+				}
 			}
-		}
 		}
 		if (seg->pool) { /* real segment: replenish WQE */
-		tail = seg;
-		DATA_LEN(rep) = DATA_LEN(seg);
-		PKT_LEN(rep) = PKT_LEN(seg);
-		SET_DATA_OFF(rep, DATA_OFF(seg));
-		PORT(rep) = PORT(seg);
-		(*rxq->elts)[idx] = rep;
-		/*
-		 * Fill NIC descriptor with the new buffer. The lkey and size
-		 * of the buffers are already known, only the buffer address
-		 * changes.
-		 */
-		wqe->addr = rte_cpu_to_be_64(rte_pktmbuf_mtod(rep, uintptr_t));
-		/* If there's only one MR, no need to replace LKey in WQE. */
-		if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1))
-			wqe->lkey = mlx5_rx_mb2mr(rxq, rep);
+			tail = seg;
+			DATA_LEN(rep) = DATA_LEN(seg);
+			PKT_LEN(rep) = PKT_LEN(seg);
+			SET_DATA_OFF(rep, DATA_OFF(seg));
+			PORT(rep) = PORT(seg);
+			(*rxq->elts)[idx] = rep;
+			/*
+			 * Fill NIC descriptor with the new buffer. The lkey and size
+			 * of the buffers are already known, only the buffer address
+			 * changes.
+			 */
+			wqe->addr = rte_cpu_to_be_64(rte_pktmbuf_mtod(rep, uintptr_t));
+			/* If there's only one MR, no need to replace LKey in WQE. */
+			if (unlikely(mlx5_mr_btree_len(&rxq->mr_ctrl.cache_bh) > 1))
+				wqe->lkey = mlx5_rx_mb2mr(rxq, rep);
 		}
-		if (len > DATA_LEN(seg)) {
+		if (len > DATA_LEN(seg)) { /* more data: move to next segment */
 			if (seg->pool)
 				data_seg_len += DATA_LEN(seg);
 			len -= DATA_LEN(seg);
 			if (pkt)
-			++NB_SEGS(pkt);
+				++NB_SEGS(pkt);
 			++rq_ci;
 			continue;
 		}
 		if (seg->pool) { /* last segment */
-		DATA_LEN(seg) = len;
-		data_seg_len += len;
+			DATA_LEN(seg) = len;
+			data_seg_len += len;
 		}
 		if (unlikely(!pkt)) { /* no real segment found, skip packet */
 			len = 0;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 3fae189fa4..6ca29f7543 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -152,22 +152,22 @@ rxq_alloc_elts_sprq(struct mlx5_rxq_ctrl *rxq_ctrl)
 		struct rte_mbuf *buf;
 
 		if (seg->mp) {
-		buf = rte_pktmbuf_alloc(seg->mp);
-		if (buf == NULL) {
-			if (rxq_ctrl->share_group == 0)
-				DRV_LOG(ERR, "port %u queue %u empty mbuf pool",
-					RXQ_PORT_ID(rxq_ctrl),
-					rxq_ctrl->rxq.idx);
-			else
-				DRV_LOG(ERR, "share group %u queue %u empty mbuf pool",
-					rxq_ctrl->share_group,
-					rxq_ctrl->share_qid);
-			rte_errno = ENOMEM;
-			goto error;
-		}
-		/* Only vectored Rx routines rely on headroom size. */
-		MLX5_ASSERT(!has_vec_support ||
-			    DATA_OFF(buf) >= RTE_PKTMBUF_HEADROOM);
+			buf = rte_pktmbuf_alloc(seg->mp);
+			if (buf == NULL) {
+				if (rxq_ctrl->share_group == 0)
+					DRV_LOG(ERR, "port %u queue %u empty mbuf pool",
+						RXQ_PORT_ID(rxq_ctrl),
+						rxq_ctrl->rxq.idx);
+				else
+					DRV_LOG(ERR, "share group %u queue %u empty mbuf pool",
+						rxq_ctrl->share_group,
+						rxq_ctrl->share_qid);
+				rte_errno = ENOMEM;
+				goto error;
+			}
+			/* Only vectored Rx routines rely on headroom size. */
+			MLX5_ASSERT(!has_vec_support ||
+				    DATA_OFF(buf) >= RTE_PKTMBUF_HEADROOM);
 		} else {
 			buf = seg->null_mbuf;
 		}
diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 5b04d9a234..ac966c51b4 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -164,16 +164,14 @@ mlx5_rxq_mempool_register(struct mlx5_rxq_ctrl *rxq_ctrl)
 		seg = &rxq_ctrl->rxq.rxseg[s];
 		mp = seg->mp;
 		if (mp) { /* Regular segment */
-		bool is_extmem = (rte_pktmbuf_priv_flags(mp) &
-			     RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) != 0;
-		ret = mlx5_mr_mempool_register(rxq_ctrl->sh->cdev, mp,
-					       is_extmem);
-		if (ret < 0 && rte_errno != EEXIST)
-			goto error;
-		ret = mlx5_mr_mempool_populate_cache(&rxq_ctrl->rxq.mr_ctrl,
-						     mp);
-		if (ret < 0)
-			goto error;
+			bool is_extmem = (rte_pktmbuf_priv_flags(mp) &
+					RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF) != 0;
+			ret = mlx5_mr_mempool_register(rxq_ctrl->sh->cdev, mp, is_extmem);
+			if (ret < 0 && rte_errno != EEXIST)
+				goto error;
+			ret = mlx5_mr_mempool_populate_cache(&rxq_ctrl->rxq.mr_ctrl, mp);
+			if (ret < 0)
+				goto error;
 		} else { /* NULL segment used in selective Rx */
 			seg->null_mbuf = mlx5_alloc_null_mbuf(seg->length);
 			if (seg->null_mbuf == NULL) {
-- 
2.54.0

