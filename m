Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D8C83F1B
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Jul 2025 05:58:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEEF5402DE;
	Mon, 14 Jul 2025 07:58:57 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 0627840041;
 Mon, 14 Jul 2025 07:58:55 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E22kA1017820;
 Sun, 13 Jul 2025 22:58:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=N1FMwl0MH2xod3XK7PSTzjo
 iswhEfyPCe9HK6lLs3nI=; b=V7SUNCf6kijbdAm48uuvdz/95UXhE45sIJ83ojA
 Z8ZVoQEkNa3tZL9W+fTAMvdl1twS/XZyopZb2I4wGDcEF2XbnT3Gnq0N1ud6krxa
 R9SwzGL4T+xvWueVGe3D220v0nHAkrD1Ff5J2fj9+x81sEN9PENLIpgDrp7iYjI6
 OV7egBZTAkzBJ13cyIvgCGIbzBFi//WQ/bjUa5BXe/icjLEgsaUrBPfa3zoImWyE
 5MkO67DwPDccgj2b70p9NDSc1DoZs7ToMvUmneXM90L7D65Cc8rmBVVhGV1Axi26
 ImTqAHJamej97mmlGfoCRFjypwgd0RlPf6iHDtrbEMztFaw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 47vrrrrepu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 13 Jul 2025 22:58:54 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 13 Jul 2025 22:58:53 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 13 Jul 2025 22:58:53 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id AFB933F7060;
 Sun, 13 Jul 2025 22:58:51 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <jerinj@marvell.com>
CC: <dev@dpdk.org>, Vamsi Attunuru <vattunuru@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v0 1/1] net/octeon_ep: fix device start routine
Date: Mon, 14 Jul 2025 11:28:49 +0530
Message-ID: <20250714055849.2258453-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=B4e50PtM c=1 sm=1 tr=0 ts=68749c9f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=Wb1JkmetP80A:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=ZF-NUbdH-7KY46_Hy40A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDAzMyBTYWx0ZWRfXwC/PCX+jQVID
 nPPQuxUa7ZR3RBQlLXHyUfVWVwdwaVydxOgHjP+m9aTErI6hPp571NryRGySeE1OsqIF/sPBsIJ
 GYQOs7tQg7hf4NmGkIJ4mEpU88xDuXbDlL2B+xhbFsJbHfjjgBXxyXHdpbg6lyTUIM5+/mzj2Hv
 gbpnbXGqI4FC3ihnJgLn8+PnkgZYrF9HK7nu+4u5BAlH0Uihz1v7wYLW6NIgynvcmJqR6BWhV1S
 glxwYlRR1ZvVVhvteYmdP4aUjijjkhoTQfDw3QEoVk5K521qTeez0UUe+Qq+aEr8ZYLx6Rl1cA4
 CX9hnSDSKWRodaMd2mKJtsFgBnUEtO+b7DBj1GWUBejUmLlj37kt7EtESYRpT1PMSg9icxC6JO8
 xlbE7w+3suh934jj43bsIwqqQSu9cntpObTENZu/2iWaPR/pmkv5nypcy1ux0EqmgwtSPBqC
X-Proofpoint-ORIG-GUID: HWuCcN71sgb7VKz_F9u5xQIRpgS7_ysN
X-Proofpoint-GUID: HWuCcN71sgb7VKz_F9u5xQIRpgS7_ysN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-09_01,2025-03-28_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Currently the device start routine clears the TX doorbell and
updates RX doorbell, which causes the device start operation
to fail after a device stop.

Patch corrects the handling of RX & TX doorbell and ensures
that any pending packets in the RX queue are drained and gets
refilled before starting the device.

