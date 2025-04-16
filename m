Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EDDC369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 17:24:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CDCC402E7;
	Wed, 16 Apr 2025 19:24:49 +0200 (CEST)
Received: from alln-iport-5.cisco.com (alln-iport-5.cisco.com [173.37.142.92])
 by mails.dpdk.org (Postfix) with ESMTP id 8DE724025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 19:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=7519; q=dns/txt;
 s=iport01; t=1744824287; x=1746033887;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/N6rjasb6MeoCYjvvYfLISDCdyKhCH2P/unD9Xygf5g=;
 b=VQm4lfeZQfaGLYGFuDBmuruV71K5VCFvHv1d74ueItZuQvZKI/r1duON
 5zpnuol57OQjcVojVcRtnmjuDmz7ElAXuDSjLXydVngjawRsoki7NO296
 jLj+wISDhay9K84iZBibyP9spm7xa2Gau1dzzjy9GSOQO+WgziIu+phA5
 EO/rjPYfwd6szVPsIcXYUpUkedibC/iPwYlVWmwkdyRduOvmfxqG758eh
 L5D8NvwwEOc3r41D3w9HKtWeR86VOZc5gBxh3+TH7CmBum6Hp5dN90Hoz
 hsEQtSxjsRGZMVFNipMS8rZmnS+WY2UsWSGHA6nQIcGt3qS1vKjuHSrir g==;
X-CSE-ConnectionGUID: VymjPC8ETr2TKbArGlSevA==
X-CSE-MsgGUID: YTP4vr2nRPKIWwOpkQolTw==
X-IPAS-Result: =?us-ascii?q?A0ADAACm5v9n/48QJK1aGQEBAQECAgEBAQEBAQEBARQBA?=
 =?us-ascii?q?QEBAQEBAQEBggAEAQEBAQwBgkqBT0NIjHCJVZ4VFIERA1YPAQEBD0QEAQGFB?=
 =?us-ascii?q?wKLKgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGC?=
 =?us-ascii?q?IZbAgEDJwsBRhBRKysHEoMCgmUDsTeBeTOBAYR82TiBboFIAY1McIR3JxuBS?=
 =?us-ascii?q?USBFYE7gi2EKQFFhhgEg0SEVJFXiyBIgSEDWSwBVRMNCgsHBYFsAyoLDAsSH?=
 =?us-ascii?q?BVxNR2BeoNzhTaCEYIEiROEVi1PhUBAAwsYDUgRLDcUGwY+bgeXOIQXgQ+Be?=
 =?us-ascii?q?GQMkyEKkAWjJoQloUkaM4QDplSYfiKCNqFzhGiBZzyBWTMaCBsVgyJSGQ+OL?=
 =?us-ascii?q?RbLICoyPAIHCwEBAwmRZQEB?=
IronPort-Data: A9a23:1nbfxKNobxc5KJjvrR3PlsFynXyQoLVcMsEvi/4bfWQNrUp20jMPx
 msYXGiFM/rbYzD1ctEiOo/gp0kCvMfQzYdiSHM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/Wl7lV
 e/a+ZWFZQf5gmAsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj68t/CUMOFt01xvwtPUJE3
 OY3LAsAcDnW0opawJrjIgVtrs0nKM+uOMYUvWttiGmHS/0nWpvEBa7N4Le03h9p2ZsIRqiYP
 pRfMGY0BPjDS0Un1lM/EpczmPuvgFH0ciZTrxSeoq9fD237kFEuj+a1aoWFEjCMbfRpphqGv
 DjAxVzaIy4FE8Sc8D2Bzm3504cjmgu+Aur+DoaQ+vN0qFGLym9VDwcZPXOyp/CljUqvHdhCM
 UUX/TQGrK4u+UjtRd74NzWmpHeIvxsdQZxVHuEk5Q2Oy6z84gCFC2xCRTlEAOHKr+c/QTgsk
 1vMlNTzCHk37vueSGmW8fGfqjba1TUpEFLurBQsFWMti+QPaqlq5v4TZr6PyJKIs+A=
IronPort-HdrOrdr: A9a23:bqDC6qM06aKaNcBcTsajsMiBIKoaSvp037Dk7S9MoHtuA6ulfq
 +V/cjzuSWYtN9VYgBDpTniAtjlfZqjz/5ICOAqVN/INjUO+lHYSb2KhrGN/9SPIUHDH5ZmpM
 Rdm2wUMqyIMbC85vyKhjWFLw==
