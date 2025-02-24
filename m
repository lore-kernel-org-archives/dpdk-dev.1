Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A98C021B3
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Feb 2025 09:55:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 152F540E7C;
	Mon, 24 Feb 2025 10:54:59 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 3781840B90
 for <dev@dpdk.org>; Mon, 24 Feb 2025 10:54:51 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51O51DKT001315
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
 e6+uxnjEDBwFfLuo45jRTiPX+N7AaUv10dL2N+Q8Q0=; b=hypUTvC2eRs2JXWUP
 BDmwZkQ0xi5QkeUBYXhmIevccYYdTEvtS0TdSnZjufepuR3m286wTDSGAt4Hbmt7
 XbllA53m2CZIT8oYrM9q7ea5t6WBOvkF0GCLI+/sKNl+s28U3XRY16Qm8FyfDO2X
 bl+B1pnwQiBBccv67bx3Mkx1oTo2FxZhecpSl7HLMlbcgNv3nDfsdued3VRzBPrt
 9rIpvH4TLSrG7zV17wqfMj7bKIGXriiNYxT4SDrwTZM8Mtxw+T/r/Vx7X0uqm+tC
 ZNw4g2ATpNPI6AgTks4Iu1uxBEIQCkNJ4OEyu1LEESBilZvG8bGzIrZyWC85oMkA
 EKvKw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 44ys85jh2x-11
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 24 Feb 2025 01:54:50 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Feb 2025 01:54:28 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Feb 2025 01:54:28 -0800
Received: from hyd1588t430.caveonetworks.com (unknown [10.29.52.204])
 by maili.marvell.com (Postfix) with ESMTP id DA8593F705D;
 Mon, 24 Feb 2025 01:54:26 -0800 (PST)
From: Nithin Dabilpuram <ndabilpuram@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>
CC: <dev@dpdk.org>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH v3 27/33] event/cnxk: inline IPsec Rx support for cn20k
Date: Mon, 24 Feb 2025 15:22:35 +0530
Message-ID: <20250224095241.1263700-27-ndabilpuram@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224095241.1263700-1-ndabilpuram@marvell.com>
References: <20250131080530.3224977-1-ndabilpuram@marvell.com>
 <20250224095241.1263700-1-ndabilpuram@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Rlf5Ja9YU3Ri0b0lOlLcFgrZZ2snD4T1
X-Proofpoint-ORIG-GUID: Rlf5Ja9YU3Ri0b0lOlLcFgrZZ2snD4T1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_04,2025-02-24_01,2024-11-22_01
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

From: Rahul Bhansali <rbhansali@marvell.com>

Inline IPsec Rx support for cn20k

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 doc/guides/rel_notes/release_25_03.rst |   1 +
 drivers/event/cnxk/cn20k_worker.h      | 111 ++++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index ca67c17c5c..6a7b3b5803 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -116,6 +116,7 @@ New Features
 * **Updated Marvell cnxk net driver.**
 
   * Added flow rules support for CN20K SoC.
+  * Added Inline IPsec support for CN20K SoC.
 
 * **Updated NVIDIA mlx5 driver.**
 
diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_worker.h
index 2366196d9d..6ed1f78a86 100644
--- a/drivers/event/cnxk/cn20k_worker.h
+++ b/drivers/event/cnxk/cn20k_worker.h
@@ -22,9 +22,13 @@ cn20k_wqe_to_mbuf(uint64_t wqe, const uint64_t __mbuf, uint8_t port_id, const ui
 	const uint64_t mbuf_init =
 		0x100010000ULL | RTE_PKTMBUF_HEADROOM | (flags & NIX_RX_OFFLOAD_TSTAMP_F ? 8 : 0);
 	struct rte_mbuf *mbuf = (struct rte_mbuf *)__mbuf;
+	uint64_t buf_sz = 0;
+
+	if (flags & NIX_RX_REAS_F)
+		buf_sz = cnxk_nix_inl_bufsize_get(port_id, lookup_mem);
 
 	cn20k_nix_cqe_to_mbuf((struct nix_cqe_hdr_s *)wqe, tag, (struct rte_mbuf *)mbuf, lookup_mem,
-			      mbuf_init | ((uint64_t)port_id) << 48, cpth, sa_base, 0, flags);
+			      mbuf_init | ((uint64_t)port_id) << 48, cpth, sa_base, buf_sz, flags);
 }
 
 static void
