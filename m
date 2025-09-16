Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B97DCAC599
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 10:09:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EDAE402C4;
	Tue, 16 Sep 2025 12:09:09 +0200 (CEST)
Received: from lf-2-37.ptr.blmpb.com (lf-2-37.ptr.blmpb.com [101.36.218.37])
 by mails.dpdk.org (Postfix) with ESMTP id B1FE8402C4
 for <dev@dpdk.org>; Tue, 16 Sep 2025 12:09:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1758017336; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+mzlyPt16p3H3G0vawsVz1TcT+x4+KYEompFtDQhsT8=;
 b=gIwr21gLuXNbJgtPtVvEu4qjRAfYmfgJZSDAS98nd9dPkrH/tpvEMHoDjrq0juMzkFdPww
 atE6p+iselK/QN0KD6c97SV6JHKSjm3MrBo67H64Wi5LU8RnVtWO5DHNT1OuSqGkkLjGFd
 Q85a9R7DU/2i64Rm75UJ2nCp6Pk96afOhmH3B2M0+WJk1zHiDizfM8df0np5wPJ9U5Gamu
 yK1LwuP5XZCmQfzaKj3z0z8MCfXDOflxjUJ+9gPdHxNsOeEPzjHPMyN4pfZsND+sN1ugZ1
 VHfesbSp+Id+AEHzK4AqLmbyEiteuXrsqjDvz4xdwoZcH8PUkyrUVWwtGf9G6w==
To: <dev@dpdk.org>
Content-Type: text/plain; charset=UTF-8
References: <20250916100850.226649-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Tue, 16 Sep 2025 18:08:53 +0800
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Subject: [PATCH 2/2] net/xsc: support compressed PCI BAR
Message-Id: <20250916100852.226649-3-wanry@yunsilicon.com>
Mime-Version: 1.0
Date: Tue, 16 Sep 2025 18:08:54 +0800
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+268c93736+11d9e0+dpdk.org+wanry@yunsilicon.com>
In-Reply-To: <20250916100850.226649-1-wanry@yunsilicon.com>
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

