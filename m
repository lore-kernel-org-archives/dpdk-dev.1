Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D501BCD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 13:36:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2907F4067D;
	Fri, 29 May 2026 15:35:48 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id D386E40674
 for <dev@dpdk.org>; Fri, 29 May 2026 15:35:46 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 411871D0005B;
 Fri, 29 May 2026 09:35:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 29 May 2026 09:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780061746; x=
 1780148146; bh=RR9xRz3sIWpN15Nf73fc8lK0+/q+5xdOrJ9Sc7D2KOc=; b=H
 JqsA+bcMjzEEGmKgpSOU29CfBTXpDUZkE8bPZ+0/JLoF0Aq0syOQCOQztjJyw+uu
 JBcPJ/Twta6rm623JaCMtVH1IH4gDP32a8LVi1IP1QmZF4LDMKVTKBTQ8t7AcBAj
 AL397eUC3gL8521S5mecRnrixHos8qs/KS4zhD1vpT70tCA2IASj/SeEAxjGpHBn
 YRCkEwvAEhqJMdZvNsh8G/DQ9nVuCrCzFOI8Eyu4zvzrdVqDf1aPI/mUGYp4czd1
 4hCcYKPl2G5JCp7+hFNFAX6XJfd8FX/f93XjbU0GlhPoMC2n2xOMaoA/NBr/jRbi
 7ypRt1GjCafhK4DCMdXng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1780061746; x=1780148146; bh=R
 R9xRz3sIWpN15Nf73fc8lK0+/q+5xdOrJ9Sc7D2KOc=; b=X18ixVipVIWFALYVy
 PD9fW4DkY3/gqMD2OkU+mGgnR4l7uGT7BBu5AW+nq765wnzWgG4MFYD2bIZEN1e5
 /v+rpvh6wAkMFvrjWcRjJEDyT0Wgb+Lvclpy42xx+/pKZ5yzjfG02kGIre8fijGa
 TVtugXt+zUGwP3PaZGyk6ZHQKwv7tvND5fy9VA9oRPr0eQrpEZmJzGti92HRTEt1
 Vd8lCYhMzP0aCWLdJ9EZ87eKKM+FL1cWFI9ucA4pH938c3ynK6Hb0DJGito8UY2G
 xCJ45a4Ef01tFAf7g4qSFp2puDgFQO21SKukIKz3fBB++6/4oU5QZHULZU9Br1ws
 mGnIw==
X-ME-Sender: <xms:MpYZarWt-TyF8vuU1dwRg-Cg6aTDHUseBmdtGFtTcsNfdeg7JWFzew>
 <xme:MpYZatrziLMt7Z0mx47oHdMq0wTs1pu633beTzXphMCJpNe9Uj5zIkVxGj5wtm6YD
 WnsoFxtXALHxU4xjyXgQOitYgFWouv1peAfbmRNkVGh6yUldMeNog>
X-ME-Received: <xmr:MpYZanQLOMlBFRScFM1R4lCKHSsDumBpOyM_miRVzgov4cpeKdkBnXNqt4DQa6JTWOzfIJ9CB06AoU_VmHV5Vhl07eDsOGI>
X-ME-Proxy-Cause: dmFkZTE6go/Z6V7fN8o/c9c/NvNG3UKikOcJdzgOLMe1Srq/PupJpePoobdEfZAXiwk18K
 XqBnBSTv6Pq2WaLQfBxlG5oyaVTt6fd8YRVblE5XDz4oaa8ng//8MjyNDVrKJTHwsEsh8h
 Kdj85+sjma5Xbu5EhNZjmUWIta0tWFDNOps8zMU4m/hhJoHSZlFMo01monfzknewTsYhay
 bdo48/yb86Gt4tZM4+K7jGiiU34kvwlEXCsfPWNVCHwVUSRGX7Dv6sb+GJZ+ukM4cF3DCO
 +/AG/Vfv3xl9KuBgO+kFM05JBuP6z+Lwo/uNNwL2PN9ijrH7SuBhaGoCCXAqZhykPR5tGU
 RiS2N3lSR6rcA+Rux+2DViu2qejpgKWsC4IT01GgZP1lzyPax/zTbq2LZaksr1X2OLwCvt
 D37ZQrxhcr6sy8FdLcH4fAo6SjzMwfw5oYJblVn5/eC5jTArZrlKXV79+UfHJujLGN8pYP
 E5dW937J0bP7QmjsTrvKAjo65lWbZyAsbL+IeYuxI5tHPp8U3/iYOXpK8y5XbVl7uNtNgg
 Y1sdp/lUtiCQRDRDUcI41ovYNhNgXNDdk36DnCxwxbNcI2n8Qrir4jUnhIIKGBm7OpHMQN
 hLWXMT/Xu0gTZDYK+ehDjcrAnwBu19pvZBWYQC6K+boKezMUoRKXIAsVfYKA
X-ME-Proxy: <xmx:MpYZan0TgLw-MaGQpKtP7UoKyM8RIo-84DKgSag94X8chNvNtXIb7Q>
 <xmx:MpYZajBY00QYmad0xNJeF8fA5l4LG2gMa6tKCsLUGSxRsIdhRhxRng>
 <xmx:MpYZajjKYJBniX3nSTlP7RoHpGeDhfZUwt7KNuwhBgbFHvczJdzizQ>
 <xmx:MpYZalP4wpJmad7bZUGfOIHQjkFQ74QuTTYE9I6Tg5bTtWFB2S6Acg>
 <xmx:MpYZajmE7Z0_eIdJyyMXnBELsi5tPbZoQKoEI2r5KtQO2lDbMV2RKur1>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:35:44 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v4 07/10] net/mlx5: reindent previous changes
Date: Fri, 29 May 2026 15:34:01 +0200
Message-ID: <20260529133522.2646044-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529133522.2646044-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
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