@@ -47,14 +51,20 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 {
 	uint64_t mbuf_init = 0x100010000ULL | RTE_PKTMBUF_HEADROOM;
 	struct cnxk_timesync_info *tstamp = ws->tstamp[port_id];
+	uint8_t m_sz = sizeof(struct rte_mbuf);
 	void *lookup_mem = ws->lookup_mem;
 	uintptr_t lbase = ws->lmt_base;
+	uint64_t meta_aura = 0, laddr;
 	struct rte_event_vector *vec;
 	uint16_t nb_mbufs, non_vec;
+	struct rte_mempool *mp;
+	uint16_t lmt_id, d_off;
 	struct rte_mbuf **wqe;
 	struct rte_mbuf *mbuf;
 	uint64_t sa_base = 0;
+	uint64_t buf_sz = 0;
 	uintptr_t cpth = 0;
+	uint8_t loff = 0;
 	int i;
 
 	mbuf_init |= ((uint64_t)port_id) << 48;
@@ -69,12 +79,39 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 	if (flags & NIX_RX_OFFLOAD_TSTAMP_F && tstamp)
 		mbuf_init |= 8;
 
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+		mp = (struct rte_mempool *)cnxk_nix_inl_metapool_get(port_id, lookup_mem);
+		if (mp)
+			meta_aura = mp->pool_id;
+	}
+
 	nb_mbufs = RTE_ALIGN_FLOOR(vec->nb_elem, NIX_DESCS_PER_LOOP);
 	nb_mbufs = cn20k_nix_recv_pkts_vector(&mbuf_init, wqe, nb_mbufs, flags | NIX_RX_VWQE_F,
-					      lookup_mem, tstamp, lbase, 0);
+					      lookup_mem, tstamp, lbase, meta_aura);
 	wqe += nb_mbufs;
 	non_vec = vec->nb_elem - nb_mbufs;
 
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F && non_vec) {
+		uint64_t sg_w1;
+
+		mbuf = (struct rte_mbuf *)((uintptr_t)wqe[0] - sizeof(struct rte_mbuf));
+		/* Pick first mbuf's aura handle assuming all
+		 * mbufs are from a vec and are from same RQ.
+		 */
+		if (!meta_aura)
+			meta_aura = mbuf->pool->pool_id;
+		ROC_LMT_BASE_ID_GET(lbase, lmt_id);
+		laddr = lbase;
+		laddr += 8;
+		sg_w1 = *(uint64_t *)(((uintptr_t)wqe[0]) + 72);
+		d_off = sg_w1 - (uintptr_t)mbuf;
+		sa_base = cnxk_nix_sa_base_get(mbuf_init >> 48, lookup_mem);
+		sa_base &= ~(ROC_NIX_INL_SA_BASE_ALIGN - 1);
+
+		if (flags & NIX_RX_REAS_F)
+			buf_sz = cnxk_nix_inl_bufsize_get(port_id, lookup_mem);
+	}
+
 	while (non_vec) {
 		struct nix_cqe_hdr_s *cqe = (struct nix_cqe_hdr_s *)wqe[0];
 
@@ -83,8 +120,29 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
 		RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
 
-		cn20k_nix_cqe_to_mbuf(cqe, cqe->tag, mbuf, lookup_mem, mbuf_init, cpth, sa_base, 0,
-				      flags);
+		/* Translate meta to mbuf */
+		if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+			const uint64_t cq_w1 = *((const uint64_t *)cqe + 1);
+
+			cpth = ((uintptr_t)mbuf + (uint16_t)d_off);
+
+			if (cq_w1 & BIT(11)) {
+				/* Mark meta mbuf as put */
+				RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 0);
+
+				/* Store meta in lmtline to free
+				 * Assume all meta's from same aura.
+				 */
+				*(uint64_t *)(laddr + (loff << 3)) = (uint64_t)mbuf;
+				loff = loff + 1;
+				mbuf = (struct rte_mbuf *)(*(uint64_t *)(cpth + 8) - m_sz);
+				/* Mark inner mbuf as get */
+				RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
+			}
+		}
+
+		cn20k_nix_cqe_to_mbuf(cqe, cqe->tag, mbuf, lookup_mem, mbuf_init, cpth, sa_base,
+				      buf_sz, flags);
 
 		if (flags & NIX_RX_OFFLOAD_TSTAMP_F)
 			cn20k_sso_process_tstamp((uint64_t)wqe[0], (uint64_t)mbuf, tstamp);
