Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E09ECA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:24:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D012B4042C;
	Fri, 29 Aug 2025 10:24:23 +0200 (CEST)
Received: from lf-1-17.ptr.blmpb.com (lf-1-17.ptr.blmpb.com [103.149.242.17])
 by mails.dpdk.org (Postfix) with ESMTP id A41F540263
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455857; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=fcm8+KXbNAK8xHxhw7uR5ulDm6okMECbTPmk8TzjkeE=;
 b=e9+n8GFEJ7Qj2CzGmKe57CKxFU+pPOaYiSANMDOLZK4MhSV1Rw++JdytvdWQDHpCpNwHi+
 nX2svBl1LUloMwRSuLChII3KNhDqhX4jfaNbDAJZxBKgON/aioXw9EiI0p8tlZTmGu2PT/
 TSDzA7IdmIIAHHUSxz6VqkPj08KVQrMbR4AkBlEo6hR1xf3exUp+oKXoSnCc9vPeO05Vzy
 ga0tK2M3qmY+oXh/CITHRMh4ErRP9b+6670xUCOUwN1MEj9naHC4qYfJE8wrUCipo2KhnC
 AbjJxuGQ5gC39pM3l+jGeKOxuMErkA1SX6X3pqCO+rYHZXrpdB82Oh2Sv5l0Dg==
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Date: Fri, 29 Aug 2025 16:24:14 +0800
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:14 +0800
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 04/14] net/xsc: support promiscuous mode
Message-Id: <20250829082413.24369-5-wanry@yunsilicon.com>
Mime-Version: 1.0
References: <20250829082406.24369-1-wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+268b163af+a74e2d+dpdk.org+wanry@yunsilicon.com>
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

Add support for enabling and disabling promiscuous mode on XSC NIC ports.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 doc/guides/nics/features/xsc.ini |  1 +
 drivers/net/xsc/xsc_defs.h       |  1 +
 drivers/net/xsc/xsc_ethdev.c     | 58 ++++++++++++++++++++++++++++++--
 drivers/net/xsc/xsc_np.c         | 28 +++++++++++++--
 drivers/net/xsc/xsc_np.h         | 24 ++++++++-----
 5 files changed, 99 insertions(+), 13 deletions(-)

diff --git a/doc/guides/nics/features/xsc.ini b/doc/guides/nics/features/xsc.ini
index 46c56fc921..dfbfc88dbc 100644
--- a/doc/guides/nics/features/xsc.ini
+++ b/doc/guides/nics/features/xsc.ini
@@ -6,6 +6,7 @@
 [Features]
 MTU update           = Y
 TSO                  = Y
+Promiscuous mode     = Y
 RSS hash             = Y
 RSS key update       = Y
 RSS reta update      = Y
diff --git a/drivers/net/xsc/xsc_defs.h b/drivers/net/xsc/xsc_defs.h
index 6497b53e1e..5b4e5b80d2 100644
--- a/drivers/net/xsc/xsc_defs.h
+++ b/drivers/net/xsc/xsc_defs.h
@@ -37,6 +37,7 @@
 #define XSC_EPAT_RSS_HASH_TEMPLATE_FLAG	(1ULL << 5)
 #define XSC_EPAT_RSS_HASH_FUNC_FLAG	(1ULL << 6)
 #define XSC_EPAT_HAS_PPH_FLAG		(1ULL << 9)
+#define XSC_EPAT_MAC_FILTER_EN_FLAG	(1ULL << 15)
 
 #define XSC_MAX_DESC_NUMBER		1024
 #define XSC_SEND_WQE_DS			3
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index ffcf04a90c..efe1ad72f6 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -144,6 +144,7 @@ xsc_ethdev_enable(struct rte_eth_dev *dev)
 	struct xsc_txq_data *txq;
 	struct xsc_repr_port *repr;
 	struct xsc_repr_info *repr_info;
+	uint8_t mac_filter_en = !dev->data->promiscuous;
 
 	if (priv->funcid_type != XSC_PHYPORT_MAC_FUNCID)
 		return -ENODEV;
