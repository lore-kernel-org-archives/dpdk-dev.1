Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC09606A323
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=LAexcEiz
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9858402A2;
	Mon, 16 Nov 2026 07:59:03 +0100 (CET)
Received: from lf-1-37.ptr.blmpb.com (lf-1-37.ptr.blmpb.com [103.149.242.37])
 by mails.dpdk.org (Postfix) with ESMTPS id 05D4240297
 for <dev@dpdk.org>; Mon, 16 Nov 2026 07:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794812334; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=cmqZVpmJ3oCz731nHc2KnzmiavAu0NtIfX29qSs41FQ=;
 b=LAexcEizYLdLDMY+vAy7kBAld62AlUFaSos70E7MdGD6Qm9IFjQryL9JD9Hd8oxNl/VrU3
 OIFqstmUFGOrIj2sCiWatlPiEfwgU6D5GBqCnMR5rZv/2C31uDClbbeFv0TCoecQhD3sl8
 q/ESkPNYT25TfH5r2IlWadl7sDBStrbY1a1m1Aol+A4QZBt2T9ABZOhbVMQh8PN6sVxWWe
 kHxC3pNKT7zgwPDmh5hHJkSms+RquoWOTYQBWLd70ZjbdTemFNYnHdcP8G5HYdBpgeIoDR
 A6VYM5F61hpiGDosvEtleoAQfRtWejhP2AfB2r+gdOZVC4mn3K3Hjdq5CyGcaA==
Date: Mon, 16 Nov 2026 06:58:43 -0000
Message-Id: <179481232344.1639.7839185524554923628@yunsilicon.com>
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Received: from [127.0.0.1] ([14.103.216.154]) by smtp.feishu.cn with ESMTPS;
 Mon, 16 Nov 2026 14:58:51 +0800
X-Lms-Return-Path: <lba+26afaa9ac+6af72b+dpdk.org+wanry@yunsilicon.com>
In-Reply-To: <179481232343.1639.15317349483624427514@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
To: <dev@dpdk.org>
Cc: <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <stable@dpdk.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH v2 1/3] net/xsc: fix jumbo buffer allocation and leak
References: <179481232343.1639.15317349483624427514@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The jumbo buffer is allocated inside the WQE loop, so a device without
IOVA retries it on every WQE and logs an error each time. The fallback
also hands XSC_MAX_RECV_LEN bytes to a segment that points into an
mbuf, which is a DMA overrun.

Allocate it once before the loop and fail the queue start on error.
It is never freed on close either, so free it in xsc_dev_uninit().

Fixes: 0ff4b93c318f ("net/xsc: support device start")
Cc: stable@dpdk.org
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c |  1 +
 drivers/net/xsc/xsc_rx.c  | 47 ++++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 478f4895..6bd12510 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -345,6 +345,7 @@ xsc_dev_uninit(struct xsc_dev *xdev)
 	PMD_INIT_FUNC_TRACE();
 	xsc_dev_pct_uninit(xdev);
 	xsc_dev_close(xdev, XSC_DEV_REPR_ID_INVALID);
+	rte_free(xdev->jumbo_buffer_pa);
 	rte_free(xdev);
 }
 
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 13b2e269..5baeedf1 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -195,7 +195,7 @@ xsc_rx_burst(void *dpdk_rxq, struct rte_mbuf **pkts, uint16_t pkts_n)
 	return nb_pkts;
 }
 
-static void
+static int
 xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
 {
 	const uint32_t wqe_n = rxq_data->wqe_s;
@@ -211,6 +211,24 @@ xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
 	volatile struct xsc_wqe_data_seg *seg;
 	volatile struct xsc_wqe_data_seg *seg_next;
 
+	if ((rx_ds_num != 1) && (jumbo_buffer_va == NULL)) {
+		jumbo_buffer_pa = rte_malloc(NULL, XSC_MAX_RECV_LEN, 0);
+		if (jumbo_buffer_pa == NULL) {
+			PMD_DRV_LOG(ERR, "Failed to malloc jumbo_buffer");
+			return -ENOMEM;
+		}
+
+		jumbo_buffer_va = (void *)rte_malloc_virt2iova(jumbo_buffer_pa);
+		if ((rte_iova_t)jumbo_buffer_va == RTE_BAD_IOVA) {
+			PMD_DRV_LOG(ERR, "Failed to get IOVA of jumbo_buffer");
+			rte_free(jumbo_buffer_pa);
+			return -EFAULT;
+		}
+
+		xdev->jumbo_buffer_pa = jumbo_buffer_pa;
+		xdev->jumbo_buffer_va = jumbo_buffer_va;
+	}
+
 	for (i = 0; (i != wqe_n); ++i) {
 		mbuf = (*rxq_data->elts)[i];
 		seg = &((volatile struct xsc_wqe_data_seg *)rxq_data->wqes)[i * rx_ds_num];
@@ -227,25 +245,6 @@ xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
 
 		if (rx_ds_num != 1) {
 			seg_next = seg + 1;
-			if (jumbo_buffer_va == NULL) {
-				jumbo_buffer_pa = rte_malloc(NULL, XSC_MAX_RECV_LEN, 0);
-				if (jumbo_buffer_pa == NULL) {
-					/* Rely on mtu */
-					seg->seg_len = XSC_MAX_RECV_LEN;
-					PMD_DRV_LOG(ERR, "Failed to malloc jumbo_buffer");
-					continue;
-				} else {
-					jumbo_buffer_va =
-						(void *)rte_malloc_virt2iova(jumbo_buffer_pa);
-					if ((rte_iova_t)jumbo_buffer_va == RTE_BAD_IOVA) {
-						seg->seg_len = XSC_MAX_RECV_LEN;
-						PMD_DRV_LOG(ERR, "Failed to turn jumbo_buffer");
-						continue;
-					}
-				}
-				xdev->jumbo_buffer_pa = jumbo_buffer_pa;
-				xdev->jumbo_buffer_va = jumbo_buffer_va;
-			}
 			*seg_next = (struct xsc_wqe_data_seg){
 				.va = rte_cpu_to_le_64((uint64_t)jumbo_buffer_va),
 				.seg_len = rte_cpu_to_le_32(XSC_MAX_RECV_LEN - seg_len),
@@ -264,6 +263,8 @@ xsc_rxq_initialize(struct xsc_dev *xdev, struct xsc_rxq_data *rxq_data)
 	recv_db.next_pid = wqe_n << log2ds;
 	recv_db.qp_num = rxq_data->qpn;
 	rte_write32(rte_cpu_to_le_32(recv_db.recv_data), rxq_data->rq_db);
+
+	return 0;
 }
 
 static int
@@ -484,7 +485,11 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 
 		rxq_data->qpn = rqn_base + i;
 		xsc_dev_modify_qp_status(xdev, rxq_data->qpn, 1, XSC_CMD_OP_RTR2RTS_QP);
-		xsc_rxq_initialize(xdev, rxq_data);
+		ret = xsc_rxq_initialize(xdev, rxq_data);
+		if (ret != 0) {
+			rte_errno = -ret;
+			goto set_qp_fail;
+		}
 		rxq_data->cq_ci = 0;
 		PMD_DRV_LOG(INFO, "Port %d create rx qp, wqe_s:%d, wqe_n:%d, qp_db=%p, qpn:%u",
 			    port_id,
