Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62FBC369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 17:31:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA6F6402E7;
	Wed, 16 Apr 2025 19:31:22 +0200 (CEST)
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
 by mails.dpdk.org (Postfix) with ESMTP id BED134025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 19:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=4024; q=dns/txt;
 s=iport01; t=1744824681; x=1746034281;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=765KLl1rH9TjtrOLYHb/ZqabZZIuG2AVV2/X9ZnwZZg=;
 b=e+VEBsYZOoUjtlMwRGhVgcjY9dR/b80hJO0uZqNp7BTHPmt27XnQo6pa
 y311wVYdASCtqagWl1Mbcb5DGPvTLxy9c8nnxALj/Czz9UUnc8nBOmPIS
 7Y/CyS1ar12xl/8KptuBAaM/H2cHIiZeBIac+pqscbRZ2wg/jXh+ovimW
 FoCTlGNHs1KtZqlqO99Q91iyOU7xnT4vr8DPuU9X63rG5GEdiJaa/Z7mB
 aO6A61k3c2l4hCnY/lt9ZZC1UB+eCHhptbDEbQeQaHA1blEgK95U4GyE1
 ubeK/JZsbNjLIPdWgZg3SUGr0mG3aHcRaRr4Pek8lY7IJvNro16ALXKRG w==;
X-CSE-ConnectionGUID: I/ayZR4zTEOV6ie7XvrN7Q==
X-CSE-MsgGUID: i4tQfwG3Q3eWYsVMDJHxLQ==
X-IPAS-Result: =?us-ascii?q?A0AFAACQ6P9n/4oQJK1aGgEBAQICAQEBAwEBARQBAQECA?=
 =?us-ascii?q?gEBAYIABQEBAQwBgkqBT0NIjHCnahSBEQNWDwEBAQ9EBAEBhQeLLAImNAkOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZdKwsBRoEMR?=
 =?us-ascii?q?IMCgmUDsS+BeTOBAYR82TiBboFIAY1McIR3JxuBSUSEfYQphl4Eg0SEVJFXi?=
 =?us-ascii?q?yBIgSEDWSwBVRMNCgsHBYFsAzUMCy4VcTUdgXqDc4U2ghGCBIkThFYtT4VAQ?=
 =?us-ascii?q?AMLGA1IESw3FBsGPm4HlziEF4EPglwMkyuQBaMmhCWhSRozhAOUCZJKAZh+g?=
 =?us-ascii?q?lihc4RogWc8gVkzGggbFYMiUhkPji0Wyx8qMjwCBwsBAQMJkWUBAQ?=
IronPort-Data: A9a23:FjQLSaoGNDUhrWHJTk76M9tcuZReBmKrZxIvgKrLsJaIsI4StFCzt
 garIBnSbvzbZGr2KdsnYNyw8EkF6JCHzoVqTVE+ry5jQnsaoOPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQLNNwJcaDpOtvrf8U035pwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0scwCHB8z
 6AKFB0qUE6Cir2G3qidFdA506zPLOGzVG8eknhkyTecCbMtRorOBv2To9RZxzw3wMtJGJ4yZ
 eJANmEpN0qGOkMJYwxHYH49tL/Aan3XaThVrE6So4I84nPYy0p6172F3N/9JoHUHZgNxh7Jz
 o7A12WlHigUK/PE8GGIzUO3uMrjvwPrfLtHQdVU8dYv2jV/3Fc7BBAIfVejrfr/jVSxM++zM
 GQd/i4o6Kx3/0uxQ5ylBluzoWWPuVgXXN84//AG1TxhA5H8u26xblXohBYYADD6nKfanQAX6
 2I=
IronPort-HdrOrdr: A9a23:veUOjas6T4pfWqS2oZuhxpt37skDfdV00zEX/kB9WHVpmwKj+P
 xG+85rsCMc5wxxZJhNo7290cq7MBHhHOBOgbX5VI3KNGKNhILCFu9fBOXZrwEIYxeOldK0Ec
 xbAs9D4BqaNykfsfrH
X-Talos-CUID: 9a23:R8rM6WMVfxNpnu5DeW5u5XwuRtIZX1rjknbdfH+mE0A2cejA
X-Talos-MUID: 9a23:gUSqNQWWePa2OMPq/D6wmAhsK+gz2v+jN3EWr7AqmemUERUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; d="scan'208";a="456050009"
Received: from alln-l-core-01.cisco.com ([173.36.16.138])
 by alln-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Apr 2025 17:31:20 +0000
