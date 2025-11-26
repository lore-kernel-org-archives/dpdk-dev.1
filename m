Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3395BD11181
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 15:54:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0570C40B90;
	Wed, 26 Nov 2025 16:54:07 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7990D402D1;
 Wed, 26 Nov 2025 16:54:05 +0100 (CET)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AQ97W3J890105; Wed, 26 Nov 2025 07:54:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=l
 j6khnrt64EMJH6AcKO9raYJlDj67QqFdOi95WOE6Zo=; b=W/t47MvqDJyJU2CrJ
 wQMgYp2xCY3V7AMDmMbeNdvxp0qWE9oTb6hwoGXWkhQ++YZ6PveBOsej4pU8jPi8
 5FVmmBpilMhaeBESlroZ5DIlpesvYML1VmtkmYmDtPn1MOiVihF2b8lFvmdQq1pm
 6MyAh3xjAJVvHWmgAlRn//oiOAafBs/+7mXO1YvqYjyR1qLIlrx/1gmewUdDfh5W
 FUcciEgbfQtZrgPk06nFxjNijry7VOC6R5du8f9feytTZll4FpQ5wn5xsNV2mfMW
 CAiZxv5nRQ5MX3FpAQXsaiF/HMzX2tBoZ9TobACkdf2mE/D4I9UlTM5btjclZbtP
 k731w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4anxn38s2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Nov 2025 07:54:04 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 26 Nov 2025 07:54:03 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Wed, 26 Nov 2025 07:54:03 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.162.180])
 by maili.marvell.com (Postfix) with ESMTP id B1D983F704E;
 Wed, 26 Nov 2025 07:54:00 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v4] event/cnxk: fix offload flags
Date: Wed, 26 Nov 2025 21:23:57 +0530
Message-ID: <20251126155358.16973-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251126081353.85811-1-pbhagavatula@marvell.com>
References: <20251126081353.85811-1-pbhagavatula@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI2MDEzMCBTYWx0ZWRfXzOmKqeP9RFGQ
 O0yQXO+IcB+u2aDbrxVq0KL1kMhoF2gEDvqhd+4NEB0TKAkg/K2giBkpl6Mg0Fa5lJjDMbG6dNA
 5zMTwA43XHqImE6vRtkxG2eLdMV+2fdNPotYRn2WMpYHMbe5WcdlVnDj7YXj130xFPW96RUnVb1
 d+3ByuxcXolqorq85BzX+QaFjgmiJKEyDOmwXqoZowdChvHexnZrX3dJsur/ppw9pagdTheRimL
 Bpf/9KZHzqsyldmoniJIXPJBx1nNKtccLtlCAXdF0s0oK0d/uEVPQNrRpaXbtNMYx5xREtGYNgs
 SMGIU5J5imNqj27mYlGvIt4nsQDszGPtQ4pGCJ6Lk/DFRqg21EtpClRlwMyby8hc3ad80yWCoAx
 SltoOSvhhy4RzoILBx8IubHJ0GAsEw==
X-Proofpoint-GUID: PBmPBgZ0f5gnOhAXfNnQzMbXbAuhJJsX
X-Proofpoint-ORIG-GUID: PBmPBgZ0f5gnOhAXfNnQzMbXbAuhJJsX
X-Authority-Analysis: v=2.4 cv=V75wEOni c=1 sm=1 tr=0 ts=6927229c cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=XqVrFLBCjQdvZhaufdEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
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
 drivers/event/cnxk/cn10k_eventdev.c | 9 +++------
 drivers/event/cnxk/cn10k_worker.h   | 6 +++---
 drivers/event/cnxk/cn20k_eventdev.c | 8 +++-----
 drivers/event/cnxk/cn20k_worker.h   | 4 ++--
 drivers/net/cnxk/cn10k_rx.h         | 6 +++---
 drivers/net/cnxk/cn20k_rx.h         | 6 +++---
 6 files changed, 17 insertions(+), 22 deletions(-)

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
index e79306e6467f..e55910b57599 100644
--- a/drivers/net/cnxk/cn10k_rx.h
+++ b/drivers/net/cnxk/cn10k_rx.h
@@ -572,7 +572,7 @@ nix_sec_meta_to_mbuf(uint64_t cq_w1, uint64_t cq_w5, uintptr_t inb_sa,
 	const struct cpt_cn10k_parse_hdr_s *hdr =
 		(const struct cpt_cn10k_parse_hdr_s *)cpth;
 	uint64_t mbuf_init = vgetq_lane_u64(*rearm, 0);
-	struct cn10k_inb_priv_data *inb_priv;
+	struct cn10k_inb_priv_data *inb_priv = NULL;
 	uintptr_t p;
 
 	/* Clear checksum flags */
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
index 56826318151a..1944e507b0b2 100644
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
@@ -845,10 +845,10 @@ cn20k_nix_recv_pkts_vector(void *args, struct rte_mbuf **mbufs, uint16_t pkts, c
 	uint64x2_t rearm2 = vdupq_n_u64(mbuf_initializer);
 	uint64x2_t rearm3 = vdupq_n_u64(mbuf_initializer);
 	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3;
+	uint64_t lbase = 0, laddr = 0, buf_sz = 0;
 	uint8_t loff = 0, lnum = 0, shft = 0;
-	uint64_t lbase, laddr, buf_sz;
+	uint16_t lmt_id = 0, d_off;
 	uint8x16_t f0, f1, f2, f3;
-	uint16_t lmt_id, d_off;
 	uintptr_t sa_base = 0;
 	uint16_t packets = 0;
 	uint16_t pkts_left;
-- 
2.50.1 (Apple Git-155)