Fixes: 2c82554c98bd ("net/octeontx_ep: add device start and stop")
Cc: stable@dpdk.org

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 drivers/net/octeon_ep/cnxk_ep_rx.c    | 40 +++++++++++++++++++++++++++
 drivers/net/octeon_ep/cnxk_ep_vf.c    | 32 ++++++++++-----------
 drivers/net/octeon_ep/otx2_ep_vf.c    | 30 +++++++++-----------
 drivers/net/octeon_ep/otx_ep_common.h |  1 +
 drivers/net/octeon_ep/otx_ep_ethdev.c |  6 ++++
 drivers/net/octeon_ep/otx_ep_rxtx.h   |  3 ++
 6 files changed, 77 insertions(+), 35 deletions(-)

diff --git a/drivers/net/octeon_ep/cnxk_ep_rx.c b/drivers/net/octeon_ep/cnxk_ep_rx.c
index 7465e0a017..ec2a1d96a6 100644
--- a/drivers/net/octeon_ep/cnxk_ep_rx.c
+++ b/drivers/net/octeon_ep/cnxk_ep_rx.c
@@ -154,3 +154,43 @@ cn9k_ep_recv_pkts_mseg(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pk
 
 	return new_pkts;
 }
+
+void
+cnxk_ep_drain_rx_pkts(void *rx_queue)
+{
+	struct otx_ep_droq *droq = (struct otx_ep_droq *)rx_queue;
+	struct rte_mbuf *rx_pkt, *next_seg, *seg;
+	uint16_t i, j, nb_pkts;
+
+	if (droq->read_idx == 0 && droq->pkts_pending == 0 && droq->refill_count)
+		return;
+
+	/* Check for pending packets */
+	nb_pkts = cnxk_ep_rx_pkts_to_process(droq, droq->nb_desc);
+
+	/* Drain the pending packets */
+	for (i = 0; i < nb_pkts; i++) {
+		rx_pkt = NULL;
+		cnxk_ep_process_pkts_scalar_mseg(&rx_pkt, droq, 1);
+		if (rx_pkt) {
+			seg = rx_pkt->next;
+			for (j = 1; j < rx_pkt->nb_segs; j++) {
+				next_seg = seg->next;
+				rte_mempool_put(droq->mpool, seg);
+				seg = next_seg;
+			}
+			rx_pkt->nb_segs = 1;
+			rte_mempool_put(droq->mpool, rx_pkt);
+		}
+	}
+
+	cnxk_ep_rx_refill(droq);
+
+	/* Reset the indexes */
+	droq->read_idx  = 0;
+	droq->write_idx = 0;
+	droq->refill_idx = 0;
+	droq->refill_count = 0;
+	droq->last_pkt_count = 0;
+	droq->pkts_pending = 0;
+}
diff --git a/drivers/net/octeon_ep/cnxk_ep_vf.c b/drivers/net/octeon_ep/cnxk_ep_vf.c
index ca84cac962..a1d9f65f38 100644
--- a/drivers/net/octeon_ep/cnxk_ep_vf.c
+++ b/drivers/net/octeon_ep/cnxk_ep_vf.c
@@ -138,6 +138,18 @@ cnxk_ep_vf_setup_iq_regs(struct otx_ep_device *otx_ep, uint32_t iq_no)
 		return -EIO;
 	}
 
+	/* Clear the IQ doorbell  */
+	loop = OTX_EP_BUSY_LOOP_COUNT;
+	while ((rte_read64(iq->doorbell_reg) != 0ull) && loop--) {
+		rte_write32(OTX_EP_CLEAR_INSTR_DBELL, iq->doorbell_reg);
+		rte_delay_ms(1);
+	}
+
+	if (loop < 0) {
+		otx_ep_err("INSTR DBELL is not zero");
+		return -EIO;
+	}
+
 	/* IN INTR_THRESHOLD is set to max(FFFFFFFF) which disable the IN INTR
 	 * to raise
 	 */
@@ -237,8 +249,8 @@ cnxk_ep_vf_setup_oq_regs(struct otx_ep_device *otx_ep, uint32_t oq_no)
 	droq->pkts_sent_ism =
 		(uint32_t __rte_atomic *)((uint8_t *)otx_ep->ism_buffer_mz->addr
 			     + CNXK_EP_OQ_ISM_OFFSET(oq_no));
