Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C502D1038C
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 08:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F1A840B95;
	Wed, 26 Nov 2025 09:14:04 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 76DC74026F;
 Wed, 26 Nov 2025 09:14:02 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5APE2wJj699275; Wed, 26 Nov 2025 00:14:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 p5QdrYEIlTEp47uFjmzXBewruHUMgDNJOAx0jotUXQ=; b=XYrkEgNryUf4R71GT
 VvUjzHfqXJ8r0hC80RBoPUeNCx6VKarbtpgID2EGwY/1MJhYok+ETODwO2qa5CD9
 hDB9L5qmIi3EwVcCeMQVTbi3B4B1/jpqVnBVQvwy3fVAFp9lk4zLXKWshexLRNh+
 plDBHzmHN0aBE5rQAJKCt43JCUVSLRDEXwfuvXE5mBUoxbD9mAsKU/7+9EfqRsyC
 0NxtTebXrDbnAD593LdJFCyurRTqRt5xOLnN4Ddl1WHHayYFIEDBUWxAgWvfvqsm
 ns+P3nRsGGTVVm63TKBtmzZVqlQmpycD4efMY6xBTH2x4NiPPVjXF9LyivHAN33U
 VXweA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4amxrav0fd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Nov 2025 00:14:01 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 26 Nov 2025 00:13:59 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 26 Nov 2025 00:13:59 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.21.218])
 by maili.marvell.com (Postfix) with ESMTP id 580423F7040;
 Wed, 26 Nov 2025 00:13:56 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v3] event/cnxk: fix offload flags
Date: Wed, 26 Nov 2025 13:43:53 +0530
Message-ID: <20251126081353.85811-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126063711.42115-1-pbhagavatula@marvell.com>
References: <20251126063711.42115-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Xu/3+FF9 c=1 sm=1 tr=0 ts=6926b6c9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=RY_15DkwN-dEklQYqroA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: _cVB4KyYRRaae9lbKwduXYPBQ3kt-uwm
X-Proofpoint-ORIG-GUID: _cVB4KyYRRaae9lbKwduXYPBQ3kt-uwm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDA2NiBTYWx0ZWRfX6bmsI/nQVvDy
 t0uLq2gT/emhfNB07L2w8UTIJc+ChqsMqJFhGT/U3bKR4nZsE4fLTNBFufoKXsaO3nX9XQ9D0CR
 glwPqymhDZVMuu9BGjLfwzMOmRbPaWcehCSCGJaQXG4xBl5bSkFBis6sV1LOaJE4/74hfkKJ+bJ
 KHV/3FX7qt5CrT5uu+eU1V7zBJyfLRLJnmdV5OWklj9nd+rOvZ+qphAAqBeJwNnSWT/P2fL4hky
 KBV7iDoiqGIQTyAy5qic7YegVBPMyxmBVNJAI9wDwutrCMxMOWoRj4Ys8P7EywASY1Ev7XXJIf0
 FVmEzTlepRkdce7kl0WKkg4GAlCuBD9VCQ0IZHxRJ8K80XInIDF18PE+Stc7+aCSDJLQCN6AWuD
 4dLbcP0GMXVqFxnLRjhHCBBxgcPOjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
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

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

Use device configured Rx offloads instead of hardcoded values while
draining work.

Fixes: e8594de2731d ("event/cnxk: implement event port quiesce function")
Cc: stable@dpdk.org

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
v3 Changes:
v2 Changes:
- Fix build

 drivers/event/cnxk/cn10k_eventdev.c | 9 +++------
 drivers/event/cnxk/cn10k_worker.h   | 6 +++---
 drivers/event/cnxk/cn20k_eventdev.c | 8 +++-----
 drivers/event/cnxk/cn20k_worker.h   | 4 ++--
 drivers/net/cnxk/cn10k_rx.h         | 4 ++--
 drivers/net/cnxk/cn20k_rx.h         | 4 ++--
 6 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn10k_eventdev.c