Received: from eng-rtp-bld-31.cisco.com (eng-rtp-bld-31.cisco.com
 [172.18.47.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-01.cisco.com (Postfix) with ESMTPS id 81AB6180001B5;
 Wed, 16 Apr 2025 17:31:20 +0000 (GMT)
Received: by eng-rtp-bld-31.cisco.com (Postfix, from userid 51544)
 id 284D81406899; Wed, 16 Apr 2025 13:31:20 -0400 (EDT)
From: Roger Melton <rmelton@cisco.com>
To: dev@dpdk.org
Cc: Roger Melton <rmelton@cisco.com>
Subject: [PATCH] net/e1000: support Rx/Tx burst mode info
Date: Wed, 16 Apr 2025 13:30:57 -0400
Message-Id: <20250416173057.372482-1-rmelton@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 172.18.47.81, eng-rtp-bld-31.cisco.com
X-Outbound-Node: alln-l-core-01.cisco.com
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
 doc/guides/rel_notes/release_25_07.rst |  3 ++
 drivers/net/intel/e1000/igb_ethdev.c   | 64 ++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..794ebbee5e 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated Intel e1000 driver.**
+
+  * Added support for rx_burst_mode_get and tx_burst_mode_get.
 
 Removed Items
 -------------
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index cbd2f15f5f..7250e99af1 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -237,6 +237,10 @@ static void eth_igb_configure_msix_intr(struct rte_eth_dev *dev);
 static void eth_igbvf_interrupt_handler(void *param);
 static void igbvf_mbx_process(struct rte_eth_dev *dev);
 static int igb_filter_restore(struct rte_eth_dev *dev);
+static int igb_tx_burst_mode_get(struct rte_eth_dev *dev,
+	__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
+static int igb_rx_burst_mode_get(struct rte_eth_dev *dev,
+	__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
 
 /*
  * Define VF Stats MACRO for Non "cleared on read" register
@@ -367,6 +371,8 @@ static const struct eth_dev_ops eth_igb_ops = {
 	.tx_queue_setup       = eth_igb_tx_queue_setup,
 	.tx_queue_release     = eth_igb_tx_queue_release,
 	.tx_done_cleanup      = eth_igb_tx_done_cleanup,
+	.rx_burst_mode_get    = igb_rx_burst_mode_get,
+	.tx_burst_mode_get    = igb_tx_burst_mode_get,
 	.dev_led_on           = eth_igb_led_on,
 	.dev_led_off          = eth_igb_led_off,
 	.flow_ctrl_get        = eth_igb_flow_ctrl_get,
@@ -425,6 +431,8 @@ static const struct eth_dev_ops igbvf_eth_dev_ops = {
 	.tx_queue_setup       = eth_igb_tx_queue_setup,
 	.tx_queue_release     = eth_igb_tx_queue_release,
 	.tx_done_cleanup      = eth_igb_tx_done_cleanup,
+	.rx_burst_mode_get    = igb_rx_burst_mode_get,
+	.tx_burst_mode_get    = igb_tx_burst_mode_get,
 	.set_mc_addr_list     = eth_igb_set_mc_addr_list,
 	.rxq_info_get         = igb_rxq_info_get,
 	.txq_info_get         = igb_txq_info_get,
@@ -715,6 +723,62 @@ static int igb_flex_filter_uninit(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+static const struct {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+} igb_tx_burst_info[] = {
+	{	eth_igb_xmit_pkts, "Scalar igb"},
+	{	eth_em_xmit_pkts, "Scalar em"},
+};
+
+int
+igb_tx_burst_mode_get(struct rte_eth_dev *dev,
+				__rte_unused uint16_t queue_id,
+				struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(igb_tx_burst_info); i++) {
+		if (pkt_burst == igb_tx_burst_info[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 igb_tx_burst_info[i].info);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static const struct {
+	eth_rx_burst_t pkt_burst;
+	const char *info;
+} igb_rx_burst_info[] = {
+	{	eth_igb_recv_pkts, "Scalar igb"},
+	{	eth_igb_recv_scattered_pkts, "Scalar igb scattered"},
+	{	eth_em_recv_pkts, "Scalar em"},
+	{	eth_em_recv_scattered_pkts, "Scalar em scattered"},
+};
+
+int
+igb_rx_burst_mode_get(struct rte_eth_dev *dev,
+				__rte_unused uint16_t queue_id,
+				struct rte_eth_burst_mode *mode)
+{
+	eth_rx_burst_t pkt_burst = dev->rx_pkt_burst;
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(igb_rx_burst_info); i++) {
+		if (pkt_burst == igb_rx_burst_info[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 igb_rx_burst_info[i].info);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int
 eth_igb_dev_init(struct rte_eth_dev *eth_dev)
 {
-- 
2.35.6