-	otx_ep_err("SDP_R[%d] OQ ISM virt: %p dma: 0x%" PRIX64,
-		    oq_no, (void *)(uintptr_t)droq->pkts_sent_ism, ism_addr);
+	otx_ep_dbg("SDP_R[%d] OQ ISM virt: %p dma: 0x%" PRIX64, oq_no,
+		   (void *)(uintptr_t)droq->pkts_sent_ism, ism_addr);
 	*droq->pkts_sent_ism = 0;
 	droq->pkts_sent_prev = 0;
 
@@ -266,24 +278,8 @@ cnxk_ep_vf_setup_oq_regs(struct otx_ep_device *otx_ep, uint32_t oq_no)
 static int
 cnxk_ep_vf_enable_iq(struct otx_ep_device *otx_ep, uint32_t q_no)
 {
-	int loop = OTX_EP_BUSY_LOOP_COUNT;
 	uint64_t reg_val = 0ull;
 
-	/* Resetting doorbells during IQ enabling also to handle abrupt
-	 * guest reboot. IQ reset does not clear the doorbells.
-	 */
-	oct_ep_write64(0xFFFFFFFF, otx_ep->hw_addr + CNXK_EP_R_IN_INSTR_DBELL(q_no));
-
-	while (((oct_ep_read64(otx_ep->hw_addr +
-		 CNXK_EP_R_IN_INSTR_DBELL(q_no))) != 0ull) && loop--) {
-		rte_delay_ms(1);
-	}
-
-	if (loop < 0) {
-		otx_ep_err("INSTR DBELL not coming back to 0");
-		return -EIO;
-	}
-
 	reg_val = oct_ep_read64(otx_ep->hw_addr + CNXK_EP_R_IN_ENABLE(q_no));
 	reg_val |= 0x1ull;
 
diff --git a/drivers/net/octeon_ep/otx2_ep_vf.c b/drivers/net/octeon_ep/otx2_ep_vf.c
index a482f4266e..00f723a5a8 100644
--- a/drivers/net/octeon_ep/otx2_ep_vf.c
+++ b/drivers/net/octeon_ep/otx2_ep_vf.c
@@ -287,6 +287,18 @@ otx2_vf_setup_iq_regs(struct otx_ep_device *otx_ep, uint32_t iq_no)
 		return -EIO;
 	}
 
+	/* Clear the IQ doorbell  */
+	loop = OTX_EP_BUSY_LOOP_COUNT;
+	while ((rte_read64(iq->doorbell_reg) != 0ull) && loop--) {
+		rte_write32(OTX_EP_CLEAR_INSTR_DBELL, iq->doorbell_reg);
+		rte_delay_ms(1);
+	}
+
+	if (loop < 0) {
+		otx_ep_err("INSTR DBELL is not zero");
+		return -EIO;
+	}
+
 	/* IN INTR_THRESHOLD is set to max(FFFFFFFF) which disable the IN INTR
 	 * to raise
 	 */
@@ -388,7 +400,7 @@ otx2_vf_setup_oq_regs(struct otx_ep_device *otx_ep, uint32_t oq_no)
 	droq->pkts_sent_ism =
 		(uint32_t __rte_atomic *)((uint8_t *)otx_ep->ism_buffer_mz->addr
 			     + OTX2_EP_OQ_ISM_OFFSET(oq_no));
