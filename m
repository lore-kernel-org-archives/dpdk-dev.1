Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60A4606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 16:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=W705s/0m
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07C2440A6C;
	Fri, 23 Oct 2026 18:51:34 +0200 (CEST)
Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com
 [209.85.216.97]) by mails.dpdk.org (Postfix) with ESMTP id 61634402D8
 for <dev@dpdk.org>; Fri, 23 Oct 2026 18:51:31 +0200 (CEST)
Received: by mail-pj1-f97.google.com with SMTP id
 98e67ed59e1d1-3acc96a256dso678709a91.3
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792774290; x=1793379090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UbHVKxYRSNy11mU34VzxlxrkJLAkV6OexeTfQJzsX30=;
 b=TuzM0oUOvhxCs6w107AoihnLfW0R4un6gQER0y1n4ngrvhOWCpvnYpBOetlvP4E/UJ
 FhQwJykYaWH1eDayVUcFD4TIlGgtzSfmNI6Q9p/8N5nb38leRVFL0j0gNvXNuYXG3Kj2
 6bx/xsQyvDdx3XAsiy1y55e1wldobEk9e8dSEBo7TgikKN2PXLCi2lX2vt/5ae/vvq3L
 C3EcYD2dH0CzzlYTGsY9QXYmBc4xPhdJwOk1/3WY8zJKGFMGmvqK13vy1nTXwi9/rw+3
 SQJQL6fLUEz1enfJcBj+QehEZk3vpNOT+njZdK2Qx7pzxeRsmO2PLjBIO59U1eJEAPf1
 pN+w==
X-Gm-Message-State: AFq9FYI42NML6hpM4IGpL3ubS5f+CkTe8da1DZpabPt6GBn0/WIgIQp6
 bW4QmBk7DLVk5vu3LQZDxpguJWlPZyQjAGOVyGzOXdpGL5tk8A2xlZTSKFT6MwdgpHNSwuzTD9a
 Ez4WiXtUtYvzeSS0yFShPduUpv0+DDAwbxI42cGzZO9r+2ky09d++hZ1IeepIubxQyYaXlumGIY
 3XcqU8hU3lah8NPZUS37DCBIhC5khSN7na/jMPjB0sLL+fZHcPpBWLw0zAn8LHhEaxZ1eVsojmd
 qQQIMLReT9t
X-Gm-Gg: AYBFou0lE8zxD9jqIFgXkhEF5zFMkpSlXWeaxPlc/c9KEgf/0tMazF+89CHUerHPXkp
 v3lSaqMOpuBIxlQvlMxWtjMrd2n/nfdy9uhTPE2+RZsWasC/pkvgqtdVFXeEgD5vCEqHGMR46/5
 TgiPs4fbKJ8uiVLF/rZo8u6HzSpPyQSx8kXQV6fyF0ynexRaDtXF1FRFA4Yj2H/UWZ5uvs042L5
 m7tso1Hji+L6CzKcyGeSv1xCHt6Dc5CjPknfzbFZpRivWMv+649x1+f17bEl93/5J3+KDdtRcvW
 JkASlxIxrpBnbtPlBGLendAak22TvGi0Rn7l4YKhJnkB7boVLItij6YNcgVre4Xd8FAl14yyCSX
 C3mNhMKxhDCfIzMYykxNEND1uuqMqS36Ki0k1fXspUIw/cn9qdadyoI/WAc1kTxoCJ2YTE89qgH
 yFK/1v3hGWHW327sGitG6cdKCEOrYrFrd9xkZwhQ9pv/WEU8C0UQ==
X-Received: by 2002:a17:90b:3951:b0:3ab:e588:c288 with SMTP id
 98e67ed59e1d1-3adcdfd27d9mr2440270a91.11.1792774290241; 
 Fri, 23 Oct 2026 09:51:30 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3addd817da2sm466690a91.6.2026.10.23.09.51.29
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Oct 2026 09:51:30 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b8306ba68so26209576d6.2
 for <dev@dpdk.org>; Fri, 23 Oct 2026 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1792774289; x=1793379089; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UbHVKxYRSNy11mU34VzxlxrkJLAkV6OexeTfQJzsX30=;
 b=W705s/0mYArqtUHXdwo2V8cHAkC+kVuWQGyhUTeUexbIAsB4jIqnZQ9oHX9dYmmO5l
 FhUwSsItIJGGAPYVGCwIfFXIRO6+drSdK1c/tuFd8EpfvL75BFE6KzQto/U/h2ttPKmi
 tPBTyAdUx+b0tcxdm5PfTZ6Nzk/YvfgthrFLM=
X-Received: by 2002:ad4:5f4b:0:b0:91b:8e83:e4b0 with SMTP id
 6a1803df08f44-91c3a84c59cmr39636986d6.20.1792774288845; 
 Fri, 23 Oct 2026 09:51:28 -0700 (PDT)
X-Received: by 2002:ad4:5f4b:0:b0:91b:8e83:e4b0 with SMTP id
 6a1803df08f44-91c3a84c59cmr39636656d6.20.1792774288135; 
 Fri, 23 Oct 2026 09:51:28 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c45228d8bsm5928056d6.21.2026.10.23.09.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 09:51:27 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Shuanglin Wang <shuanglin.wang@broadcom.com>, stable@dpdk.org
Subject: [PATCH 3/7] net/bnxt: fix Rx packet stall
Date: Fri, 23 Oct 2026 10:54:52 -0600
Message-ID: <20261023165457.1225312-4-mohammad-shuab.siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shuanglin Wang <shuanglin.wang@broadcom.com>

