Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AF606A31F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hp2QO+MQ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 484A840664;
	Mon, 26 Oct 2026 20:09:26 +0100 (CET)
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com
 [209.85.222.225])
 by mails.dpdk.org (Postfix) with ESMTPS id 94B01402E8
 for <dev@dpdk.org>; Mon, 26 Oct 2026 20:09:23 +0100 (CET)
Received: by mail-qk1-f225.google.com with SMTP id
 af79cd13be357-93e7ad9f78dso401434685a.1
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041762; x=1793646562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BNYH9WM/Z+Mm5yTq875GRnXLhYgcAeKPO6Uj5vC0x5g=;
 b=pUAo9/aFjhFGmm4jhZbhgNpQICbv1rS26y/z6H/tA9wcWR55YIhjuZOTP1Owz77IcD
 KDrTyEbsQoUx3Fs4miZpyhWHtgHTl78ogWlpEuA4NlrUUm7T05v/G4oIuWFTn2sgXr7B
 rsGVOxQdmrvnz/dFlDQZAomJ7HFBTiugBJnrZy5gqqLvYknufIFRCx3RO9FJ4dhOjF+j
 lV2QKL59jjMh7TJuB7cI+WdFdR9N/5wVlTAVPaUEUngjsDtfphoo0jE08a4+EsTCtYLV
 TZThQ3K5SRAbm8XCatWdqkdZOD9yO0G8ejtf7iLN213xr+TKD0dEwJak92Q7NNbnswVb
 6azQ==
X-Gm-Message-State: AFq9FYIKBCt/FgMlYCnbFBuJ21FzozGatUmKswj3urpfhzvQy3Sxxc6l
 0eNWhfHrypOfip1GDFIggTNJWTEleUKZzCI1ZAJuuNeBcQRCcnTNkVUVJ258IFKPDDtI0tFxDC1
 C6nzTpaIESxAfANnFfBv+lVstTTqwIEcSXYIWKvhn9OjnGCTrtmRkJag4LKFl8oSaL5DqxQPX4R
 +ae09IdPeO3LLmh8SU9xKC48kNebX2KlctKK2nyk7RHnUFiI7WbHsJA6HbVlcnWyLlGOx4LTIxQ
 R9uID1X4Tyz
X-Gm-Gg: AYBFou29eNRbIDAmgzTwZGHa3jD/5gEuNECKTIkaiJW5cus7J0FVLnbeoVPDYtd/qTd
 XxWMKH9+Yv9F5xV9rSZ064EAt/aYzMK+Ish1ok/jkEeNNJJy5Hc69CKr6rMCBsY1025e82VWCgd
 LVytSY9Y8ubNVgBr1MK3eNMf1RKMrdDrI3g3MwFPvni3LJgG9JLwyA1dr6SpT1s812qU8VeCF89
 IwF1CWIQPs7X0j1ZhGExMSoN/8RW7vMWTkyCiLO9KgPE2MPBQCCsplu6vbOBUzkIuZWR+zx1LKW
 BApM5TOKwdUKApibw73X0vhi2f/X1yaxTlrLa/F/oEcRTni8YhPsAP/EA1bohoJjLmEtA6r7Xwc
 ITDBB5BzKQgMcGrI24j9bg6hhyaqU5VfZg4QFEG62x1Mt++n1JHbu1aB0w/tCHTOnKikqYzl/D5
 RoQGgMfauXTY5ow5dJ8KYOiLEwHGkI32URZUXIzeXsMwOXB/BtoQ==
X-Received: by 2002:a05:620a:4002:b0:93e:66e6:fa4 with SMTP id
 af79cd13be357-940ef8ad076mr1134998785a.16.1793041762371; 
 Mon, 26 Oct 2026 12:09:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-23.dlp.protect.broadcom.com. [144.49.247.23])
 by smtp-relay.gmail.com with ESMTPS id
 af79cd13be357-940efc55aa2sm110676785a.0.2026.10.26.12.09.22
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Oct 2026 12:09:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36637676140so5481089eec.0
 for <dev@dpdk.org>; Mon, 26 Oct 2026 12:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793041761; x=1793646561; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BNYH9WM/Z+Mm5yTq875GRnXLhYgcAeKPO6Uj5vC0x5g=;
 b=hp2QO+MQ8TRjPqdDZStfD5P1S5cw2VC97B7kiecg7sHCEdxv/DjviN/HOaDjzRuW09
 scBPSQ9eGIfOeBpRaoYQaq9Yly4heIPBJusHB7yYdO45EkvYZO0I6qhBh1vpd2Xexxmy
 3f+/aXKAD6T+mQWj4MjhTySQ/sRCRZOlokGdw=
X-Received: by 2002:a05:7301:e10a:b0:35e:f4ac:5f8e with SMTP id
 5a478bee46e88-369e8210022mr10539694eec.0.1793041761021; 
 Mon, 26 Oct 2026 12:09:21 -0700 (PDT)
X-Received: by 2002:a05:7301:e10a:b0:35e:f4ac:5f8e with SMTP id
 5a478bee46e88-369e8210022mr10539647eec.0.1793041760091; 
 Mon, 26 Oct 2026 12:09:20 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369e8db7b23sm37103906eec.19.2026.10.26.12.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:09:19 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com, kishore.padmanabha@broadcom.com,
 Shuanglin Wang <shuanglin.wang@broadcom.com>, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH v2 3/7] net/bnxt: fix Rx packet stall
Date: Mon, 26 Oct 2026 13:12:47 -0600
Message-ID: <20261026191251.1274062-4-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20261023165457.1225312-1-mohammad-shuab.siddique@broadcom.com>
 <20261026191251.1274062-1-Mohammad-Shuab.Siddique@broadcom.com>
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
index d710d85371f..d63ae8d8f85 100644
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
index 1236d3c2fed..96ca3f4f070 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_avx2.c
@@ -685,7 +685,8 @@ bnxt_recv_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC256);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
@@ -707,7 +708,8 @@ bnxt_crx_pkts_vec_avx2(void *rx_queue, struct rte_mbuf **rx_pkts,
 		       uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
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
index c75a8bd09f9..bca18f936fb 100644
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
index 7aa153bc4e1..c1998fccdea 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_neon.c
@@ -318,7 +318,8 @@ uint16_t
 bnxt_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC128);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
diff --git a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
index 8dfb16a26d6..28f0bb568cb 100644
--- a/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
+++ b/drivers/net/bnxt/bnxt_rxtx_vec_sse.c
@@ -518,7 +518,8 @@ uint16_t
 bnxt_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC128);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
@@ -540,7 +541,8 @@ uint16_t
 bnxt_crx_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct bnxt_rx_queue *rxq = rx_queue;
-	uint32_t brst = rxq->rx_free_thresh;
+	uint16_t brst = (uint16_t)RTE_MAX((uint32_t)rxq->rx_free_thresh,
+					   BNXT_RX_DESCS_PER_LOOP_VEC128);
 	uint16_t cnt = 0;
 
 	while (nb_pkts > brst) {