-	otx_ep_err("SDP_R[%d] OQ ISM virt: %p, dma: 0x%x", oq_no,
+	otx_ep_dbg("SDP_R[%d] OQ ISM virt: %p, dma: 0x%x", oq_no,
 		   (void *)(uintptr_t)droq->pkts_sent_ism,
 		   (unsigned int)ism_addr);
 	*droq->pkts_sent_ism = 0;
@@ -411,24 +423,8 @@ otx2_vf_setup_oq_regs(struct otx_ep_device *otx_ep, uint32_t oq_no)
 static int
 otx2_vf_enable_iq(struct otx_ep_device *otx_ep, uint32_t q_no)
 {
-	int loop = SDP_VF_BUSY_LOOP_COUNT;
 	uint64_t reg_val = 0ull;
 
-	/* Resetting doorbells during IQ enabling also to handle abrupt
-	 * guest reboot. IQ reset does not clear the doorbells.
-	 */
-	oct_ep_write64(0xFFFFFFFF, otx_ep->hw_addr + SDP_VF_R_IN_INSTR_DBELL(q_no));
-
-	while (((oct_ep_read64(otx_ep->hw_addr +
-		 SDP_VF_R_IN_INSTR_DBELL(q_no))) != 0ull) && loop--) {
-		rte_delay_ms(1);
-	}
-
-	if (loop < 0) {
-		otx_ep_err("INSTR DBELL not coming back to 0");
-		return -EIO;
-	}
-
 	reg_val = oct_ep_read64(otx_ep->hw_addr + SDP_VF_R_IN_ENABLE(q_no));
 	reg_val |= 0x1ull;
 
diff --git a/drivers/net/octeon_ep/otx_ep_common.h b/drivers/net/octeon_ep/otx_ep_common.h
index 122926cd40..53de8b18d6 100644
--- a/drivers/net/octeon_ep/otx_ep_common.h
+++ b/drivers/net/octeon_ep/otx_ep_common.h
@@ -589,6 +589,7 @@ int otx_ep_delete_oqs(struct otx_ep_device *otx_ep, uint32_t oq_no);
 #define OTX_EP_CLEAR_ISIZE_BSIZE 0x7FFFFFULL
 #define OTX_EP_CLEAR_OUT_INT_LVLS 0x3FFFFFFFFFFFFFULL
 #define OTX_EP_CLEAR_IN_INT_LVLS 0xFFFFFFFF
+#define OTX_EP_CLEAR_INSTR_DBELL 0xFFFFFFFF
 #define OTX_EP_CLEAR_SDP_IN_INT_LVLS 0x3FFFFFFFFFFFFFUL
 #define OTX_EP_DROQ_BUFSZ_MASK 0xFFFF
 #define OTX_EP_CLEAR_SLIST_DBELL 0xFFFFFFFF
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index 10f2f8a2e0..cd8e4bad3b 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -232,6 +232,12 @@ otx_ep_dev_start(struct rte_eth_dev *eth_dev)
 	int ret;
 
 	otx_epvf = (struct otx_ep_device *)OTX_EP_DEV(eth_dev);
+
+	for (q = 0; q < otx_epvf->nb_rx_queues; q++) {
+		cnxk_ep_drain_rx_pkts(otx_epvf->droq[q]);
+		otx_epvf->fn_list.setup_oq_regs(otx_epvf, q);
+	}
+
 	/* Enable IQ/OQ for this device */
 	ret = otx_epvf->fn_list.enable_io_queues(otx_epvf);
 	if (ret) {
diff --git a/drivers/net/octeon_ep/otx_ep_rxtx.h b/drivers/net/octeon_ep/otx_ep_rxtx.h
index 6b3abe21b1..384e4fb412 100644
--- a/drivers/net/octeon_ep/otx_ep_rxtx.h
+++ b/drivers/net/octeon_ep/otx_ep_rxtx.h
@@ -32,6 +32,9 @@ otx_ep_incr_index(uint32_t index, uint32_t count, uint32_t max)
 	return ((index + count) & (max - 1));
 }
 
+void
+cnxk_ep_drain_rx_pkts(void *rx_queue);
+
 uint16_t
 otx_ep_xmit_pkts(void *tx_queue, struct rte_mbuf **pkts, uint16_t nb_pkts);
 
-- 
2.34.1