@@ -180,7 +181,8 @@ xsc_ethdev_enable(struct rte_eth_dev *dev)
 		xsc_dev_create_vfos_baselp(priv->xdev);
 		xsc_dev_create_epat(priv->xdev, local_dstinfo, pcie_logic_port,
 				    rx_qpn - hwinfo->raw_rss_qp_id_base,
-				    priv->num_rq, &priv->rss_conf);
+				    priv->num_rq, &priv->rss_conf,
+				    mac_filter_en, priv->mac[0].addr_bytes);
 		xsc_dev_create_pct(priv->xdev, repr_id, logical_port, peer_dstinfo);
 		xsc_dev_create_pct(priv->xdev, repr_id, peer_logicalport, local_dstinfo);
 	} else {
@@ -189,7 +191,8 @@ xsc_ethdev_enable(struct rte_eth_dev *dev)
 			xsc_dev_create_ipat(priv->xdev, logical_port, peer_dstinfo);
 		xsc_dev_vf_modify_epat(priv->xdev, local_dstinfo,
 				       rx_qpn - hwinfo->raw_rss_qp_id_base,
-				       priv->num_rq, &priv->rss_conf);
+				       priv->num_rq, &priv->rss_conf,
+				       mac_filter_en, priv->mac[0].addr_bytes);
 	}
 
 	return 0;
@@ -674,6 +677,55 @@ xsc_ethdev_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac, uin
 	return 0;
 }
 
