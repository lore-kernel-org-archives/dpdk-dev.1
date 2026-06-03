Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0499ECD6E55
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Jun 2026 18:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3747406BC;
	Wed,  3 Jun 2026 20:45:30 +0200 (CEST)
Received: from fout-b5-smtp.messagingengine.com
 (fout-b5-smtp.messagingengine.com [202.12.124.148])
 by mails.dpdk.org (Postfix) with ESMTP id E350840A71
 for <dev@dpdk.org>; Wed,  3 Jun 2026 20:45:29 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 480AA1D00170;
 Wed,  3 Jun 2026 14:45:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 14:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780512329; x=
 1780598729; bh=fR/DHO4kJYb54pTYqFVuwzSnmDYEQ94VJtMCZOqkFs8=; b=C
 TPoUSk87eK9AX209Dh0UKl44TAJGgxux/wA1TiCUsO2WcU6rzhzuE5fOzApo2R6L
 Ze5iGLIi1nPR1hP6p3JhMZYfFObdXs7QLADuXpf7XuyEHb0ICcp8cAsQz/5miJwh
 ZBtuWxBlof7tZpAwq98zmsqpEceB4xi7OobYUftEzssWOD/2NUTWWIh714vL+5Gu
 Jo4J1e89WYHdR6j/E2axEm5beRCOjvNem3J88SHPxt68KHHfDk9GD2dzTMWpxjS3
 7elFFV0vEwzlo89GXAtsdw6W3o7H0XDcZMoT9wueph5y9UoOrUZ2DWNIpQ4CVdIC
 KuCKtcvhR3IeeACISTLXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780512329; x=1780598729; bh=f
 R/DHO4kJYb54pTYqFVuwzSnmDYEQ94VJtMCZOqkFs8=; b=KgWinIoZW1Qg/3Hop
 QOM0lr2R5l+bFOaAbh3iR2/qxvE6toXOHRGFI+mungD0eAK1hmpFzF8EDasEJpjJ
 l8vY6zgEtNpIC+NGuSrzmyYDTllUG/TPTqqUG5ADTrdph0o6qxNE8OJLJcrrryuR
 qS9s4f9BXzbdOTTD8/5EBEzFzVMtvHzuX1I/95fI2R+WTPxSc0Z+HNfHELUM+N/H
 xGGhX8D/aW0nN7MSLIX9xQDrvhzycIU6+lM8nfYQqAir87cJvE9u4zn15iN/gyUg
 m1xo5hWYxzpZqX7coqX5icZLEPG8kKuwqkejp8iuqt3T2sjC6xgTTlNT+mKJWtuf
 DhMww==
X-ME-Sender: <xms:SXYgatLTjBMsG-2UPXR9aBSmgMg1nWPe0zEbsdkZvyt9KMBQATA1Aw>
 <xme:SXYgajM8Ko3GSmA_r-6i8q0mWBwsHa_rbuur17I7ZveF--XIZeS4W_008hJZTyjH-
 WQIEALH7dHYSJQ-VeTMai4pA7yM9M9gF87TuwLx_qFv1S0rvnfQ4fA>
X-ME-Received: <xmr:SXYgalnP7zkty4n_U5niNE8jF4amYFAetgX-491_X8nss1oOozf8-cTqm3ZRPsW45GUuMw-smT3MFgQLmdGl-UT80GCVa10>
X-ME-Proxy-Cause: dmFkZTGYuhzhcTr5l2kyH2kEZshoeV+LOLOcoqfau4dhQKGtVKXvsJn9pr0qNsKjrL1adL
 7EPnqrOjZSDKw4REkVp4N3nUbfmk8nvecB29qLWiqulZ1et6nUz86GOyHTGMRs5X1skYIJ
 J11FfVawF6fVNdYA595YsHEDS5NKiOrXBT86h7sZZvGNLgErOVi6FG5JCmWltg0DU5yvmW
 hNy3S2Mf1ULrpVe6rlRo0bcrtN83h7LK3i4VqPAgkNa16YGONcI6gDJMdmD6Ui9hezgO+V
 Gz8mFEbB1Kef6EoJZNfexjml5Ols4gJgPKrTak9qpCZP6Hld5nUYF/fnE2EZ0TwWJy9QAU
 wUh2eW2UNZ1hxSCI91QTEmBWc2LG+LgsrBCQ93drkOUI2TRCnnXqSyoK0FLOFugNgjnmsz
 jxDVHM8gKlNFxybapfNwi7NcUSNzAkN3A42lncUix/GyXmbJTJ2yFtfYE0m2YJcTyCbK9J
 2PbbeNajbLru1wyx4sy2qDJsPhY3rynydoQN9Ho65fAtP0ZFoSzeNi5je7JPnm1ZtnJnq1
 QAY3YYNCMR5hwMp03hRJrgTevZBQXCWzvlBUFKnsImDOprhBqUeayOGo3P6omYJteSBpWy
 6BXlJfnoq85YdyM2l/qCW6wyNxNWvyiQRQkur4XeDCKvI2/Gtj3OYt1cSqew
X-ME-Proxy: <xmx:SXYgav452gHWLKGNyqqsY6RSGAtQigAstb2wzyI22aAUC_0BeA9z_g>
 <xmx:SXYgah2juSdv8YQf8AEpDCGFQjJ0FTFspUNeVbRjMaOEWRF26A_Xng>
 <xmx:SXYgaiGfO6xh342I3ILk7aGA9V4ntbQUdGPDerin0z9utNfxtnol-A>
 <xmx:SXYgaoj1BF-cEdOdWtVIMg0NOIgkmFOdp8QtgXca68RdZqsVzM3s1Q>
 <xmx:SXYgar6MgSEJnMiC1EtiS2Iya-OZSG6x74Kd6wFLy_hFc0sNWu3N-vOH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 14:45:27 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v7 07/10] net/mlx5: reindent previous changes
Date: Wed,  3 Jun 2026 20:23:30 +0200
Message-ID: <20260603184503.652030-8-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603184503.652030-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260603184503.652030-1-thomas@monjalon.net>
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
 drivers/net/mlx5/mlx5_rx.c      | 164 ++++++++++++++++----------------
 drivers/net/mlx5/mlx5_rxq.c     |  32 +++----
 drivers/net/mlx5/mlx5_trigger.c |  18 ++--
 3 files changed, 106 insertions(+), 108 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 1eef8ab95e..9812bc7929 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1071,107 +1071,107 @@ mlx5_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
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
-			mcqe = NULL;
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
-				len = 0;
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
+				mcqe = NULL;
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
+					len = 0;
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