Rx on Thor could stop delivering packets. Independent issues in the
doorbell and vectorized Rx paths combined to cause this:

- bnxt_db_epoch_write(), bnxt_db_mpc_write() and bnxt_db_mpc_cq()
  always OR'd the epoch bit into the doorbell key, even on rings
  whose db_epoch_mask is unset (every chip but P7). On those rings
  the epoch bit lands in doorbell key space the firmware interprets
  differently, corrupting the doorbell write. Only apply the epoch bit
  when db_epoch_mask is set, and shift the epoch value as a 64 bit
  quantity.

- The AVX2, SSE and NEON Rx wrappers split a request into chunks of
  rx_free_thresh packets. A small rx_free_thresh could force chunks
  narrower than one vector loop, so clamp the chunk size to at least
  one vector loop width.

- bnxt_rxq_rearm() computes nb from rxrearm_nb & ~0x3, which is zero
  whenever fewer than four mbufs need rearming. It then fell through
  and rang the doorbell a second time with no new descriptors posted.
  Return early when nb is zero.

Fixes: 30656a1cace8 ("net/bnxt: refactor epoch setting")
Cc: stable@dpdk.org

Signed-off-by: Shuanglin Wang <shuanglin.wang@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_ring.h            | 15 ++++++++++-----
 drivers/net/bnxt/bnxt_rxtx_vec_avx2.c   |  9 ++++++---
 drivers/net/bnxt/bnxt_rxtx_vec_common.h |  2 ++
 drivers/net/bnxt/bnxt_rxtx_vec_neon.c   |  3 ++-
 drivers/net/bnxt/bnxt_rxtx_vec_sse.c    |  6 ++++--
 5 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_ring.h b/drivers/net/bnxt/bnxt_ring.h
index d710d85371..d63ae8d8f8 100644
--- a/drivers/net/bnxt/bnxt_ring.h
+++ b/drivers/net/bnxt/bnxt_ring.h
@@ -116,7 +116,8 @@ static inline void bnxt_db_epoch_write(struct bnxt_db_info *db, uint32_t idx, ui
 	if (db->db_64) {
 		uint64_t key_idx = db->db_key64 | db_idx;
 
-		key_idx |= epoch << DBR_EPOCH_SFT;
+		if (db->db_epoch_mask)
+			key_idx |= ((uint64_t)epoch << DBR_EPOCH_SFT);
 
 		rte_compiler_barrier();
 		rte_write64_relaxed(key_idx, doorbell);
@@ -133,8 +134,10 @@ static inline void bnxt_db_mpc_write(struct bnxt_db_info *db, uint32_t idx, uint
 	void *doorbell = db->doorbell;
 
 	if (likely(db->db_64)) {
-		uint64_t key_idx = db->db_key64 | db_idx |
-			(epoch << 24);
+		uint64_t key_idx = db->db_key64 | db_idx;
+
+		if (db->db_epoch_mask)
+			key_idx |= ((uint64_t)epoch << 24);
 		rte_write64_relaxed(key_idx, doorbell);
 	} else {
 		uint32_t key_idx = db->db_key32 | db_idx;
@@ -195,8 +198,10 @@ static inline void bnxt_db_mpc_cq(struct bnxt_cp_ring_info *cpr)
 	uint32_t idx = DB_RING_IDX(&cpr->cp_db, cpr->cp_raw_cons);
 
 	if (likely(db->db_64)) {
-		uint64_t key_idx = db->db_key64 | idx |
-			(cpr->epoch << 24);
+		uint64_t key_idx = db->db_key64 | idx;
+
+		if (db->db_epoch_mask)
+			key_idx |= ((uint64_t)cpr->epoch << 24);
 		void *doorbell = db->doorbell;
 
 		rte_compiler_barrier();
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
index 1236d3c2fe..a953a4a928 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -685,7 +685,8 @@ bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint32_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC256);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
@@ -707,7 +708,8 @@ bnxt_crx_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 		       uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint32_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC256);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
@@ -1334,7 +1336,8 @@ bnxt_recv_pkts_vec_avx2_v3(void *rx_queue, struct rte_mbuf **rx_pkts,
 			   uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t expected_burst = rxq->rx_free_thresh;
+	uint32_t expected_burst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+						     BNXT_RX_DESCS_PER_LOOP_VEC256);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > expected_burst) {
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_common.h b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
index c75a8bd09f..bca18f936f 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_common.h
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_common.h
@@ -67,6 +67,8 @@ bnxt_rxq_rearm(struct bnxt_rx_queue *rxq, struct bnxt_rx_ring_info *rxr)
 	 */
 	nb = RTE_MIN(rxq->rxrearm_nb & ~0x3,
 		     rxq->nb_rx_desc - rxq->rxrearm_start);
+	if (unlikely(nb == 0))
+		return;
 
 	/* Allocate new mbufs into the software ring. */
 	if (rte_mempool_get_bulk(rxq->mb_pool, (void *)rx_bufs, nb) < 0) {
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
index 7aa153bc4e..d10e513f32 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
@@ -318,7 +318,8 @@ uint16_t
 bnxt_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint32_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC128);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
index 8dfb16a26d..e5ef48fb4c 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
@@ -518,7 +518,8 @@ uint16_t
 bnxt_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint32_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC128);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
@@ -540,7 +541,8 @@ uint16_t
 bnxt_crx_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint32_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC128);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
-- 
2.47.3