@@ -92,11 +150,18 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 		non_vec--;
 		wqe++;
 	}
+
+	/* Free remaining meta buffers if any */
+	if (flags & NIX_RX_OFFLOAD_SECURITY_F && loff) {
+		nix_sec_flush_meta(laddr, lmt_id, loff, meta_aura);
+		plt_io_wmb();
+	}
 }
 
 static __rte_always_inline void
 cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32_t flags)
 {
+	uint8_t m_sz = sizeof(struct rte_mbuf);
 	uintptr_t sa_base = 0;
 
 	u64[0] = (u64[0] & (0x3ull << 32)) << 6 | (u64[0] & (0x3FFull << 36)) << 4 |
@@ -112,6 +177,44 @@ cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32
 		/* Mark mempool obj as "get" as it is alloc'ed by NIX */
 		RTE_MEMPOOL_CHECK_COOKIES(((struct rte_mbuf *)mbuf)->pool, (void **)&mbuf, 1, 1);
 
+		if (flags & NIX_RX_OFFLOAD_SECURITY_F) {
+			void *lookup_mem = ws->lookup_mem;
+			struct rte_mempool *mp = NULL;
+			uint64_t meta_aura;
+			struct rte_mbuf *m;
+			uint64_t iova = 0;
+			uint8_t loff = 0;
+			uint16_t d_off;
+			uint64_t cq_w1;
+
+			m = (struct rte_mbuf *)mbuf;
+			d_off = (*(uint64_t *)(u64[1] + 72)) - (uintptr_t)m;
+			cq_w1 = *(uint64_t *)(u64[1] + 8);
+
+			sa_base = cnxk_nix_sa_base_get(port, ws->lookup_mem);
+			sa_base &= ~(ROC_NIX_INL_SA_BASE_ALIGN - 1);
+
+			cpth = ((uintptr_t)mbuf + (uint16_t)d_off);
+			mp = (struct rte_mempool *)cnxk_nix_inl_metapool_get(port, lookup_mem);
+			meta_aura = mp ? mp->pool_id : m->pool->pool_id;
+
+			if (cq_w1 & BIT(11)) {
+				/* Mark meta mbuf as put */
+				RTE_MEMPOOL_CHECK_COOKIES(m->pool, (void **)&m, 1, 0);
+
+				/* Store meta in lmtline to free
+				 * Assume all meta's from same aura.
+				 */
+				*(uint64_t *)((uintptr_t)&iova + (loff << 3)) = (uint64_t)m;
+				loff = loff + 1;
+				mbuf = (uint64_t)(*(uint64_t *)(cpth + 8) - m_sz);
+				/* Mark inner mbuf as get */
+				RTE_MEMPOOL_CHECK_COOKIES(((struct rte_mbuf *)mbuf)->pool,
+							  (void **)&mbuf, 1, 1);
+				roc_npa_aura_op_free(meta_aura, 0, iova);
+			}
+		}
+
 		u64[0] = CNXK_CLR_SUB_EVENT(u64[0]);
 		cn20k_wqe_to_mbuf(u64[1], mbuf, port, u64[0] & 0xFFFFF, flags, ws->lookup_mem, cpth,
 				  sa_base);
-- 
2.34.1

