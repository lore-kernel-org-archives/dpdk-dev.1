Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FF2D3567F
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 06:04:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19AA940659;
	Wed, 28 Jan 2026 07:04:43 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7EAB240395
 for <dev@dpdk.org>; Wed, 28 Jan 2026 07:04:40 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60RGPxkc1390280 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=V
 j460FHAmMy5WpDLS8SxbaKR4okR7PkCVqiKnbH2+Dk=; b=h0VGBPXNKbcr4UEEw
 nBizS6QCnsPUIVyOW/kgh1Owf2zd+NJppIituXTpFsctGex203GrgnA/J4yb90tM
 s4pwrwkvBtk7lYBSw8u1zkSiivBCg7P+eRBQ1AdRpfxpKFeyXPkfBNYllz1vytW1
 ioxlv31F0nCuSCYIanDHYFnYqVw1n192S9KI/9QtPpLPPpifeDfbrD82i/TI5KCU
 BnmAvgjbgKkLbOeskf60jJipWd3F4VVGVAWtnf583VCDFzYlRxdn3F82qqnsFL5F
 HXi1tcxPWkdFuNFNVC6Tb0NOQwONKkAI8mpha8R+yWZd8JleGQZtuTHab7rp4Zjh
 92Z6Q==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bx0qsws5b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 Jan 2026 22:04:39 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 Jan 2026 22:04:54 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 27 Jan 2026 22:04:54 -0800
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 9CE043F706F;
 Tue, 27 Jan 2026 22:04:36 -0800 (PST)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>, "Shijith
 Thotton" <sthotton@marvell.com>
CC: <jerinj@marvell.com>, Rahul Bhansali <rbhansali@marvell.com>
Subject: [PATCH 13/18] event/cnxk: update fastpath function for OOP
Date: Wed, 28 Jan 2026 11:33:11 +0530
Message-ID: <20260128060316.3967610-13-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260128060316.3967610-1-rbhansali@marvell.com>
References: <20260128060316.3967610-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA0NiBTYWx0ZWRfX2G2dTlz8sO7T
 com7VlhvJLk9z/zIPdvOqpI4M/p5cwvzmtP8fVXM24Qvwu31nMM1o0YoeU+2g0zQcIvSTiSuolC
 Iexfc7DGgWEXn2jvYI2neZOwSb/mVuzkE3khpLqvYF7GxTv4xz+KqGesth+bhC4mUTmd63nVUn5
 9GwpH6Bz5rVI08F7lDv1GRwnFWGKvu5VQAJR5VUydjzcdgyIu13s7pThnORa8Ydka6A7Y5J67gK
 AFFM+cF2rnWq/euBhj6LyjgIvrXnlGKJNhuoBg/l+Z+g7ecuSSJlTna5te0ZquQOs0Tb/c4fXmo
 nBAdTVBvYH2JyVuNVfThjnlJs9BcwmMXpIPd5K4sVasEyI8OSdIYaIRKesx8tl0WVnLYUDKNn8i
 GzaxL7qbbLSeHEEZJewjXfsOJwVva4E3Nb3g+wZP+NrRwa6T3If0cO7wBz/OwKFJPiTH2ZK9iGs
 GBWGzoADyKXFCNGiSGw==
X-Authority-Analysis: v=2.4 cv=P9E3RyAu c=1 sm=1 tr=0 ts=6979a6f7 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=BSXEXfJAdv2J5j87F9MA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: EaiD4la3BeN5PLGZsQTumaPf9Jio3L6R
X-Proofpoint-GUID: EaiD4la3BeN5PLGZsQTumaPf9Jio3L6R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_05,2026-01-27_03,2025-10-01_01
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

Update fastpath functions to support non inplace (OOP).

Signed-off-by: Rahul Bhansali <rbhansali@marvell.com>
---
 drivers/event/cnxk/cn20k_eventdev.c | 18 +++++++++++++++++
 drivers/event/cnxk/cn20k_worker.h   | 30 +++++++++++++++++++++--------
 2 files changed, 40 insertions(+), 8 deletions(-)

diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index 1c5d927239..ff3aaac16a 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -710,6 +710,23 @@ cn20k_sso_tstamp_hdl_update(uint16_t port_id, uint16_t flags, bool ptp_en)
 	eventdev_fops_tstamp_update(event_dev);
 }
 
+static void
+cn20k_sso_rx_offload_cb(uint16_t port_id, uint64_t flags)
+{
+	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
+	struct cnxk_eth_dev *cnxk_eth_dev = dev->data->dev_private;
+	struct rte_eventdev *event_dev = cnxk_eth_dev->evdev_priv;
+	struct cnxk_sso_evdev *evdev;
+
+	if (event_dev == NULL)
+		return;
+
+	evdev = cnxk_sso_pmd_priv(event_dev);
+	evdev->rx_offloads |= flags;
+	cn20k_sso_fp_fns_set((struct rte_eventdev *)(uintptr_t)event_dev);
+	eventdev_fops_tstamp_update(event_dev);
+}
+
 static int
 cn20k_sso_rxq_enable(struct cnxk_eth_dev *cnxk_eth_dev, uint16_t rq_id, uint16_t port_id,
 		     const struct rte_event_eth_rx_adapter_queue_conf *queue_conf, int agq)
@@ -1241,6 +1258,7 @@ cn20k_sso_init(struct rte_eventdev *event_dev)
 		return rc;
 	}
 
