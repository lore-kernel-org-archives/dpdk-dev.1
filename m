Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A695606A31C
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Nov 2026 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.a=rsa-sha256 header.s=feishu2403070942 header.b=XU1R5YpT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E1AA402D8;
	Tue, 17 Nov 2026 12:14:37 +0100 (CET)
Received: from lf-2-45.ptr.blmpb.com (lf-2-45.ptr.blmpb.com [101.36.218.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 91B1D402D2
 for <dev@dpdk.org>; Tue, 17 Nov 2026 12:14:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1794914067; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DH8Fq2hbk8XrUGQv6fZ+A3ZMsQrGiJKwRZmiwtpYhkg=;
 b=XU1R5YpTnM+FI6dtfzu273nqq6NcSxGsHO5nVRA3nN0BiKuwkjLZ7xSxK+Pe/24iIOJeEl
 kfWLT8yW0yIrwhMkE0Brl3CFieYWxljCdELLEQLKhxVdwHbyKVF+WnZapymr3/P2N0pXCl
 pJJrybvVhZICStk5Y99KIoG5kiaLovaumY8IsLJRBAdm1HrlTulYGDdKTabMgT0ke8vmWW
 duhVWpDkawcAb6JAT4+mylRnrWkFOSuI2fjilW5359JHfHfTN2xS3z0S1zCEecHAJVKvqA
 lZycWN+t6taTHhH5c+JlRan65vp5h3MxMlE9YkMVtoWUwaLzr1HUX6odmxI8zA==
Received: from [10.211.5.164] ([180.152.18.210]) by smtp.feishu.cn with ESMTPS;
 Tue, 17 Nov 2026 19:14:24 +0800
Cc: "Stephen Hemminger" <stephen@networkplumber.org>, <nana@yunsilicon.com>, 
 <qianr@yunsilicon.com>, <zhangxx@yunsilicon.com>, <xudw@yunsilicon.com>, 
 <stable@dpdk.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
References: <1794914060.606144@yunsilicon.com>
In-Reply-To: <1794914060.606144@yunsilicon.com>
X-Lms-Return-Path: <lba+26afc3711+c32bc1+dpdk.org+wanry@yunsilicon.com>
To: <dev@dpdk.org>
Subject: [PATCH v4 1/3] net/xsc: fix jumbo buffer allocation and leak
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Date: Tue, 17 Nov 2026 19:14:20 +0800
Message-Id: <1794914060.966424@yunsilicon.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The jumbo buffer is allocated inside the WQE loop, so a device without
IOVA retries it on every WQE and logs an error each time. The fallback
also hands XSC_MAX_RECV_LEN bytes to a segment that points into an
mbuf, which is a DMA overrun.

Allocate it once before the loop and fail the queue start on error.
Nothing frees it on removal either, so free it in xsc_dev_close() once
the last port stops the hardware.

Fixes: 0ff4b93c318f ("net/xsc: support device start")
Cc: stable@dpdk.org
Reported-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c | 16 ++++++++++---
 drivers/net/xsc/xsc_rx.c  | 47 ++++++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 478f4895..953409a9 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -141,11 +141,21 @@ xsc_dev_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 int
 xsc_dev_close(struct xsc_dev *xdev, int repr_id)
 {
+	int ret = 0;
+
 	xsc_dev_clear_pct(xdev, repr_id);
 
-	if (repr_id == xdev->num_repr_ports - 1)
-		return xdev->dev_ops->dev_close(xdev);
-	return 0;
+	if (repr_id == xdev->num_repr_ports - 1) {
+		ret = xdev->dev_ops->dev_close(xdev);
+		/*
+		 * The buffer is shared by all the ports, the other Rx
+		 * queues hold its IOVA until the device is stopped.
+		 */
+		rte_free(xdev->jumbo_buffer_pa);
+		xdev->jumbo_buffer_pa = NULL;
+	}
+
+	return ret;
 }
 
 int
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 13b2e269..30b40df3 100644
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
 
+	if (rx_ds_num != 1 && jumbo_buffer_pa == NULL) {
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
