Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B8ED0EE13
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 19:11:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B818840615;
	Tue, 25 Nov 2025 20:11:13 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 31D6B402E1;
 Tue, 25 Nov 2025 20:11:12 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5APAAvAO079774; Tue, 25 Nov 2025 11:11:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=/eKFZuTDT92rnswmu3P2mvF
 mURWF7IhW3O4XN1wqF+Y=; b=i5B1v+ucTuHalG8OhAb4xSRwyo+0CEr+zn9bTq6
 i4A7BU6kP+rx+fhr8vdmoZx0hKd3sCo3VQMzk8TeuvMLb1fnYcLEWckvYnYQo+LF
 +NlObzgnXPsK6r/ChPGwd7hIQB/KwuZZqN7j1CcbEabXQL8Uc9FLZvYLPjsH1Cca
 ruXMNUsiKJUw+tv0/N/MhZ0ZUNgC5k81ITN5fsCxtnrJ2dHVy060hGUWAYXM8F+N
 mGCd3qUoOnLjQDN+LvU/+MD2qGJIUcQmfX/ejdPB60bkla0MXM9I87QlKDuZ139+
 oAJ6y2ZZ2EDFnEYtUjtUTWoszeL02k7bXHGYEi6igKvq3gQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4an9rg97p9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Nov 2025 11:11:11 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 25 Nov 2025 11:11:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 25 Nov 2025 11:11:22 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.162.180])
 by maili.marvell.com (Postfix) with ESMTP id 9E1433F7057;
 Tue, 25 Nov 2025 11:11:07 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>, Sunil Kumar Kori
 <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>, Harman Kalra
 <hkalra@marvell.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] event/cnxk: fix offload flags
Date: Wed, 26 Nov 2025 00:41:00 +0530
Message-ID: <20251125191102.5324-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pEcRzFlalenMtKQeSBj5KrcA6fdrVuYh
X-Authority-Analysis: v=2.4 cv=ArjjHe9P c=1 sm=1 tr=0 ts=6925ff4f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=KuZvRlp7QCyoPc1D7o0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-ORIG-GUID: pEcRzFlalenMtKQeSBj5KrcA6fdrVuYh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MCBTYWx0ZWRfX+DUiMmqbvv4c
 7tW0n1qO/a3KkyseW5r6QRU1nyB6H5eBFM+6RADJujAXg4LBXn9SmjkLNDBYJn5oh7m96R+GICe
 jN4imAjlUxq2R6ofozHlVBiv5zEqDYDRIBDQ3ungAWcPBsyHaQHTW5DA32FF+OqI1lNTraQPJLS
 DdnQ+sSGXCRnH9ed1OY/hRv846poQHoMPjzIomNdymay/AV9jrkld5cXz74ZwhK6eplR+UCCGgN
 ldxZu1RSsOWzjaOby5rcVrNH3q4t4smi+Ag3VyKNPYAfu9u5mnby78CTeUZeSrZNMlw8jJGLHNq
 lAo8MUyRY2l8UU+q7D+L4EBHMDSjviyFhxL3IvD9Q0G1KEa9AP0gqfHZGumlNEYVLLZaqrnVN1M
 sOKEZ8g1a7N9as+Eak4rjdZsFQq8jg==
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
 drivers/event/cnxk/cn10k_eventdev.c | 9 +++------
 drivers/event/cnxk/cn10k_worker.h   | 4 ++--
 drivers/event/cnxk/cn20k_eventdev.c | 8 +++-----
 drivers/net/cnxk/cn10k_rx.h         | 4 ++--
 4 files changed, 10 insertions(+), 15 deletions(-)

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
index 954dee5a2a9e..e612d5634eb9 100644
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
 	struct rte_event_vector *vec;
 	uint16_t nb_mbufs, non_vec;
 	struct rte_mempool *mp;
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
-- 
2.50.1 (Apple Git-155)

