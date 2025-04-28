Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE42AC369D5
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Apr 2025 21:31:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 941BC40661;
	Mon, 28 Apr 2025 23:31:03 +0200 (CEST)
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 by mails.dpdk.org (Postfix) with ESMTP id 05E504026C
 for <dev@dpdk.org>; Mon, 28 Apr 2025 23:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=7407; q=dns/txt;
 s=iport01; t=1745875862; x=1747085462;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xdUt2wblsOel7cKaXAQOFxTbdgCEjvHxtJGdZECH83s=;
 b=IMLjiftcPrvWr3vPctW/VL3UU6kvy3+CsCgZG0qaSU6B6JhKno2qiFxl
 tjh7tPJPxVJGP0W/lz1a1X0rv87rR6/vLxenugFv8njyvlujk7A6eMO0T
 bbXJ2oe3wWcOH/055W3ArM9kalIvuU5Tb14l+6uXtPUgIEtIKHyBdAHph
 YUdzF8T1lWEqy8ed7e45bVghLlYh2saSJRtFf61INHdLD9pSFwgPv2AX7
 wJ6cAu+BCrV1YtYt6eII4P8HL7cXgTkv33tXxb3rJacdZvVDnqZY2GCQX
 v9yo0l4J74aVnsb+oRmLRNPeL8kTAlh5ehtNcwfkzk4VE5Ai9Uwk4UWwb w==;
X-CSE-ConnectionGUID: rgWscAW+SuirzxQ74WcKkw==
X-CSE-MsgGUID: ejG++/WuTGK+PW3GiNbx+g==
X-IPAS-Result: =?us-ascii?q?A0AFAAAt8g9o/48QJK1aGQEBAQECAgEBAQEBAQEBARQBA?=
 =?us-ascii?q?QEBAQEBAQEBggEDAQEBAQwBgkqBT0NIlkWeFhSBEQNWDwEBAQ9EBAEBhQcCi?=
 =?us-ascii?q?zACJjUIDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThgiGW?=
 =?us-ascii?q?wIBAycLAUYQUSsrBxKDAoJlA7EYgXkzgQGEfNk4gW6BSQGNTHCEdycbgUlEg?=
 =?us-ascii?q?RWBO4IthCkBRYYYBINDgUeRGos8SIEhA1ksAVUTDQoLBwWBaQMqCwwLEhwVb?=
 =?us-ascii?q?jMdghGFIYIPggeJCoRQLU+FMYFDQAMLGA1IESw3FBsGPm4HlUODa4EPgXhkD?=
 =?us-ascii?q?JMhCpAHoyiEJaFJGjOEA6ZUmH4igjahdIRpgWkBOYFZMxoIGxWDIlIZD44tF?=
 =?us-ascii?q?rpPKjI8AgcLAQEDCZFlAQE?=
IronPort-Data: A9a23:UyJAqK54nRQGtK3YE3ViwAxRtFLGchMFZxGqfqrLsTDasY5as4F+v
 mEcX2yFaf/YYTbyfooiaY7i90JQvZLUy9FiHQE4qyw3Zn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr/qUzBHf/g2Qpaj5Ou/rZwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eJ4In4e1ePiJ16
 P0COiA0MUy8jMG13+fuIgVsrpxLwMjDNYcbvDRkiDreF/tjGc6FSKTR7tge1zA17ixMNa+BP
 IxCN3w2MlKZP0Yn1lQ/UPrSmM+yg3T7bzpegFmUvqEwpWPUyWSd1ZCxb4uMJ4LUHJ89ckCwq
 2DpvCe+PQwmG//c8QXe3XOKjP+MknauMG4VPPjinhJwu3Wfy3I7BAUaVh28u/bRoke4Us5YL
 11S8Dc0pKs16mSqSMXwW1uzp3vslgAYUtZRFuwgrgSAxrTZ7wWYAEAFSCJMbJots8peeNAx/
 laNm9WsAXlkt6eYDCrDsLyVtji1fyMSKAfueBM5cOfM2PG7yKlbs/4FZo8L/HKd5jEtJQzN/
 g==