This commit allows the driver to correctly handle device
with compressed PCI BAR.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c       | 20 ++++++++++++++++++++
 drivers/net/xsc/xsc_dev.h       |  9 +++++++++
 drivers/net/xsc/xsc_rx.c        | 14 ++++++--------
 drivers/net/xsc/xsc_vfio.c      | 16 +++-------------
 drivers/net/xsc/xsc_vfio_mbox.c |  6 +++---
 5 files changed, 41 insertions(+), 24 deletions(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index b92bed3a40..478f489516 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -320,6 +320,25 @@ xsc_dev_repr_ports_probe(struct xsc_dev *xdev, int nb_repr_ports, int max_eth_po
 	return 0;
 }
 
+static void
+xsc_dev_reg_addr_init(struct xsc_dev *xdev)
+{
+	struct xsc_dev_reg_addr *reg = &xdev->reg_addr;
+	uint8_t *bar_addr = xdev->bar_addr;
+
+	if (xsc_dev_is_vf(xdev) || xdev->bar_len != XSC_DEV_BAR_LEN_256M) {
+		reg->rxq_db_addr = (uint32_t *)(bar_addr + XSC_VF_RX_DB_ADDR);
+		reg->txq_db_addr = (uint32_t *)(bar_addr + XSC_VF_TX_DB_ADDR);
+		reg->cq_db_addr = (uint32_t *)(bar_addr + XSC_VF_CQ_DB_ADDR);
+		reg->cq_pi_start = XSC_VF_CQ_PID_START_ADDR;
+	} else {
+		reg->rxq_db_addr = (uint32_t *)(bar_addr + XSC_PF_RX_DB_ADDR);
+		reg->txq_db_addr = (uint32_t *)(bar_addr + XSC_PF_TX_DB_ADDR);
+		reg->cq_db_addr = (uint32_t *)(bar_addr + XSC_PF_CQ_DB_ADDR);
+		reg->cq_pi_start = XSC_PF_CQ_PID_START_ADDR;
+	}
+}
+
 void
 xsc_dev_uninit(struct xsc_dev *xdev)
 {
@@ -354,6 +373,7 @@ xsc_dev_init(struct rte_pci_device *pci_dev, struct xsc_dev **xdev)
 	if (d->dev_ops->dev_init)
 		d->dev_ops->dev_init(d);
 
+	xsc_dev_reg_addr_init(d);
 	xsc_dev_args_parse(d, pci_dev->device.devargs);
 
 	ret = xsc_dev_alloc_vfos_info(d);
diff --git a/drivers/net/xsc/xsc_dev.h b/drivers/net/xsc/xsc_dev.h
index fc356375f1..d4a7d90b9d 100644
--- a/drivers/net/xsc/xsc_dev.h
+++ b/drivers/net/xsc/xsc_dev.h
@@ -34,6 +34,7 @@
 #define XSC_EEPROM_PAGE_LENGTH		256
 #define XSC_EEPROM_HIGH_PAGE_LENGTH	128
 #define XSC_EEPROM_MAX_BYTES		32
+#define XSC_DEV_BAR_LEN_256M		0x10000000
 
 enum xsc_dev_fec_config_bits {
 	XSC_DEV_FEC_NONE_BIT,
@@ -164,6 +165,13 @@ struct xsc_dev_config {
 	uint32_t tso_max_payload_sz;
 };
 
+struct xsc_dev_reg_addr {
+	uint32_t *rxq_db_addr;
+	uint32_t *txq_db_addr;
+	uint32_t *cq_db_addr;
+	uint32_t cq_pi_start;
+};
+
 struct xsc_dev {
 	struct rte_pci_device *pci_dev;
 	const struct xsc_dev_ops *dev_ops;
@@ -188,6 +196,7 @@ struct xsc_dev {
 	rte_intr_callback_fn intr_cb;
 	void *intr_cb_arg;
 	struct xsc_dev_pct_mgr pct_mgr;
+	struct xsc_dev_reg_addr reg_addr;
 };
 
 struct xsc_module_eeprom_query_params {
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 5ff3f818c2..13b2e26908 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -382,6 +382,7 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	int wqe_n;
 	int entry_total_len, entry_len;
 	uint32_t wqe_total_len;
+	uint32_t cq_pi_start;
 	uint16_t rqn_base, pa_num;
 	uint16_t i, j;
 	uint16_t set_last_no = 0;
@@ -465,6 +466,7 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 		set_last_no++;
 	}
 
+	cq_pi_start = xdev->reg_addr.cq_pi_start;
 	for (i = 0; i < priv->num_rq; i++) {
 		rxq_data = xsc_rxq_get(priv, i);
 		if (rxq_data == NULL) {
@@ -473,16 +475,12 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 		}
 
 		rxq_data->wqes = rxq_data->rq_pas->addr;
-		if (!xsc_dev_is_vf(xdev)) {
-			rxq_data->rq_db = (uint32_t *)((uint8_t *)xdev->bar_addr +
-					  XSC_PF_RX_DB_ADDR);
+		rxq_data->rq_db = xdev->reg_addr.rxq_db_addr;
+		if (!xsc_dev_is_vf(xdev))
 			rxq_data->cq_pi = (uint32_t *)((uint8_t *)xdev->bar_addr +
-					  XSC_PF_CQ_PID_START_ADDR + rxq_data->cqn * 4);
-		} else {
-			rxq_data->rq_db = (uint32_t *)((uint8_t *)xdev->bar_addr +
-					  XSC_VF_RX_DB_ADDR);
+					cq_pi_start + rxq_data->cqn * 4);
+		else
 			rxq_data->cq_pi = NULL;
-		}
 
 		rxq_data->qpn = rqn_base + i;
 		xsc_dev_modify_qp_status(xdev, rxq_data->qpn, 1, XSC_CMD_OP_RTR2RTS_QP);
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index cda21aa3f4..a6b69577ac 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -626,10 +626,7 @@ xsc_vfio_rx_cq_create(struct xsc_dev *xdev, struct xsc_rx_cq_params *cq_params,
 	for (i = 0; i < (1 << cq_info->cqe_n); i++)
 		((volatile struct xsc_cqe *)(cqes + i))->owner = 1;
 	cq_info->cqes = cqes;
-	if (xsc_dev_is_vf(xdev))
-		cq_info->cq_db = (uint32_t *)((uint8_t *)xdev->bar_addr + XSC_VF_CQ_DB_ADDR);
-	else
-		cq_info->cq_db = (uint32_t *)((uint8_t *)xdev->bar_addr + XSC_PF_CQ_DB_ADDR);
+	cq_info->cq_db = xdev->reg_addr.cq_db_addr;
 	cq_info->cqn = rte_be_to_cpu_32(out->cqn);
 	cq->cqn = cq_info->cqn;
 	cq->xdev = xdev;
@@ -731,10 +728,7 @@ xsc_vfio_tx_cq_create(struct xsc_dev *xdev, struct xsc_tx_cq_params *cq_params,
 
 	cq_info->cq = cq;
 	cqes = (struct xsc_cqe *)((uint8_t *)cq->mz->addr);
-	if (xsc_dev_is_vf(xdev))
-		cq_info->cq_db = (uint32_t *)((uint8_t *)xdev->bar_addr + XSC_VF_CQ_DB_ADDR);
-	else
-		cq_info->cq_db = (uint32_t *)((uint8_t *)xdev->bar_addr + XSC_PF_CQ_DB_ADDR);
+	cq_info->cq_db = xdev->reg_addr.cq_db_addr;
 	cq_info->cqn = cq->cqn;
 	cq_info->cqe_s = cqe_s;
 	cq_info->cqe_n = log_cq_sz;
@@ -851,11 +845,7 @@ xsc_vfio_tx_qp_create(struct xsc_dev *xdev, struct xsc_tx_qp_params *qp_params,
 	qp_info->wqes = (struct xsc_wqe *)qp->mz->addr;
 	qp_info->wqe_n = rte_log2_u32(wqe_s);
 	qp_info->tso_en = tso_en ? 1 : 0;
-
-	if (xsc_dev_is_vf(xdev))
-		qp_info->qp_db = (uint32_t *)((uint8_t *)xdev->bar_addr + XSC_VF_TX_DB_ADDR);
-	else
-		qp_info->qp_db = (uint32_t *)((uint8_t *)xdev->bar_addr + XSC_PF_TX_DB_ADDR);
+	qp_info->qp_db = xdev->reg_addr.txq_db_addr;
 
 	free(cmd_buf);
 	return 0;
diff --git a/drivers/net/xsc/xsc_vfio_mbox.c b/drivers/net/xsc/xsc_vfio_mbox.c
index 3c8bb54601..6d6cc677a7 100644
--- a/drivers/net/xsc/xsc_vfio_mbox.c
+++ b/drivers/net/xsc/xsc_vfio_mbox.c
@@ -73,10 +73,10 @@ static struct xsc_cmdq_config xsc_vf_config = {
 static void
 xsc_cmdq_config_init(struct xsc_dev *xdev, struct xsc_cmd_queue *cmdq)
 {
-	if (!xsc_dev_is_vf(xdev))
-		cmdq->config = &xsc_pf_config;
-	else
+	if (xsc_dev_is_vf(xdev) || xdev->bar_len != XSC_DEV_BAR_LEN_256M)
 		cmdq->config = &xsc_vf_config;
+	else
+		cmdq->config = &xsc_pf_config;
 }
 
 static void
-- 
2.25.1