+	cnxk_ethdev_rx_offload_cb_register(cn20k_sso_rx_offload_cb);
 	event_dev->dev_ops = &cn20k_sso_dev_ops;
 	/* For secondary processes, the primary has done all the work */
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
diff --git a/drivers/event/cnxk/cn20k_worker.h b/drivers/event/cnxk/cn20k_worker.h
index 608f93dcd4..6442113e09 100644
--- a/drivers/event/cnxk/cn20k_worker.h
+++ b/drivers/event/cnxk/cn20k_worker.h
@@ -18,15 +18,11 @@
 static __rte_always_inline void
 cn20k_wqe_to_mbuf(uint64_t wqe, const uint64_t __mbuf, uint8_t port_id, const uint32_t tag,
 		  const uint32_t flags, const void *const lookup_mem, uintptr_t cpth,
-		  uintptr_t sa_base)
+		  uintptr_t sa_base, uint64_t buf_sz)
 {
 	const uint64_t mbuf_init =
 		0x100010000ULL | RTE_PKTMBUF_HEADROOM | (flags & NIX_RX_OFFLOAD_TSTAMP_F ? 8 : 0);
 	struct rte_mbuf *mbuf = (struct rte_mbuf *)__mbuf;
-	uint64_t buf_sz = 0;
-
-	if (flags & NIX_RX_REAS_F)
-		buf_sz = cnxk_nix_inl_bufsize_get(port_id, lookup_mem);
 
 	cn20k_nix_cqe_to_mbuf((struct nix_cqe_hdr_s *)wqe, tag, (struct rte_mbuf *)mbuf, lookup_mem,
 			      mbuf_init | ((uint64_t)port_id) << 48, cpth, sa_base, buf_sz, flags);
@@ -66,6 +62,8 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 	uint64_t buf_sz = 0;
 	uintptr_t cpth = 0;
 	uint8_t loff = 0;
+	uint64_t w4;
+	bool is_oop;
 	int i;
 
 	mbuf_init |= ((uint64_t)port_id) << 48;
@@ -136,7 +134,12 @@ cn20k_process_vwqe(uintptr_t vwqe, uint16_t port_id, const uint32_t flags, struc
 				 */
 				*(uint64_t *)(laddr + (loff << 3)) = (uint64_t)mbuf;
 				loff = loff + 1;
-				mbuf = (struct rte_mbuf *)(*(uint64_t *)(cpth + 8) - m_sz);
+				w4 = *(uint64_t *)(cpth + 32);
+				is_oop = !((w4 >> 32) & 0x3) && ((w4 & 0xffffffff) == 1);
+				if ((flags & NIX_RX_REAS_F) && is_oop)
+					mbuf = nix_sec_oop_process(cpth, buf_sz);
+				else
+					mbuf = (struct rte_mbuf *)(*(uint64_t *)(cpth + 8) - m_sz);
 				/* Mark inner mbuf as get */
 				RTE_MEMPOOL_CHECK_COOKIES(mbuf->pool, (void **)&mbuf, 1, 1);
 			}
@@ -176,6 +179,7 @@ cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32
 		u64[1] = cn20k_cpt_crypto_adapter_vector_dequeue(u64[1]);
 	} else if (CNXK_EVENT_TYPE_FROM_TAG(u64[0]) == RTE_EVENT_TYPE_ETHDEV) {
 		uint8_t port = CNXK_SUB_EVENT_FROM_TAG(u64[0]);
+		uint64_t buf_sz = 0;
 		uintptr_t cpth = 0;
 		uint64_t mbuf;
 
@@ -194,6 +198,8 @@ cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32
 			uint8_t loff = 0;
 			uint16_t d_off;
 			uint64_t cq_w1;
+			uint64_t w4;
+			bool is_oop;
 
 			m = (struct rte_mbuf *)mbuf;
 			d_off = (*(uint64_t *)(u64[1] + 72)) - (uintptr_t)m;
@@ -210,12 +216,20 @@ cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32
 				/* Mark meta mbuf as put */
 				RTE_MEMPOOL_CHECK_COOKIES(m->pool, (void **)&m, 1, 0);
 
+				if (flags & NIX_RX_REAS_F)
+					buf_sz = cnxk_nix_inl_bufsize_get(port, lookup_mem);
 				/* Store meta in lmtline to free
 				 * Assume all meta's from same aura.
 				 */
 				*(uint64_t *)((uintptr_t)&iova + (loff << 3)) = (uint64_t)m;
 				loff = loff + 1;
-				mbuf = (uint64_t)(*(uint64_t *)(cpth + 8) - m_sz);
+				w4 = *(uint64_t *)(cpth + 32);
+				is_oop = !((w4 >> 32) & 0x3) && ((w4 & 0xffffffff) == 1);
+				if ((flags & NIX_RX_REAS_F) && is_oop)
+					mbuf = (uint64_t)nix_sec_oop_process(cpth, buf_sz);
+				else
+					mbuf = (uint64_t)(*(uint64_t *)(cpth + 8) - m_sz);
+
 				/* Mark inner mbuf as get */
 				RTE_MEMPOOL_CHECK_COOKIES(((struct rte_mbuf *)mbuf)->pool,
 							  (void **)&mbuf, 1, 1);
@@ -225,7 +239,7 @@ cn20k_sso_hws_post_process(struct cn20k_sso_hws *ws, uint64_t *u64, const uint32
 
 		u64[0] = CNXK_CLR_SUB_EVENT(u64[0]);
 		cn20k_wqe_to_mbuf(u64[1], mbuf, port, u64[0] & 0xFFFFF, flags, ws->lookup_mem, cpth,
-				  sa_base);
+				  sa_base, buf_sz);
 		if (flags & NIX_RX_OFFLOAD_TSTAMP_F)
 			cn20k_sso_process_tstamp(u64[1], mbuf, ws->tstamp[port]);
 		u64[1] = mbuf;
-- 
2.34.1