+static int
+xsc_set_promiscuous(struct rte_eth_dev *dev, uint8_t mac_filter_en)
+{
+	int repr_id;
+	struct xsc_repr_port *repr;
+	struct xsc_repr_info *repr_info;
+	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
+
+	repr_id = priv->representor_id;
+	repr = &priv->xdev->repr_ports[repr_id];
+	repr_info = &repr->info;
+
+	return xsc_dev_modify_epat_mac_filter(priv->xdev,
+					      repr_info->local_dstinfo,
+					      mac_filter_en);
+}
+
+static int
+xsc_ethdev_promiscuous_enable(struct rte_eth_dev *dev)
+{
+	int ret;
+
+	ret = xsc_set_promiscuous(dev, 0);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Enable port %u promiscuous failure",
+			    dev->data->port_id);
+		return ret;
+	}
+
+	dev->data->promiscuous = 1;
+	return 0;
+}
+
+static int
+xsc_ethdev_promiscuous_disable(struct rte_eth_dev *dev)
+{
+	int ret;
+
+	ret = xsc_set_promiscuous(dev, 1);
+	if (ret != 0) {
+		PMD_DRV_LOG(ERR, "Disable port %u promiscuous failure",
+			    dev->data->port_id);
+		return ret;
+	}
+
+	dev->data->promiscuous = 0;
+	return 0;
+}
+
 static int
 xsc_ethdev_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
 {
@@ -794,6 +846,8 @@ const struct eth_dev_ops xsc_eth_dev_ops = {
 	.dev_set_link_down = xsc_ethdev_set_link_down,
 	.dev_close = xsc_ethdev_close,
 	.link_update = xsc_ethdev_link_update,
+	.promiscuous_enable = xsc_ethdev_promiscuous_enable,
+	.promiscuous_disable = xsc_ethdev_promiscuous_disable,
 	.stats_get = xsc_ethdev_stats_get,
 	.stats_reset = xsc_ethdev_stats_reset,
 	.dev_infos_get = xsc_ethdev_infos_get,
diff --git a/drivers/net/xsc/xsc_np.c b/drivers/net/xsc/xsc_np.c
index 543e6dba95..2b85fd93f8 100644
--- a/drivers/net/xsc/xsc_np.c
+++ b/drivers/net/xsc/xsc_np.c
@@ -292,8 +292,11 @@ xsc_dev_destroy_ipat(struct xsc_dev *xdev, uint16_t logic_in_port)
 
 int
 xsc_dev_create_epat(struct xsc_dev *xdev, uint16_t dst_info, uint8_t dst_port,
-		    uint16_t qpn_ofst, uint8_t qp_num, struct rte_eth_rss_conf *rss_conf)
+		    uint16_t qpn_ofst, uint8_t qp_num,
+		    struct rte_eth_rss_conf *rss_conf,
+		    uint8_t mac_filter_en, uint8_t *mac)
 {
+	int i;
 	struct xsc_np_epat_add add;
 
 	memset(&add, 0, sizeof(add));
@@ -305,14 +308,19 @@ xsc_dev_create_epat(struct xsc_dev *xdev, uint16_t dst_info, uint8_t dst_port,
 	add.action.rss_en = 1;
 	add.action.rss_hash_func = XSC_RSS_HASH_FUNC_TOPELIZ;
 	add.action.rss_hash_template = xsc_rss_hash_template_get(rss_conf);
+	add.action.mac_filter_en = mac_filter_en;
+	for (i = 0; i < RTE_ETHER_ADDR_LEN; i++)
+		add.action.mac_addr[i] = mac[RTE_ETHER_ADDR_LEN - i - 1];
 
 	return xsc_dev_np_exec(xdev, &add, sizeof(add), XSC_NP_EPAT, XSC_NP_OP_ADD);
 }
 
 int
 xsc_dev_vf_modify_epat(struct xsc_dev *xdev, uint16_t dst_info, uint16_t qpn_ofst,
-		       uint8_t qp_num, struct rte_eth_rss_conf *rss_conf)
+		       uint8_t qp_num, struct rte_eth_rss_conf *rss_conf,
+		       uint8_t mac_filter_en, uint8_t *mac)
 {
+	int i;
 	struct xsc_np_epat_mod mod;
 
 	memset(&mod, 0, sizeof(mod));
@@ -328,6 +336,22 @@ xsc_dev_vf_modify_epat(struct xsc_dev *xdev, uint16_t dst_info, uint16_t qpn_ofs
 	mod.action.rss_en = 1;
 	mod.action.rss_hash_func = XSC_RSS_HASH_FUNC_TOPELIZ;
 	mod.action.rss_hash_template = xsc_rss_hash_template_get(rss_conf);
+	mod.action.mac_filter_en = mac_filter_en;
+	for (i = 0; i < RTE_ETHER_ADDR_LEN; i++)
+		mod.action.mac_addr[i] = mac[RTE_ETHER_ADDR_LEN - i - 1];
+
+	return xsc_dev_np_exec(xdev, &mod, sizeof(mod), XSC_NP_EPAT, XSC_NP_OP_MOD);
+}
+
+int
+xsc_dev_modify_epat_mac_filter(struct xsc_dev *xdev, uint16_t dst_info, uint8_t mac_filter_en)
+{
+	struct xsc_np_epat_mod mod;
+
+	memset(&mod, 0, sizeof(mod));
+	mod.flags |= XSC_EPAT_MAC_FILTER_EN_FLAG;
+	mod.key.dst_info = dst_info;
+	mod.action.mac_filter_en = mac_filter_en;
 
 	return xsc_dev_np_exec(xdev, &mod, sizeof(mod), XSC_NP_EPAT, XSC_NP_OP_MOD);
 }
diff --git a/drivers/net/xsc/xsc_np.h b/drivers/net/xsc/xsc_np.h
index 8933917036..ca185c0a59 100644
--- a/drivers/net/xsc/xsc_np.h
+++ b/drivers/net/xsc/xsc_np.h
@@ -35,13 +35,15 @@ struct __rte_packed_begin xsc_epat_key {
 } __rte_packed_end;
 
 struct __rte_packed_begin xsc_epat_action {
-	uint8_t rsv0[14];
-	uint8_t rsv1:4;
-	uint8_t dst_port:4;
-	uint8_t rss_hash_func:2;
-	uint8_t rss_hash_template:5;
-	uint8_t rss_en:1;
-	uint8_t qp_num;
+	uint8_t rsv0[3];
+	uint8_t mac_addr[6];
+	uint64_t mac_filter_en:1;
+	uint64_t rsv1:43;
+	uint64_t dst_port:4;
+	uint64_t rss_hash_func:2;
+	uint64_t rss_hash_template:5;
+	uint64_t rss_en:1;
+	uint64_t qp_num:8;
 	uint16_t rx_qp_id_ofst:12;
 	uint16_t rsv3:4;
 	uint8_t rsv4:7;
@@ -136,9 +138,13 @@ int xsc_dev_create_ipat(struct xsc_dev *xdev, uint16_t logic_in_port, uint16_t d
 int xsc_dev_get_ipat_vld(struct xsc_dev *xdev, uint16_t logic_in_port);
 int xsc_dev_destroy_ipat(struct xsc_dev *xdev, uint16_t logic_in_port);
 int xsc_dev_create_epat(struct xsc_dev *xdev, uint16_t dst_info, uint8_t dst_port,
-			uint16_t qpn_ofst, uint8_t qp_num, struct rte_eth_rss_conf *rss_conf);
+			uint16_t qpn_ofst, uint8_t qp_num, struct rte_eth_rss_conf *rss_conf,
+			uint8_t mac_filter_en, uint8_t *mac);
 int xsc_dev_vf_modify_epat(struct xsc_dev *xdev, uint16_t dst_info, uint16_t qpn_ofst,
-			   uint8_t qp_num, struct rte_eth_rss_conf *rss_conf);
+			   uint8_t qp_num, struct rte_eth_rss_conf *rss_conf,
+			   uint8_t mac_filter_en, uint8_t *mac);
+int xsc_dev_modify_epat_mac_filter(struct xsc_dev *xdev, uint16_t dst_info,
+				   uint8_t mac_filter_en);
 int xsc_dev_destroy_epat(struct xsc_dev *xdev, uint16_t dst_info);
 int xsc_dev_set_qpsetid(struct xsc_dev *xdev, uint32_t txqpn, uint16_t qp_set_id);
 int xsc_dev_create_vfos_baselp(struct xsc_dev *xdev);
-- 
2.25.1
