Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D24C369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 17:12:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 37487402E7;
	Wed, 16 Apr 2025 19:12:30 +0200 (CEST)
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
 by mails.dpdk.org (Postfix) with ESMTP id 2EB664025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 19:12:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=7519; q=dns/txt;
 s=iport01; t=1744823549; x=1746033149;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/N6rjasb6MeoCYjvvYfLISDCdyKhCH2P/unD9Xygf5g=;
 b=H86xbv8ZMIhiYqCyM8MdOkYhe1JGZMAYgSaDpoLYtZ4pZrhJ7whZDKfK
 HR8J8WZGrcx1qzsCN/fCVaTF49rzY6MxYIyhocO53ubfjJI9QfI9dTETx
 sWOsAxH95ZOWhu4cf0y+CWuraC0jbhoN3ADMx/clMAgLnSFUQvNjvsObL
 mJvqoBmHxnZc534YVSgMqa/ye88iXc6fNaRAaT35q8MbODI53t86wXqGI
 DkJIIYObHhryD9f+AU4mLQlBgyzxUIIFK02DtQLBYJrkmyJZ7b39ZuDQY
 STv7LVXlIbTDjhl6nJ37u5bRpM+dTocNcEGzXHvS8m8BIUy3BYi5y3QA8 A==;
X-CSE-ConnectionGUID: 1arxTr5NQVqycqL2CHwCjw==
X-CSE-MsgGUID: 37K+W704Q9+5JPepQym+AA==
X-IPAS-Result: =?us-ascii?q?A0AEAADM4/9n/5UQJK1aGQEBAQMDAQEBAQEBARYBAQEBA?=
 =?us-ascii?q?QEBAYIBBAEBAQ0BgkqBT0NIlkWeFRSBEQNWDwEBAQ9EBAEBhQeLLAImNAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZdKwsBRoEMM?=
 =?us-ascii?q?hKDAoJlA7EfgXkzgQGEfNk4gW6BSAGNTHCEdycbgUlEgRWBO4IthCkBRYYYB?=
 =?us-ascii?q?INEhFSRV4sgSIEhA1ksAVUTDQoLBwWBbAMqCwwLEhwVcTUdgXqDc4U2ghGCB?=
 =?us-ascii?q?IkThFYtT4VAQAMLGA1IESw3FBsGPm4HlziEF4EPgXhkDJMhCpAFoyaEJaFJG?=
 =?us-ascii?q?jOEA6ZUmH4igjahc4RogWc8gVkzGggbFYMiUhkPji0WyyIqMjwCBwsBAQMJk?=
 =?us-ascii?q?WUBAQ?=
IronPort-Data: A9a23:CIxFCqLDpvOHL4MbFE+Ru5QlxSXFcZb7ZxGr2PjKsXjdYENS3mBRy
 mQZD26BOvfeYzHxct8kbdu+/R4PvJeHzNAwGVcd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrQ0
 T/Oi5eHYgL9h2cqajh8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN03BVsmAZdF3N9JGHBF7
 NhCAxASRRKc0rfeLLKTEoGAh+wqKM3teYdasXZ6wHSAV7AtQIvIROPB4towMDUY358VW62AI
 ZNHL2MzPXwsYDUXUrsTIIg7keO0gX/XeDxDo1XTrq0yi4TW5FcsjuK1bIOMILRmQ+0OwWXbm
 T2eo12oQUw4DNGH8CuAsVuF07qncSTTHdh6+KeD3vJnnnWf3mAQThoMWjOTqP+wlkm6SpRVN
 lYd+S0whak06EGvCNL6WnWQvnqNsh8ZWsAWFuA29gyByavSywefGmUACDVGbbQbWNQeTDgu0
 BqN2tjuHzEq6efTQnOG/bDSpjS3UcQIEVI/ieY/ZVNty7HeTEsb13ojkv4L/HaJs+DI
IronPort-HdrOrdr: A9a23:QXKxraODtZ58sMBcTsqjsMiBIKoaSvp037Dk7S9MoHtuA6mlfq
 +V/cjzuSWYtN9zYgBDpTn/Asm9qBrnnPYfi7X5Vo3NYOCJggeVxflZnOjfK/mKIVyYygabvp
 0QF5RDNA==
X-Talos-CUID: 9a23:b6W2h27eGBBbav9Tg9ssrUcOCvw/L1vk8m7BKFacU01JV5aXVgrF
X-Talos-MUID: 9a23:38TVmghadB6s4ZOP9ElPxsMpb5hLoJvxUBw0wNZbmfGJLRVhPnS0pWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; d="scan'208";a="356204112"
Received: from alln-l-core-12.cisco.com ([173.36.16.149])
 by rcdn-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Apr 2025 17:12:27 +0000
Received: from eng-rtp-bld-31.cisco.com (eng-rtp-bld-31.cisco.com
 [172.18.47.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-12.cisco.com (Postfix) with ESMTPS id 7A44B1800015A;
 Wed, 16 Apr 2025 17:12:27 +0000 (GMT)
Received: by eng-rtp-bld-31.cisco.com (Postfix, from userid 51544)
 id 1BDDC1406899; Wed, 16 Apr 2025 13:12:27 -0400 (EDT)
From: Roger Melton <rmelton@cisco.com>
To: vladimir.medvedkin@intel.com,
	anatoly.burakov@intel.com
Cc: dev@dpdk.org,
	Roger Melton <rmelton@cisco.com>
Subject: [PATCH v2] net/ixgbe: support Rx/Tx burst mode info
Date: Wed, 16 Apr 2025 13:11:12 -0400
Message-Id: <20250416171111.3094521-1-rmelton@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 172.18.47.81, eng-rtp-bld-31.cisco.com
X-Outbound-Node: alln-l-core-12.cisco.com
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

