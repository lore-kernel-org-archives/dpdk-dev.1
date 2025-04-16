Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A3AC369BD
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 16:10:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8604402E7;
	Wed, 16 Apr 2025 18:10:02 +0200 (CEST)
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
 by mails.dpdk.org (Postfix) with ESMTP id 9E8154025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 18:10:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=7479; q=dns/txt;
 s=iport01; t=1744819800; x=1746029400;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dn/qCQScQN+LyCQtbN9olw8yrTpa/AP48ZEpYYkfxt0=;
 b=Ssl3NM6ZImvV0JoaYmohUpf1STb+Poj02Xk0PMhOXXd6J4rR37wZ1gso
 lxc+5qGq1TXgVTxZaMz8E5OjzC5S3fpVo/t+6WCk9I92Cq2OR/wIYcJPV
 EImmc8cOPgNfw/GRajBGh2E71npnGWDIY65FnWtyhhtiewhrOKDGsOAsU
 YUECn7QkCMEhi96nfKkJedbPEHRUE9CSW496MCmfYqUFu0t2m5vzybOpr
 nwZJpoBoXaXSNr3m/sFen0fn0tPX5P4hTpD9sXkTIMkukOYiP8tQldOga
 idlI4da4dHAsRt+blMupGuU7vCF//KxHXYv6HuG2sn8/LGAC6mbvKV7Xs Q==;
X-CSE-ConnectionGUID: g3LnNtqfQzKFlyZXJDgo8g==
X-CSE-MsgGUID: 4JzWQvC6TyaPjfNABeu7HQ==
X-IPAS-Result: =?us-ascii?q?A0AHAAD91P9n/5L/Ja1aGQEBBAQBAQEBARgBAQEBAQGCA?=
 =?us-ascii?q?gQBAQ4Bgkp2WUNIlkWeFRSBEQNWDwEBAQ8xEwQBAYUHiywCJjQJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThXsNhl0rCwFGLl4yEoMCA?=
 =?us-ascii?q?YJkA7FOgXkzgQGEfNk4gW6BSAGNTIVnJxuBSUSBFYE7gi2EKQFFhhgEgi2BF?=
 =?us-ascii?q?4RUkVeLH0iBIQNZLAFVEw0KCwcFgWwDKgsMCxIcFXE1HYF6g3OFNoIRggSJE?=
 =?us-ascii?q?4RWLU+FPEADCxgNSBEsNxQbBj5uB5c2hBaBD4F4ZAyTIQqQBaMmhCWhSRozh?=
 =?us-ascii?q?AOmUwGYfiKCNqFzhGiBZzyBWTMaCBsVgyIJSRkPji0Wgz/IQyoyAjoCBwsBA?=
 =?us-ascii?q?QMJkWUBAQ?=
IronPort-Data: A9a23:nynXkKmBPXx42pmzXCw4L47o5gz0J0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJMUG+PP/aINmKgeYx0bIjl9UsG75Pdy4JlGQpqr3s1FVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pC31GONgWYubzpIsvzb8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FYJD3uBRHXhAz
 O47BjQcXCChq+2xkL3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMiSBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZD/7C7pm9AusrmP6fjlEr1S9rqss6G+Vxwt0uFToGIaKIYLbGJgMwC50o
 Eqa3XbGOw8xauCOwAKH/FSFrOLSwgPCDdd6+LqQs6QCbEeo7mAeFjUaTVe45/6jhSaWUtRWN
 0sQ62wksLI790u1Ztj7QxC85nWDu3Y0Rd5ZH+w/6RvLz6fY/QuVBWkCZj9HdNEi8sQxQFQXO
 kShhdjlA3lr9baSU3/YrubSpjKpMi9TJmgHDcMZcTY4DxDYiNlbpnryohxLScZZUvWd9enM/
 g23
IronPort-HdrOrdr: A9a23:gfEpX688m8MfgpcL8x9uk+DTI+orL9Y04lQ7vn2ZhyY7TiX+rb
 HKoB11737JYVoqNU3I+urwWpVoP0m9yXcd2+B4Vt2ftWLd1ldAQrsP0WKb+UyCJ8U7ndQtsp
 uJtMNFebnNMWQ=
X-Talos-CUID: =?us-ascii?q?9a23=3A9DUndWl63GbpIWJuSI+dfO3SdxrXOXKG6HH2P1a?=
 =?us-ascii?q?2MHRKZrmEe2+y1Kxjw8U7zg=3D=3D?=
X-Talos-MUID: 9a23:FyGShgQc9jyC9vEeRXSwpiNdDdlDvZi/AXgPn7MvkcSZagxJbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; d="scan'208";a="473695516"
Received: from rcdn-l-core-09.cisco.com ([173.37.255.146])
 by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Apr 2025 16:09:59 +0000
Received: from eng-rtp-bld-31.cisco.com (eng-rtp-bld-31.cisco.com
 [172.18.47.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by rcdn-l-core-09.cisco.com (Postfix) with ESMTPS id 7A5E31800022E;
 Wed, 16 Apr 2025 16:09:59 +0000 (GMT)
Received: by eng-rtp-bld-31.cisco.com (Postfix, from userid 51544)
 id D3F351406899; Wed, 16 Apr 2025 12:09:58 -0400 (EDT)
From: Roger Melton <rmelton@cisco.com>
To: vladimir.medvedkin@intel.com,
	anatoly.burakov@intel.com
Cc: dev@dpdk.org,
	Roger Melton <rmelton@cisco.com>
Subject: [PATCH] net/ixgbe: support Rx/Tx burst mode info
Date: Wed, 16 Apr 2025 12:09:46 -0400
Message-Id: <20250416160946.3963682-1-rmelton@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 172.18.47.81, eng-rtp-bld-31.cisco.com
X-Outbound-Node: rcdn-l-core-09.cisco.com
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
 doc/guides/rel_notes/release_25_07.rst        |  4 ++
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  4 ++
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |  4 ++
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 70 +++++++++++++++++++
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          |  4 ++
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |  4 +-
 6 files changed, 88 insertions(+), 2 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index b83f911121..7e546a792b 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -59,6 +59,10 @@ New Features
 
   * Added support for rx_burst_mode_get and tx_burst_mode_get.
 
+* **Updated Intel ixgbe driver.**
+
+  * Added support for rx_burst_mode_get and tx_burst_mode_get.
+
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
2.26.2.Cisco

