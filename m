Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5BBC021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 03:58:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D3CDE427DB;
	Sat, 22 Feb 2025 04:57:55 +0100 (CET)
Received: from lf-1-20.ptr.blmpb.com (lf-1-20.ptr.blmpb.com [103.149.242.20])
 by mails.dpdk.org (Postfix) with ESMTP id 3E4BA427E4
 for <dev@dpdk.org>; Sat, 22 Feb 2025 04:57:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1740196666; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Ql3iKgzCA5BAnsOck3tScpXfdXAKN42L5AkYGmaU6ps=;
 b=e/WR9DunmYFw4D0HHd8BIM6rCyBFSll0PWRth6ZeLaE/U0nRwgZF05FCho8q8iqHDvumyt
 vEGTZvm/pIhZjOgBfNzVlLWlMlaSBa8B7vhGuiKeht1ItsM86O+LwiNxpjo1+IldxMlVYn
 71d1lhRjM+y7UAESZ+SPHSkhouMHaP3UUzwa7Mqd7aEPdcEeXdEph+MmVVOE17JUsIT5QU
 FWykKNI5Uqo29Glh1ZMVmQoqpSmuONyOho3+sXN6U/fYdv8v+pCBkL7NSeTugjsWQNR1qh
 iNW0MJF4TYyBijlo4Uxuos/1h6IBenCzXPpdMKu4sxMthD1Q1jJl6zIdHPge3g==
To: <dev@dpdk.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+267b94b38+13b507+dpdk.org+wanry@yunsilicon.com>
References: <20250222035732.2290067-1-wanry@yunsilicon.com>
In-Reply-To: <20250222035732.2290067-1-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 06/12] net/xsc: check possible null pointer dereference
Date: Sat, 22 Feb 2025 11:57:44 +0800
Message-Id: <20250222035742.2290067-7-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Sat, 22 Feb 2025 11:57:43 +0800
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

This issue was reported by PVS studio, described as:
https://pvs-studio.com/en/docs/warnings/v522/

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_ethdev.c | 15 +++++++++++++--
 drivers/net/xsc/xsc_rx.c     |  5 +++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index d04fe78d3f..44d861e484 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -137,8 +137,8 @@ xsc_ethdev_enable(struct rte_eth_dev *dev)
 	int pcie_logic_port = 0;
 	int qp_set_id;
 	int repr_id;
-	struct xsc_rxq_data *rxq = xsc_rxq_get(priv, 0);
-	uint16_t rx_qpn = (uint16_t)rxq->qpn;
+	struct xsc_rxq_data *rxq;
+	uint16_t rx_qpn;
 	int i, vld;
 	struct xsc_txq_data *txq;
 	struct xsc_repr_port *repr;
@@ -147,6 +147,11 @@ xsc_ethdev_enable(struct rte_eth_dev *dev)
 	if (priv->funcid_type != XSC_PHYPORT_MAC_FUNCID)
 		return -ENODEV;
 
+	rxq = xsc_rxq_get(priv, 0);
+	if (rxq == NULL)
+		return -EINVAL;
+
+	rx_qpn = (uint16_t)rxq->qpn;
 	hwinfo = &priv->xdev->hwinfo;
 	repr_id = priv->representor_id;
 	repr = &priv->xdev->repr_ports[repr_id];
@@ -162,6 +167,8 @@ xsc_ethdev_enable(struct rte_eth_dev *dev)
 
 	for (i = 0; i < priv->num_sq; i++) {
 		txq = xsc_txq_get(priv, i);
+		if (txq == NULL)
+			return -EINVAL;
 		xsc_dev_modify_qp_status(priv->xdev, txq->qpn, 1, XSC_CMD_OP_RTR2RTS_QP);
 		xsc_dev_modify_qp_qostree(priv->xdev, txq->qpn);
 		xsc_dev_set_qpsetid(priv->xdev, txq->qpn, qp_set_id);
@@ -229,6 +236,8 @@ xsc_txq_start(struct xsc_ethdev_priv *priv)
 
 	for (i = 0; i != priv->num_sq; ++i) {
 		txq_data = xsc_txq_get(priv, i);
+		if (txq_data == NULL)
+			goto error;
 		xsc_txq_elts_alloc(txq_data);
 		ret = xsc_txq_obj_new(priv->xdev, txq_data, offloads, i);
 		if (ret < 0)
@@ -270,6 +279,8 @@ xsc_rxq_start(struct xsc_ethdev_priv *priv)
 
 	for (i = 0; i != priv->num_rq; ++i) {
 		rxq_data = xsc_rxq_get(priv, i);
+		if (rxq_data == NULL)
+			goto error;
 		if (dev->data->rx_queue_state[i] != RTE_ETH_QUEUE_STATE_STARTED) {
 			ret = xsc_rxq_elts_alloc(rxq_data);
 			if (ret != 0)
diff --git a/drivers/net/xsc/xsc_rx.c b/drivers/net/xsc/xsc_rx.c
index 3230710656..140d7728d6 100644
--- a/drivers/net/xsc/xsc_rx.c
+++ b/drivers/net/xsc/xsc_rx.c
@@ -280,6 +280,9 @@ xsc_rss_qp_create(struct xsc_ethdev_priv *priv, int port_id)
 	char name[RTE_ETH_NAME_MAX_LEN] = { 0 };
 
 	rxq_data = xsc_rxq_get(priv, 0);
+	if (rxq_data == NULL)
+		return -EINVAL;
+
 	log_ele = rte_log2_u32(sizeof(struct xsc_wqe_data_seg));
 	wqe_n = rxq_data->wqe_s;
 	log_rq_sz = rte_log2_u32(wqe_n * hwinfo->recv_seg_num);
@@ -385,6 +388,8 @@ xsc_rxq_rss_obj_new(struct xsc_ethdev_priv *priv, uint16_t port_id)
 	/* Create CQ */
 	for (i = 0; i < priv->num_rq; ++i) {
 		rxq_data = xsc_rxq_get(priv, i);
+		if (rxq_data == NULL)
+			return -EINVAL;
 
 		memset(&cq_params, 0, sizeof(cq_params));
 		memset(&cq_info, 0, sizeof(cq_info));
-- 
2.25.1
