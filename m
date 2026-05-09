Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84055CD37B2
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:05:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D60C240676;
	Sun, 10 May 2026 00:04:50 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 8DE3E4067D
 for <dev@dpdk.org>; Sun, 10 May 2026 00:04:49 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id ECCD41D00086;
 Sat,  9 May 2026 18:04:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Sat, 09 May 2026 18:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364288; x=
 1778450688; bh=AGAL0CYIvRu6OvPIevxSGGif/6wlPYdfroVeYb1xftI=; b=Y
 RfGMmj2c0ut19lG9Udiplp6/aLLaygQYfiS9WS0BivgvzOARZQSYEQZ2ydDaYYr5
 PfPP9AznqYSZ0uvq8u5BgqZCb3g6DyFLE5j2W1Nax1IbplIh5f5WoqQO7ZZKizXl
 zSInviVEVso0Tk912payn/1tA9uBjbQNQ67uo1MbMgjYISMsSWC1NjKYl0lD4fPQ
 5LLBmvIrhnG2Dv2CfkAuFdLn6xRkA6RZJeiU5VGWNqF5VRAqOdoPhyq764kPOeTG
 t2WOYjOuCKHQ78fCKWJGEmor+ffCfIr7kEyaI9A5smOcm8SPi05Tp2w7FlXHoMBo
 jUHBqyFr29a6XoqHVAriQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364288; x=1778450688; bh=A
 GAL0CYIvRu6OvPIevxSGGif/6wlPYdfroVeYb1xftI=; b=ssvr6sTsG18H0ZRa8
 tnX91LCQSR4+JWmrMmGtFR7CvpWcp6bbPx1lL9u8UW5feSUj8PMYo64wm4zSRdLv
 C8Tr+tnuelYjY5BigtpGjSAMHnOGTACFnDDvnZvVs48B16pNf/3bXQfTFeUtcwb9
 +ODrlSrEdQc4bag7QCyVzEPoQsSyOO9dyq7/GHmLfvkoQ0eSsLi6jDyPR47fSWym
 n6tPjde28ODw2YlaVro5GC4U2FBdT4KnHzYKoPMc58n5S7dtY3hNdVbyjw3koibG
 aytHDH8V9RNTVMkwKvtrPuebU4sundq9Ca2Pfk76WBcJR2dz1lBbyz0SnFDZSL1D
 Af3yA==
X-ME-Sender: <xms:gK__aeOoHyXpeV7Qr28o9skWlr3H9gehNOblFhyxJQ1OscCmB1O6lA>
 <xme:gK__aXA6yB06nEe_DsPJyzjhcnDiuM8BcbXWHuLzRXtfDe0GCIlnrz93EXA80V8uJ
 atq48JxSKaCrNaEAKTnCuvIAkZOZ1KgC6jbj2dyyGF1x9VF9JXrJQ>
X-ME-Received: <xmr:gK__aVLd2wW6wdn8AYF-vpA0p5-EIHllgwHSAOSZexlgB9mK5l8KsBYYAt6cc0CjyY1at3BPrn6MK6_fYSEGIqhAigymWrk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeekpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopegushhoshhnohifshhkihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepvhhirg
 gthhgvshhlrghvohesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsghinhhgiiesnhhv
 ihguihgrrdgtohhmpdhrtghpthhtohepohhrihhkrgesnhhvihguihgrrdgtohhmpdhrtg
 hpthhtohepshhurghnmhhinhhgmhesnhhvihguihgrrdgtohhmpdhrtghpthhtohepmhgr
 thgrnhesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:gK__aQPjdblaYeAhmrbN79aG-ZyOE37qt4J0Xf-lMZySh71qEH4TQw>
 <xmx:gK__aT4Yd1XUvxe-2cKDvty93HYMikgxbnn5fPRWbXuSa8i-OBx3PA>
 <xmx:gK__aS4kjvWPr7uFXEXaERQvYjWmviQdXq_MwYBW4NQLKI_axlVMQg>
 <xmx:gK__aRFKrajt5CSbZG7uQB_O6UM8oMRsCReLSnZXpJvOnlzblMr3Aw>
 <xmx:gK__addBhouYUVI6ZDDWOgRjuCjsMHqw-87v5wLUb3UKBJ77IJQmtn1S>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:47 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2 07/10] net/mlx5: reindent previous changes
Date: Sat,  9 May 2026 23:56:58 +0200
Message-ID: <20260509220356.3679114-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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
 drivers/net/mlx5/mlx5_rx.c      | 146 ++++++++++++++++----------------
 drivers/net/mlx5/mlx5_rxq.c     |  32 +++----
 drivers/net/mlx5/mlx5_trigger.c |  18 ++--
 3 files changed, 97 insertions(+), 99 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 6d4dd85e66..12c4bb10bd 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1071,84 +1071,84 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 		rte_prefetch0(cqe);
 		rte_prefetch0(wqe);
 		if (seg->pool) {
-		/* Allocate buf from the same pool. */
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
-		if (!pkt) {
-			cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
-			len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
-					       &mcqe, &skip_cnt, false, NULL);
-			if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
-				/* We drop packets with non-critical errors */
-				rte_mbuf_raw_free(rep);
-				if (len == MLX5_CRITICAL_ERROR_CQE_RET) {
-					rq_ci = rxq->rq_ci << sges_n;
+			/* Allocate buf from the same pool. */
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
-				rte_mbuf_raw_free(rep);
 				break;
 			}
-			pkt = seg;
-			MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
-			pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
-			if (rxq->cqe_comp_layout && mcqe)
-				cqe = &rxq->title_cqe;
-			rxq_cq_to_mbuf(rxq, pkt, cqe, mcqe);
-			if (rxq->crc_present)
-				len -= RTE_ETHER_CRC_LEN;
-			PKT_LEN(pkt) = len;
-			if (cqe->lro_num_seg > 1) {
-				mlx5_lro_update_hdr
-					(rte_pktmbuf_mtod(pkt, uint8_t *), cqe,
-					 mcqe, rxq, len);
-				pkt->ol_flags |= RTE_MBUF_F_RX_LRO;
-				pkt->tso_segsz = len / cqe->lro_num_seg;
+			if (!pkt) {
+				cqe = &(*rxq->cqes)[rxq->cq_ci & cqe_mask];
+				len = mlx5_rx_poll_len(rxq, cqe, cqe_n, cqe_mask,
+						       &mcqe, &skip_cnt, false, NULL);
+				if (unlikely(len & MLX5_ERROR_CQE_MASK)) {
+					/* We drop packets with non-critical errors */
+					rte_mbuf_raw_free(rep);
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
+					rte_mbuf_raw_free(rep);
+					break;
+				}
+				pkt = seg;
+				MLX5_ASSERT(len >= (int)(rxq->crc_present << 2));
+				pkt->ol_flags &= RTE_MBUF_F_EXTERNAL;
+				if (rxq->cqe_comp_layout && mcqe)
+					cqe = &rxq->title_cqe;
+				rxq_cq_to_mbuf(rxq, pkt, cqe, mcqe);
+				if (rxq->crc_present)
+					len -= RTE_ETHER_CRC_LEN;
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
@@ -1159,8 +1159,8 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
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

