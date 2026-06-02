Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FB6CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:41:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1CB13402A9;
	Tue,  2 Jun 2026 23:41:04 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id E39DB40693
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:41:01 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 449C71D00094;
 Tue,  2 Jun 2026 17:41:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Tue, 02 Jun 2026 17:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780436461; x=
 1780522861; bh=JdcG/Vi6DobGlQ8iocjs/bd1AI1oF/VBymxSRybgtt4=; b=F
 AqVs2eQChylBArzOWn0iPpmpKp5wAHnQBeN8NvLj3l2i5hJX07AmZVI7/T5Ij/UC
 U/sKxnN52qpXaPuB+ZuYkqWmG3WIn5TOAY8M7EOJgIdPFDTVU/bc2hAmsjZir28o
 4Tp43EYDYvU0mHj9qiWLeEKIbOUowNiKWY4OCroP8fqTCPp8cowILvGBCupdeRJa
 D3ahIfgFjrC7HJjFRGQzHJB5zguHcs3qq6X6EVlrA8leotf/js1SscapGsL+bTTi
 Yx5URutd3PGxk12X2mEnynhPvyN58NGqnRwxAmf/mYiJ0E0eua+g00OyrW+O/Xmx
 nMjX4HLF386e/O+5ssSVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780436461; x=1780522861; bh=J
 dcG/Vi6DobGlQ8iocjs/bd1AI1oF/VBymxSRybgtt4=; b=NGJubucl75DKF61hs
 Ff82HnBaLMfrAiaC+bm9CDa3go1mLUGa++S64ANlOS8bqTQWIGTlxJzsJkLR3dOl
 wHEJS1Poto0/GBWV/UTCMbwTV/vUcRiJxhpZ4S49UzIJdWvgocbW9+7wydxN3DOe
 6bRfFtgQO2rDglEAKtaAsBmpsIbg25tSRhzCAX3dJPcYnRni/BzPiAQXcDBsgIWl
 me4EUpHVo6cf5krOWPOWTAI2MAX9DS/kuj2EZfGTRZHv6ligMOeJVnEmX4F5EmFt
 sDzzmNX+qdPiWSiqMNO7Cog3MtCDfhx/qYeo5zybtt9uM2vBdD+DxedFC/43+4um
 +4erQ==
X-ME-Sender: <xms:7E0farIHHazpGDEINkboZ78-5vsT8BWh13CLaIEW0ATvf0rDKcdF2Q>
 <xme:7E0fapOSqyNTUMH-P-2B81NP21fdTlIqQat4UymBXWKohQs-LNl-PRrypsHjW5ohi
 o-RHjnRjXiKfTVPmPTwhmzriPGuAeU2djhLqLZ9mb1MC7KJfPT0zA>
X-ME-Received: <xmr:7E0fajnWG2PMsTgiCUJI4DHo67ST_NNfJCh6g1NpiwbgLl2JFfWOy_gw87vfZJ2n241iOm2mtYchVoP8dHWwjofRPMBaIOg>
X-ME-Proxy-Cause: dmFkZTEZvAtrAknme6TDFs7EtvDfmt64yNDUy8Th+F0b8iQSypP0NM2jkrzQu+XDpm1mw3
 75D+//cxXeIREuxnuqGIzk9cVgfaZQnl7GTgCCHRPbs2//LcPUHip0yPtLk8N3FiYsKE2b
 Jw/YnQXiMeqqteyIiXEI+uTt2AwTnxLrsphbl09lLXiiVqAUX/KbWzib3jn6/9OSlSrmuw
 oBe5hHPO58N6GrcXS2vaH3T9AKIEjsOEw3gNO+AU297KcIt4X+48CbV4C+FGAKPnH8jiHf
 s7iNlFO9pgWA9yIxpea97cXW00Lhg8ux4RL48tfPn5IHEDJric2/C6eZw8CJga844dsgUr
 C4o+T1LWrvr7+8LIUlPtlZPkZmhyeoCc2GNbJBkX/Oz8m8ni2Y6+uYmWxqGj0NloeG4Z2b
 FRlvsn/nxENRM7H5xPPvbjl4V7efmGPAbsLZ1vsgiCaaQ+wR+1ysyXCYfu4w55uGdrCouh
 qrizo1ZMn/a2hUF3OBnIRzMitBi5PyJs+Z8aDSfvZgju4K1XS7PbNSZKyv69xhMBC5cxG3
 DMecd+nL/Vu7jhezBvxRZzJM/UugUJ6UieS3+YqtYZjIiGpDAvA6Fn0Fou8tTeB8VWQDtY
 2hnHr68Db4zE8BNy8/BJJ1JWeuElsCySlh+achRL/ExQPtEmpt8boY1XA92A
X-ME-Proxy: <xmx:7E0fal5nRq5afywXe7Ift2cdfNfGTTLrnYuQCGpHmlkV13BQCNRdZQ>
 <xmx:7E0fav00DdexOQH46ITom-zvMUnSrRCad87Z9IFs3SUo3KcysZimew>
 <xmx:7E0faoH7XyL5m9vnCWaQWwmsj_-W-enz6AypmoSI3qgsgs1DGTNU-A>
 <xmx:7E0famiK_r_q6Cks0vasH8hRYbSFXVA8mXQdB-X_Nnlmson683upiQ>
 <xmx:7U0fap5vQXTJOlVc-urBS0ZeQaeSeJKS2I6bGCRjpkvNt4O3zI8kxzK8>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:40:59 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v5 07/10] net/mlx5: reindent previous changes
Date: Tue,  2 Jun 2026 23:38:38 +0200
Message-ID: <20260602214036.3606359-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602214036.3606359-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602214036.3606359-1-thomas@monjalon.net>
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
 drivers/net/mlx5/mlx5_rx.c      | 88 ++++++++++++++++-----------------
 drivers/net/mlx5/mlx5_rxq.c     | 32 ++++++------
 drivers/net/mlx5/mlx5_trigger.c | 18 +++----
 3 files changed, 68 insertions(+), 70 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 6aeab8d423..a9a01d7c93 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1071,32 +1071,32 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
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
+			/* Allocate the buf from the same pool. */
+			rep = rte_mbuf_raw_alloc(seg->pool);
+			if (unlikely(rep == NULL)) {
+				++rxq->stats.rx_nombuf;
+				if (!pkt) {
+					/*
+					 * no buffers before we even started,
+					 * bail out silently.
+					 */
+					break;
+				}
+				while (pkt != seg) {
+					MLX5_ASSERT(pkt != (*rxq->elts)[idx]);
+					rep = NEXT(pkt);
+					NEXT(pkt) = NULL;
+					NB_SEGS(pkt) = 1;
+					rte_mbuf_raw_free(pkt);
+					pkt = rep;
+				}
+				rq_ci >>= sges_n;
+				++rq_ci;
+				rq_ci <<= sges_n;
 				break;
 			}
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
 		}
-		}
-		if (!pkt) {
+		if (!pkt) { /* new packet */
 		if (len == 0) { /* no CQE polled yet */
 			cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
 			len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
@@ -1104,7 +1104,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
 				/* We drop packets with non-critical errors */
 				if (seg->pool)
-				rte_mbuf_raw_free(rep);
+					rte_mbuf_raw_free(rep);
 				if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
 					rq_ci = rxq->rq_ci << sges_n;
 					break;
@@ -1118,7 +1118,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			}
 			if (len == 0) {
 				if (seg->pool)
-				rte_mbuf_raw_free(rep);
+					rte_mbuf_raw_free(rep);
 				break;
 			}
 			MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
@@ -1143,34 +1143,34 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		}
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