index 3832eb7e000f..0c1431b4e70c 100644
--- a/drivers/event/cnxk/cn10k_eventdev.c
+++ b/drivers/event/cnxk/cn10k_eventdev.c
@@ -126,8 +126,7 @@ cn10k_sso_hws_flush_events(void *hws, uint8_t queue_id, uintptr_t base,

 	while (aq_cnt || cq_ds_cnt || ds_cnt) {
 		plt_write64(req, ws->base + SSOW_LF_GWS_OP_GET_WORK0);
-		cn10k_sso_hws_get_work_empty(
-			ws, &ev, (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_REAS_F | NIX_RX_MULTI_SEG_F);
+		cn10k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
 		if (fn != NULL && ev.u64 != 0)
 			fn(arg, ev);
 		if (ev.sched_type != SSO_TT_EMPTY)
@@ -473,8 +472,7 @@ cn10k_sso_port_quiesce(struct rte_eventdev *event_dev, void *port,
 	} while (ptag &
 		 (BIT_ULL(62) | BIT_ULL(58) | BIT_ULL(56) | BIT_ULL(54)));

-	cn10k_sso_hws_get_work_empty(ws, &ev,
-				     (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_REAS_F | NIX_RX_MULTI_SEG_F);
+	cn10k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
 	if (is_pend && ev.u64)
 		if (flush_cb)
 			flush_cb(event_dev->data->dev_id, ev, args);
@@ -503,8 +501,7 @@ cn10k_sso_port_quiesce(struct rte_eventdev *event_dev, void *port,
 	    SSO_TT_EMPTY) {
 		plt_write64(BIT_ULL(16) | 1,
 			    ws->base + SSOW_LF_GWS_OP_GET_WORK0);
-		cn10k_sso_hws_get_work_empty(
-			ws, &ev, (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_REAS_F | NIX_RX_MULTI_SEG_F);
+		cn10k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
 		if (ev.u64) {
 			if (flush_cb)
 				flush_cb(event_dev->data->dev_id, ev, args);
diff --git a/drivers/event/cnxk/cn10k_worker.h b/drivers/event/cnxk/cn10k_worker.h
index 954dee5a2a9e..9b6abdf18db2 100644
--- a/drivers/event/cnxk/cn10k_worker.h
+++ b/drivers/event/cnxk/cn10k_worker.h
@@ -52,12 +52,12 @@ cn10k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 	uint64_t mbuf_init = 0x100010000ULL | RTE_PKTMBUF_HEADROOM;
 	struct cnxk_timesync_info *tstamp = ws->tstamp[port_id];
 	void *lookup_mem = ws->lookup_mem;
+	uint64_t meta_aura = 0, laddr = 0;
+	uint16_t lmt_id = 0, d_off = 0;
 	uintptr_t lbase = ws->lmt_base;
-	uint64_t meta_aura = 0, laddr;
+	struct rte_mempool *mp = NULL;
 	struct rte_event_vector *vec;
 	uint16_t nb_mbufs, non_vec;
-	struct rte_mempool *mp;
-	uint16_t lmt_id, d_off;
 	struct rte_mbuf **wqe;
 	struct rte_mbuf *mbuf;
 	uint64_t sa_base = 0;
diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index b25e570211f1..1c5d9272398a 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -192,7 +192,7 @@ cn20k_sso_hws_flush_events(void *hws, uint8_t queue_id, uintptr_t base, cnxk_han

 	while (aq_cnt || cq_ds_cnt || ds_cnt) {
 		plt_write64(req, ws->base + SSOW_LF_GWS_OP_GET_WORK0);
-		cn20k_sso_hws_get_work_empty(ws, &ev, 0);
+		cn20k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
 		if (fn != NULL && ev.u64 != 0)
 			fn(arg, ev);
 		if (ev.sched_type != SSO_TT_EMPTY)
@@ -521,8 +521,7 @@ cn20k_sso_port_quiesce(struct rte_eventdev *event_dev, void *port,
 		ptag = plt_read64(ws->base + SSOW_LF_GWS_PENDSTATE);
 	} while (ptag & (BIT_ULL(62) | BIT_ULL(58) | BIT_ULL(56) | BIT_ULL(54)));

-	cn20k_sso_hws_get_work_empty(ws, &ev,
-				     (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_REAS_F | NIX_RX_MULTI_SEG_F);
+	cn20k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
 	if (is_pend && ev.u64)
 		if (flush_cb)
 			flush_cb(event_dev->data->dev_id, ev, args);
@@ -548,8 +547,7 @@ cn20k_sso_port_quiesce(struct rte_eventdev *event_dev, void *port,

 	if (CNXK_TT_FROM_TAG(plt_read64(ws->base + SSOW_LF_GWS_PRF_WQE0)) != SSO_TT_EMPTY) {
 		plt_write64(BIT_ULL(16) | 1, ws->base + SSOW_LF_GWS_OP_GET_WORK0);
-		cn20k_sso_hws_get_work_empty(
-			ws, &ev, (NIX_RX_OFFLOAD_MAX - 1) | NIX_RX_REAS_F | NIX_RX_MULTI_SEG_F);
+		cn20k_sso_hws_get_work_empty(ws, &ev, dev->rx_offloads);
 		if (ev.u64) {
 			if (flush_cb)
 				flush_cb(event_dev->data->dev_id, ev, args);
diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_worker.h
index df0abd9202fd..608f93dcd465 100644
--- a/drivers/event/cnxk/cn20k_worker.h
+++ b/drivers/event/cnxk/cn20k_worker.h
@@ -54,12 +54,12 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 	struct cnxk_timesync_info *tstamp = ws->tstamp[port_id];
 	uint8_t m_sz = sizeof(struct rte_mbuf);
 	void *lookup_mem = ws->lookup_mem;
+	uint64_t meta_aura = 0, laddr = 0;
 	uintptr_t lbase = ws->lmt_base;
-	uint64_t meta_aura = 0, laddr;
+	uint16_t lmt_id = 0, d_off = 0;
 	struct rte_event_vector *vec;
 	uint16_t nb_mbufs, non_vec;
 	struct rte_mempool *mp;
-	uint16_t lmt_id, d_off;
 	struct rte_mbuf **wqe;
 	struct rte_mbuf *mbuf;
 	uint64_t sa_base = 0;
diff --git a/drivers/net/cnxk/cn10k_rx.h b/drivers/net/cnxk/cn10k_rx.h
index e79306e6467f..ef3bf454536d 100644
--- a/drivers/net/cnxk/cn10k_rx.h
+++ b/drivers/net/cnxk/cn10k_rx.h
@@ -1464,9 +1464,9 @@ cn10k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts,
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3;
 	uint8_t loff = 0, lnum = 0, shft = 0;
 	struct rte_mempool *meta_pool = NULL;
+	uint16_t lmt_id = 0, d_off = 0;
+	uint64_t lbase = 0, laddr = 0;
 	uint8x16_t f0, f1, f2, f3;
-	uint16_t lmt_id, d_off;
-	uint64_t lbase, laddr;
 	uintptr_t sa_base = 0;
 	uint16_t packets = 0;
 	uint16_t pkts_left;
diff --git a/drivers/net/cnxk/cn20k_rx.h b/drivers/net/cnxk/cn20k_rx.h
index 56826318151a..d859c53c20b3 100644
--- a/drivers/net/cnxk/cn20k_rx.h
+++ b/drivers/net/cnxk/cn20k_rx.h
@@ -307,7 +307,7 @@ nix_cqe_xtract_mseg(const union nix_rx_parse_u *rx, struct rte_mbuf *mbuf, uint6
 	const struct cpt_parse_hdr_s *hdr = (const struct cpt_parse_hdr_s *)cpth;
 	struct cn20k_inb_priv_data *inb_priv = NULL;
 	const struct cpt_frag_info_s *finfo = NULL;
-	uint64_t fsz_w1 = 0, cq_w1, cq_w5, sg;
+	uint64_t fsz_w1 = 0, cq_w1, cq_w5 = 0, sg;
 	uint32_t offset = hdr->w2.ptr_offset;
 	uint8_t num_frags = 0, nxt_frag = 0;
 	struct rte_mbuf *head, *last_mbuf;
@@ -845,8 +845,8 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 	uint64x2_t rearm2 = vdupq_n_u64(mbuf_initializer);
 	uint64x2_t rearm3 = vdupq_n_u64(mbuf_initializer);
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3;
+	uint64_t lbase, laddr = 0, buf_sz = 0;
 	uint8_t loff = 0, lnum = 0, shft = 0;
-	uint64_t lbase, laddr, buf_sz;
 	uint8x16_t f0, f1, f2, f3;
 	uint16_t lmt_id, d_off;
 	uintptr_t sa_base = 0;
--
2.50.1 (Apple Git-155)

