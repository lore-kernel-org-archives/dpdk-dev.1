Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305BACA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38EFC40671;
	Fri, 29 Aug 2025 10:24:39 +0200 (CEST)
Received: from lf-2-35.ptr.blmpb.com (lf-2-35.ptr.blmpb.com [101.36.218.35])
 by mails.dpdk.org (Postfix) with ESMTP id 5929440671
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455871; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=wkECfK+Oi6ysMrFWVaQ6v4xmKkPJAwMsH3yZk730c8o=;
 b=iJrqJfi3wN6ysPhr/N7TNJAF+3REQ8K2vK/hsL4W8kmNQ85TllDHOzfBED4i/gC74rs72v
 vUY9ZOMlAVquR2e2QNI+ryoSannHY99zVmrKXt283+AaNgM1Th8ZtfgYojqodK1yAyUpw/
 ooQifBvPyiqCHn/RVFpj8AOM11IK+HJo/0oJ4ecQIk9IYJztCHQaRuqIoyGNpwF+Bp3Y5k
 vQClRxNXlX8vzYPOj/z8lz+ooWnrWu7FROZHglRFLf7U35P4v8I877bYP1pcvG60VHJZ9U
 6xILqJRChYncW9gHzme1905kB/y1095AjT/vnLQAG50CBW/Ivl38hTw3/0rVTQ==
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
Date: Fri, 29 Aug 2025 16:24:28 +0800
Message-Id: <20250829082427.24369-11-wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+268b163bd+56bc05+dpdk.org+wanry@yunsilicon.com>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH 10/14] net/xsc: optimize Rx path
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:28 +0800
X-Mailer: git-send-email 2.25.1
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

CQEs are not cache line aligned, which can cause cache conflicts when
polling Rx CQs under high-PPS load.

This patch checks CQ producer/consumer indices before processing packets,
reducing cache conflicts. The added MMIO read overhead is minor
compared to the latency caused by cache conflicts, improving observed
small-packet performance.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_defs.h |  2 ++
 drivers/net/xsc/xsc_rx.c   | 18 ++++++++++++++++--
 drivers/net/xsc/xsc_rx.h   |  1 +
 drivers/net/xsc/xsc_vfio.c |  2 +-
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xsc/xsc_defs.h b/drivers/net/xsc/xsc_defs.h
index 4b95a0521d..73941901e7 100644
--- a/drivers/net/xsc/xsc_defs.h
+++ b/drivers/net/xsc/xsc_defs.h
@@ -46,10 +46,12 @@
 #define XSC_PF_TX_DB_ADDR		0x4802000
 #define XSC_PF_RX_DB_ADDR		0x4804000
 #define XSC_PF_CQ_DB_ADDR		0x2120000
+#define XSC_PF_CQ_PID_START_ADDR	0x2080000
 
 #define XSC_VF_RX_DB_ADDR		0x8d4
 #define XSC_VF_TX_DB_ADDR		0x8d0
 #define XSC_VF_CQ_DB_ADDR		0x8c4
+#define XSC_VF_CQ_PID_START_ADDR	0x60000
 
 #define XSC_HIF_CMDQM_VECTOR_ID_MEM_ADDR	0x1034000
 
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 332ceb9606..5f8003a1f6 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -83,6 +83,16 @@ xsc_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	int cqe_msg_len = 0;
 	volatile struct xsc_cqe_u64 *cqe_u64 = NULL;
 	struct rte_mbuf *rep;
+	uint16_t cq_pi;
+	uint16_t cqe_pkts_n = 0;
+
+	if (rxq->cq_pi != NULL) {
+		cq_pi = (*(volatile uint32_t *)(rxq->cq_pi)) & 0xFFFF;
+		if (cq_pi == rxq->cq_ci)
+			return 0;
+		cqe_pkts_n = (uint16_t)((cq_pi - rxq->cq_ci) & 0xFFFF);
+		pkts_n = pkts_n < cqe_pkts_n ? pkts_n : cqe_pkts_n;
+	}
 
 	while (pkts_n) {
 		uint32_t idx = rq_ci & wqe_m;
@@ -463,12 +473,16 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 		}
 
 		rxq_data->wqes = rxq_data->rq_pas->addr;
-		if (!xsc_dev_is_vf(xdev))
+		if (!xsc_dev_is_vf(xdev)) {
 			rxq_data->rq_db = (uint32_t *)((uint8_t *)xdev->bar_addr +
 					  XSC_PF_RX_DB_ADDR);
-		else
+			rxq_data->cq_pi = (uint32_t *)((uint8_t *)xdev->bar_addr +
+					  XSC_PF_CQ_PID_START_ADDR + rxq_data->cqn * 4);
+		} else {
 			rxq_data->rq_db = (uint32_t *)((uint8_t *)xdev->bar_addr +
 					  XSC_VF_RX_DB_ADDR);
+			rxq_data->cq_pi = NULL;
+		}
 
 		rxq_data->qpn = rqn_base + i;
 		xsc_dev_modify_qp_status(xdev, rxq_data->qpn, 1, XSC_CMD_OP_RTR2RTS_QP);
diff --git a/drivers/net/xsc/xsc_rx.h b/drivers/net/xsc/xsc_rx.h
index 90fbb89197..59cbbb5141 100644
--- a/drivers/net/xsc/xsc_rx.h
+++ b/drivers/net/xsc/xsc_rx.h
@@ -31,6 +31,7 @@ struct __rte_cache_aligned xsc_rxq_data {
 	uint16_t rsv0:4;
 	volatile uint32_t *rq_db;
 	volatile uint32_t *cq_db;
+	volatile uint32_t *cq_pi;
 	uint32_t rq_ci;
 	uint32_t rq_pi;
 	uint16_t cq_ci;
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 1650a3ab2b..c233728c5f 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -562,7 +562,7 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 		PMD_DRV_LOG(WARNING, "Port %u rxq %u: cq numa_node=%u, device numa_node=%u",
 			    port_id, idx, cq_params->socket_id, numa_node);
 
-	cqe_n = cq_params->wqe_s;
+	cqe_n = cq_params->wqe_s * 2;
 	log_cq_sz = rte_log2_u32(cqe_n);
 	cqe_total_sz = cqe_n * sizeof(struct xsc_cqe);
 	pa_num = (cqe_total_sz + XSC_PAGE_SIZE - 1) / XSC_PAGE_SIZE;
-- 
2.25.1