IronPort-HdrOrdr: A9a23:Gcq0AKlYgTeigCgQve9lLea5P0npDfIr3DAbv31ZSRFFG/FwWf
 rAoB19726StN9/YhAdcLy7VZVoBEmsl6KdgrNhWYtKIjOHhILAFugLhuHfKn/bakjDH4Vmu5
 uIHZITNDSJNykYsS4/izPIaurJB7K8gcaVuds=
X-Talos-CUID: 9a23:Bn7dYGyCIIqUkzTd+jWgBgUOFf8+eVTij0zNIlWqGV82FIKealyPrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3Aj3Rkgg4vKyTF22rglnKKACJ7xoxl4YvtSwcyjKk?=
 =?us-ascii?q?pmIq8CndfOhGXnHe4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,247,1739836800"; d="scan'208";a="479156612"
Received: from alln-l-core-06.cisco.com ([173.36.16.143])
 by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 28 Apr 2025 21:31:00 +0000
Received: from eng-rtp-bld-31.cisco.com (eng-rtp-bld-31.cisco.com
 [172.18.47.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-06.cisco.com (Postfix) with ESMTPS id C8F301800012A;
 Mon, 28 Apr 2025 21:31:00 +0000 (GMT)
Received: by eng-rtp-bld-31.cisco.com (Postfix, from userid 51544)
 id 6EDE31406899; Mon, 28 Apr 2025 17:31:00 -0400 (EDT)
From: Roger Melton <rmelton@cisco.com>
To: vladimir.medvedkin@intel.com,
	anatoly.burakov@intel.com
Cc: dev@dpdk.org,
	Roger Melton <rmelton@cisco.com>
Subject: [PATCH v4] net/ixgbe: support Rx/Tx burst mode info
Date: Mon, 28 Apr 2025 17:29:22 -0400
Message-Id: <20250428212921.3674799-1-rmelton@cisco.com>
X-Mailer: git-send-email 2.35.6
In-Reply-To: <20250416172310.82448-1-rmelton@cisco.com>
References: <20250416172310.82448-1-rmelton@cisco.com>
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
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  2 +
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 70 +++++++++++++++++++
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  4 ++
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |  4 +-
 6 files changed, 85 insertions(+), 2 deletions(-)

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
index 8ad841ea2c..5bf8de4be6 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.h
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.h
@@ -523,6 +523,8 @@ struct ixgbe_vf_representor {
 
 int ixgbe_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params);
 int ixgbe_vf_representor_uninit(struct rte_eth_dev *ethdev);
+uint16_t ixgbe_vf_representor_rx_burst(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts);
+uint16_t ixgbe_vf_representor_tx_burst(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts);
 
 #define IXGBE_DEV_FDIR_CONF(dev) \
 	(&((struct ixgbe_adapter *)(dev)->data->dev_private)->fdir_conf)
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.c b/drivers/net/intel/ixgbe/ixgbe_rxtx.c
index 77773d56ef..95c80ac1b8 100644
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
+	{	ixgbe_recv_pkts_bulk_alloc, "Scalar bulk alloc"},
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
index 54569c7ade..641f982b01 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -204,6 +204,8 @@ struct ixgbe_txq_ops {
  * in dev_init by secondary process when attaching to an existing ethdev.
  */
 void ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq);
+int ixgbe_tx_burst_mode_get(struct rte_eth_dev *dev,
+		uint16_t queue_id, struct rte_eth_burst_mode *mode);
 
 /**
  * Sets the rx_pkt_burst callback in the ixgbe rte_eth_dev instance.
@@ -220,6 +222,8 @@ void ixgbe_set_tx_function(struct rte_eth_dev *dev, struct ci_tx_queue *txq);
  * @dev rte_eth_dev handle
  */
 void ixgbe_set_rx_function(struct rte_eth_dev *dev);
+int ixgbe_rx_burst_mode_get(struct rte_eth_dev *dev,
+		uint16_t queue_id, struct rte_eth_burst_mode *mode);
 
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