X-Talos-CUID: 9a23:dHnxt2yVmeHdYx39xnrUBgUqC8UnSlaN4UvKeXObA09zZ7muREG5rfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Ab1/5Eg0/0emi/9elUFd2cNNVszUj0piWVF4Xy5M?=
 =?us-ascii?q?8g+qlCjNXIzSkizCLXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; d="scan'208";a="457760278"
Received: from alln-l-core-06.cisco.com ([173.36.16.143])
 by alln-iport-5.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Apr 2025 17:24:46 +0000
Received: from eng-rtp-bld-31.cisco.com (eng-rtp-bld-31.cisco.com
 [172.18.47.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-06.cisco.com (Postfix) with ESMTPS id 7CAA418000119;
 Wed, 16 Apr 2025 17:24:46 +0000 (GMT)
Received: by eng-rtp-bld-31.cisco.com (Postfix, from userid 51544)
 id 225B91406899; Wed, 16 Apr 2025 13:24:46 -0400 (EDT)
From: Roger Melton <rmelton@cisco.com>
To: vladimir.medvedkin@intel.com,
	anatoly.burakov@intel.com
Cc: dev@dpdk.org,
	Roger Melton <rmelton@cisco.com>
Subject: [PATCH v3] net/ixgbe: support Rx/Tx burst mode info
Date: Wed, 16 Apr 2025 13:23:11 -0400
Message-Id: <20250416172310.82448-1-rmelton@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20250416171111.3094521-1-rmelton@cisco.com>
References: <20250416171111.3094521-1-rmelton@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 172.18.47.81, eng-rtp-bld-31.cisco.com
X-Outbound-Node: alln-l-core-06.cisco.com
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

Return burst mode according to the selected Rx/Tx burst
function name.
Update 25.07 release notes with this information.

Signed-off-by: Roger Melton <rmelton@cisco.com>
---
 doc/guides/rel_notes/release_25_07.rst        |  3 +
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  4 ++
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  4 ++
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 70 +++++++++++++++++++
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  4 ++
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |  4 +-
 6 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..30bc9622ee 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel ixgbe driver.**
+
+  * Added support for rx_burst_mode_get and tx_burst_mode_get.
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 0fa4898aba..f1fd271a0a 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -532,6 +532,8 @@ static const struct eth_dev_ops ixgbe_eth_dev_ops = {
 	.rx_queue_release     = ixgbe_dev_rx_queue_release,
 	.tx_queue_setup       = ixgbe_dev_tx_queue_setup,
 	.tx_queue_release     = ixgbe_dev_tx_queue_release,
+	.rx_burst_mode_get    = ixgbe_rx_burst_mode_get,
+	.tx_burst_mode_get    = ixgbe_tx_burst_mode_get,
 	.dev_led_on           = ixgbe_dev_led_on,
 	.dev_led_off          = ixgbe_dev_led_off,
 	.flow_ctrl_get        = ixgbe_flow_ctrl_get,
@@ -605,6 +607,8 @@ static const struct eth_dev_ops ixgbevf_eth_dev_ops = {
 	.tx_queue_release     = ixgbe_dev_tx_queue_release,
 	.rx_queue_intr_enable = ixgbevf_dev_rx_queue_intr_enable,
 	.rx_queue_intr_disable = ixgbevf_dev_rx_queue_intr_disable,
+	.rx_burst_mode_get    = ixgbe_rx_burst_mode_get,
+	.tx_burst_mode_get    = ixgbe_tx_burst_mode_get,
 	.mac_addr_add         = ixgbevf_add_mac_addr,
 	.mac_addr_remove      = ixgbevf_remove_mac_addr,
 	.set_mc_addr_list     = ixgbe_dev_set_mc_addr_list,
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.h b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
index 8ad841ea2c..7b1cfe0ea4 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -523,6 +523,10 @@ struct ixgbe_vf_representor {
 
 int ixgbe_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params);
 int ixgbe_vf_representor_uninit(struct rte_eth_dev *ethdev);
+uint16_t ixgbe_vf_representor_rx_burst(__rte_unused void *rx_queue,
+	__rte_unused struct rte_mbuf **rx_pkts, __rte_unused uint16_t nb_pkts);
+uint16_t ixgbe_vf_representor_tx_burst(__rte_unused void *tx_queue,
+	__rte_unused struct rte_mbuf **tx_pkts, __rte_unused uint16_t nb_pkts);
 
 #define IXGBE_DEV_FDIR_CONF(dev) \
 	(&((struct ixgbe_adapter *)(dev)->data->dev_private)->fdir_conf)
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 77773d56ef..209dbe6685 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.c
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
@@ -2626,6 +2626,39 @@ static const struct ixgbe_txq_ops def_txq_ops = {
 	.reset = ixgbe_reset_tx_queue,
 };
 
+static const struct {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+} ixgbe_tx_burst_info[] = {
+	{	ixgbe_xmit_pkts, "Scalar"},
+	{	ixgbe_xmit_pkts_simple, "Scalar simple"},
+	{       ixgbe_vf_representor_tx_burst, "Scalar representor"},
+#ifdef RTE_ARCH_X86
+	{	ixgbe_xmit_pkts_vec, "Vector SSE"},
+#elif defined(RTE_ARCH_ARM)
+	{	ixgbe_xmit_pkts_vec, "Vector NEON"},
+#endif
+};
+
+int
+ixgbe_tx_burst_mode_get(struct rte_eth_dev *dev,
+				__rte_unused uint16_t queue_id,
+				struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(ixgbe_tx_burst_info); i++) {
+		if (pkt_burst == ixgbe_tx_burst_info[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 ixgbe_tx_burst_info[i].info);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 /* Takes an ethdev and a queue and sets up the tx function to be used based on
  * the queue parameters. Used in tx_queue_setup by primary process and then
  * in dev_init by secondary process when attaching to an existing ethdev.
@@ -4939,6 +4972,43 @@ ixgbe_set_ivar(struct rte_eth_dev *dev, u8 entry, u8 vector, s8 type)
 	}
 }
 
+static const struct {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+} ixgbe_rx_burst_info[] = {
+	{	ixgbe_recv_pkts, "Scalar"},
+	{	ixgbe_recv_pkts_bulk_alloc, "Scalar bulk allod"},
+	{	ixgbe_recv_pkts_lro_bulk_alloc, "Scalar LRO bulk alloc"},
+	{	ixgbe_recv_pkts_lro_single_alloc, "Scalar LRO single alloc"},
+	{       ixgbe_vf_representor_rx_burst, "Scalar representor"},
+#ifdef RTE_ARCH_X86
+	{	ixgbe_recv_pkts_vec, "Vector SSE"},
+	{	ixgbe_recv_scattered_pkts_vec, "Vector SSE scattered"},
+#elif defined(RTE_ARCH_ARM)
+	{	ixgbe_recv_pkts_vec, "Vector NEON"},
+	{	ixgbe_recv_scattered_pkts_vec, "Vector NEON scattered"},
+#endif
+};
+
+int
+ixgbe_rx_burst_mode_get(struct rte_eth_dev *dev,
+				__rte_unused uint16_t queue_id,
+				struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->rx_pkt_burst;
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(ixgbe_rx_burst_info); i++) {
+		if (pkt_burst == ixgbe_rx_burst_info[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 ixgbe_rx_burst_info[i].info);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 void __rte_cold
 ixgbe_set_rx_function(struct rte_eth_dev *dev)
 {
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 54569c7ade..3487073d30 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -204,6 +204,8 @@ struct ixgbe_txq_ops {
  * in dev_init by secondary process when attaching to an existing ethdev.
  */
 void ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq);
+int ixgbe_tx_burst_mode_get(struct rte_eth_dev *dev,
+		__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
 
 /**
  * Sets the rx_pkt_burst callback in the ixgbe rte_eth_dev instance.
@@ -220,6 +222,8 @@ void ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq);
  * @dev rte_eth_dev handle
  */
 void ixgbe_set_rx_function(struct rte_eth_dev *dev);
+int ixgbe_rx_burst_mode_get(struct rte_eth_dev *dev,
+		__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
 
 int ixgbe_check_supported_loopback_mode(struct rte_eth_dev *dev);
 uint16_t ixgbe_recv_pkts_vec(void *rx_queue, struct rte_mbuf **rx_pkts,
diff --git a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
index bd528ff346..901d80e406 100644
--- a/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
+++ b/drivers/net/intel/ixgbe/ixgbe_vf_representor.c
@@ -157,14 +157,14 @@ static const struct eth_dev_ops ixgbe_vf_representor_dev_ops = {
 	.mac_addr_set		= ixgbe_vf_representor_mac_addr_set,
 };
 
-static uint16_t
+uint16_t
 ixgbe_vf_representor_rx_burst(__rte_unused void *rx_queue,
 	__rte_unused struct rte_mbuf **rx_pkts, __rte_unused uint16_t nb_pkts)
 {
 	return 0;
 }
 
-static uint16_t
+uint16_t
 ixgbe_vf_representor_tx_burst(__rte_unused void *tx_queue,
 	__rte_unused struct rte_mbuf **tx_pkts, __rte_unused uint16_t nb_pkts)
 {
-- 
2.35.6

