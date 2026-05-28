Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39ADCD6E44
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:48:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A523B4066F;
	Thu, 28 May 2026 14:48:27 +0200 (CEST)
Received: from fout-a6-smtp.messagingengine.com
 (fout-a6-smtp.messagingengine.com [103.168.172.149])
 by mails.dpdk.org (Postfix) with ESMTP id 8FCAA4066E
 for <dev@dpdk.org>; Thu, 28 May 2026 14:48:25 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 44882EC0141;
 Thu, 28 May 2026 08:48:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Thu, 28 May 2026 08:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972505; x=
 1780058905; bh=RR9xRz3sIWpN15Nf73fc8lK0+/q+5xdOrJ9Sc7D2KOc=; b=Z
 TYcAMNoToyPwo7PZaubndAPzZOF0aVA9su6qo0ZM2CV7DzxVMJMijR3wX4Uqlvk2
 gPQ2bTl7wadEoqTREkDFUb6h1cLgQeoFZxG70hikfr2u5XoKHYZ91Fzm6uhcgs+1
 Xqbm2tcMHyD1ri1bSomMxBOTqDUCyjp4+6uDbKvYmvjzB3rMuFM6CUBptX2wl2Qi
 ia2q9ARHq9VnbAz5S4yugDTdIb5l2zMWOBZEkIvu7Mwwc9v2PwwzahRMyRTPyAaH
 VMxhreD3UQ92bcAqfErksak4gShxwD60JmIG0xYXqYXQ2s0tZjecxRnJLLcJUi3b
 Cvnmu19ZwffRLgHBNO8Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972505; x=1780058905; bh=R
 R9xRz3sIWpN15Nf73fc8lK0+/q+5xdOrJ9Sc7D2KOc=; b=FDeRot1QHgXjxsXW+
 YH8gosh40cAYm39rEwX6mTfsb3OvOiCrmTxqjRMu5n0Mh7NJ8W8uwXow0v+04DAu
 UWOyITGOLAsonhhKzQYSt31Fz8wy67M2c0vniMCCl9kNtUopaBsECwlyvMP6bhAi
 89CvnBReDZwPqBkMfLXrMF3LOW3hF1fAHW4XF++H279FtN3Q6m2YemoUwSpNB/Oj
 +j7o+jpFUhNcocz11jbi2fOUvKGBsL6sY6cbb5h6BcfHq6pW+3v8j6e6vSUEXhIu
 /4vcTZfXIunBhjRTgOxulfbAR+DCoKzIVHFqudjcdBTFxMZCJk7/R8kJgEUD667q
 /m6yA==
X-ME-Sender: <xms:mTkYapLAop20ly2VU5T-1wjiZmVNKx-6fP1HRJuqUzILobNw-G9c-w>
 <xme:mTkYavOJNMztdHrFfn6EjIUdxn9obatYuPhqAJaY5B-g8s1cwiwgYg7NlaTOyzPn8
 K7SgfFGqHMGvjieCjHKxCk72QJr0NfG-gNSQBrK9vOVEg5Vdg>
X-ME-Received: <xmr:mTkYahlqLYDTP1ivAbzA7kjkXQjWMWd6VoYSCPYl2n1ynF9Rm1U8DLl9v3HoP9PgBxeQj3dTovSrmrO-Gd8X3niRlqKtmeA>
X-ME-Proxy-Cause: dmFkZTEopSd7n/vXCfhqSiBk4QgCoeLQ2eng2wPm1sVOdIE9XqiErBvdwkxPqrSF9lvnbj
 PNw2Aez78PVPATo7MpxE5/7khEyWS7bGHOUvL40GtBC7Jej4mNsqHXGpB3a78z1J1LazNq
 EJNWXg219094cAhHmbiKPAoolPhI1Rab3Ttu20uTH6zYIg+lkiLuhNRLeufUR1VaF5GKZs
 0+NnaXgc1CpMreTUQL1/dYnWtA7PFJHVb00fUoefIszu4AakUgh+/8lSYkXux34d+8pyDh
 8g2Vdv/b31Xl+cSbxGRnHwKB0jGmZSJfdwsNNTGOeaD0Tf6MV+8F3SVdNyUr5KXX5Kf/jK
 U1Vdwg8xlv7z6/iNOE/8M3ICSdU3BQg1JzXs6enRT0CEgMJAPkyfQH3vV4HydceuyuaN03
 MP7f1oSe/5GHbDaEBGCTKqWbQwtc0vX13JSuDfz9DPcQImqDaBiF6qsnh4PqB0FQMFcFGs
 tjcymjWP/r/e21bDMYzM29CP5CVk1t3J22zBJg/xpeebElWQk+CEdGDeWqN7YUU14XbuZ8
 zRnLBELILWL+O0+AyXB0aC0eCSfeSuISrGfPEaYFJE9eKcyr3bh43sMOiouuD1NpPF7FqE
 K7DQx2oXtHuj+y03vgAGLt4prnOBRwFHBEqOm/mraoMpXFiPTVovpDIXXOGQ
X-ME-Proxy: <xmx:mTkYar6dHWzitTIzyvfJDWW12HCbwZQW0yxZZlKfUVLZIk_85Pip4Q>
 <xmx:mTkYat2bCWcFKpRIUNQVBH1qIYKoJjHt8BPzxg8gUGUEbO7tNLk2mw>
 <xmx:mTkYauEIxUtKQIIGslCTefoIkUreFoP_-eRR7GoIdpnGAfrMpboxBw>
 <xmx:mTkYakh8ib5I5iVhV3sPYNVTnAREPw8y77_xn8_o9XRaTMAT6WwfhA>
 <xmx:mTkYan5_oJ3PbByD0XXSF75I7_cyrt5AGzc0ttKLGKwuWYncY3vchI3W>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:23 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3 07/10] net/mlx5: reindent previous changes
Date: Thu, 28 May 2026 14:46:34 +0200
Message-ID: <20260528124758.1984528-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528124758.1984528-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260528124758.1984528-1-thomas@monjalon.net>
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
 drivers/net/mlx5/mlx5_rx.c      | 82 ++++++++++++++++-----------------
 drivers/net/mlx5/mlx5_rxq.c     | 32 ++++++-------
 drivers/net/mlx5/mlx5_trigger.c | 18 ++++----
 3 files changed, 65 insertions(+), 67 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 586bf6c935..ad40511422 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1071,30 +1071,30 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
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
-		}
 		}
 		if (!pkt) {
 			cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
@@ -1103,7 +1103,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
 				/* We drop packets with non-critical errors */
 				if (seg->pool)
-				rte_mbuf_raw_free(rep);
+					rte_mbuf_raw_free(rep);
 				if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
 					rq_ci = rxq->rq_ci << sges_n;
 					break;
@@ -1117,7 +1117,7 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			}
 			if (len == 0) {
 				if (seg->pool)
-				rte_mbuf_raw_free(rep);
+					rte_mbuf_raw_free(rep);
 				break;
 			}
 			pkt = seg;
@@ -1138,21 +1138,21 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			}
 		}
 		if (seg->pool) {
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
 		if (len > DATA_LEN(seg)) {
 			if (seg->pool)
@@ -1163,8 +1163,8 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 			continue;
 		}
 		if (seg->pool) {
-		DATA_LEN(seg) = len;
-		data_seg_len += len;
+			DATA_LEN(seg) = len;
+			data_seg_len += len;
 		}
 		PKT_LEN(pkt) = RTE_MIN(PKT_LEN(pkt), data_seg_len);
 #ifdef MLX5_PMD_SOFT_COUNTERS
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

