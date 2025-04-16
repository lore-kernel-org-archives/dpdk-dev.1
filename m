Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EBCC369BA
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 17:36:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 824AB402E7;
	Wed, 16 Apr 2025 19:36:41 +0200 (CEST)
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
 by mails.dpdk.org (Postfix) with ESMTP id D4E914025A
 for <dev@dpdk.org>; Wed, 16 Apr 2025 19:36:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cisco.com; i=@cisco.com; l=4311; q=dns/txt;
 s=iport01; t=1744825000; x=1746034600;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wW4CWRqJkKbp3DJMxXF+svZQaGyMxyjT6VSBrL9yljc=;
 b=Ngcr6guyFt4CXchYXPmS7dOC5Z2NA7VnVanmQM1Z2GA5UE2KsUDg66YD
 yZ7bOwZ5Sibutywz1mQXyvC4YoFOpexQ2z90xLjxgWQ2L8b1+tHDJ3HwQ
 ZGyTf3tVmDqRMpPb/4Rciry8B0RjjdDxlOu3G7KF+Yl5fooIlQVMMWqgi
 PeIurvN3tfyPoexH/Dx+ACnVTqYQDEZlW/l8bPYaF1PMW7lXrYxyKZR8n
 evXzAdHJgK8JP9M8YhMxVPbv9mB3uRSIPAfVUJbaOM6iZitqsKI8eQZww
 xkaBcQ3hjuhw1bpuVRbPBf8Jr3ncTC8xLsDHvj7uuCSnCOE0IsgD5gnGv A==;
X-CSE-ConnectionGUID: KcLP20g4QeKq7wFhZhVGtQ==
X-CSE-MsgGUID: vNgCgeZ+Tt23B4VJsbSNOA==
X-IPAS-Result: =?us-ascii?q?A0AFAAB+6f9n/44QJK1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQGCAAMBAQEBAQsBgkqBT0NItFoUgREDVg8BAQEPRAQBA?=
 =?us-ascii?q?YUHiywCJjUIDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Th?=
 =?us-ascii?q?giGXSsLAUaBDDISgwKCZQOxO4F5M4EBhHzZOIFugUgBjUyFZycbgUlEgRWBO?=
 =?us-ascii?q?4IthCmGXgSCLYEXhFSRV4shSIEhA1ksAVUTDQoLBwWBbAMqCwwLEhwVcTUdg?=
 =?us-ascii?q?XqDc4U2ghGCBIkThFYtT4VBQAMLGA1IESw3FBsGPm4HlzmEF4EPgkQYDJMrk?=
 =?us-ascii?q?AWjJoQloUkaM4QDplMBmH4igjahc4RogWgBOoFZMxoIGxWDIlIZD44tFssJK?=
 =?us-ascii?q?jI8AgcLAQEDCZFlAQE?=
IronPort-Data: A9a23:v7KUzqx0OUuU6K4cLQB6t+dUxyrEfRIJ4+MujC+fZmUNrF6WrkUFy
 GAeUWvXPamCYmqkc9tyYIrn8k0AuZXdmoVlQARu/lhgHilAwSbn6Xt1DatR0we6dJCroJdPt
 p1GAjX4BJlqCCea/lH1b+CJQUBUjcmgXqD7BPPPJhd/TAplTDZJoR94kobVuKYw6TSCK13L4
 I6aT/H3Ygf/hmYoazxMscpvlTs21BjMkGJA1rABTagjUG/2zxE9EJ8ZLKetGHr0KqE8NvK6X
 evK0Iai9Wrf+Ro3Yvv9+losWhRXKlJ6FVHmZkt+A8BOsDAbzsAB+vpT2M4nVKtio27hc+adZ
 zl6ncfYpQ8BZsUgkQmGOvVSO3kW0aZuoNcrLZUj2CCe5xWuTpfi/xlhJGI9GbVCoukrOGxt7
 KMHBjA/bi6sm9vjldpXSsE07igiBMDvOIVavjRryivUSK57B5vCWK7No9Rf2V/chOgXQq2YP
 JRfMGQpNUiaC/FMEg9/5JYWhuKlgmX4dRVTqUmeouw85G27IAlZjOWxa4KPKoDWLSlTtli+q
 UnJ8la6Pg1Ab/bD9xie+EmKocaayEsXX6pXTtVU7MVCjFCN7mALBB5QUkG0ydGyikO4UdVPA
 0oK+yYvpO4580nDZtz0Txy9rTiPuQcBVt5RFcUg5Q2Nw7aS6AGcblXoVRZIbNgg8ctzTjsw2
 xrRwpXiBCdkt/ueTnf1GqqokA5e8BM9dQcqDRLohyNcizU/iOnfVi7yc+s=
IronPort-HdrOrdr: A9a23:fl97GqNpiVcKN8BcTsqjsMiBIKoaSvp037Dk7S9MoHtuA6mlfq
 +V/cjzuSWYtN9zYgBDpTn/Asm9qBrnnPYfi7X5Vo3NYOCJggeVxflZnOjfK/mKIVyYygabvp
 0QF5RDNA==
X-Talos-CUID: 9a23:cTdPgGMcTpPlFu5DeyJDzBRMFZwcf17Ek2j+I324N0l1cejA
X-Talos-MUID: 9a23:v6/PZAh5SbnsH1MqK7aPMMMpKuFnyKujOgMxjc9dkZW6Fzd6ABG6pWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; d="scan'208";a="454302844"
Received: from alln-l-core-05.cisco.com ([173.36.16.142])
 by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Apr 2025 17:36:38 +0000
Received: from eng-rtp-bld-31.cisco.com (eng-rtp-bld-31.cisco.com
 [172.18.47.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by alln-l-core-05.cisco.com (Postfix) with ESMTPS id E3FD918000153;
 Wed, 16 Apr 2025 17:36:38 +0000 (GMT)
Received: by eng-rtp-bld-31.cisco.com (Postfix, from userid 51544)
 id 78BF81406899; Wed, 16 Apr 2025 13:36:38 -0400 (EDT)
From: Roger Melton <rmelton@cisco.com>
To: maxime.coquelin@redhat.com,
	chenbox@nvidia.com
Cc: dev@dpdk.org,
	Roger Melton <rmelton@cisco.com>
Subject: [PATCH] net/virtio: support Rx/Tx burst mode info
Date: Wed, 16 Apr 2025 13:35:50 -0400
Message-Id: <20250416173550.603338-1-rmelton@cisco.com>
X-Mailer: git-send-email 2.35.6
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 172.18.47.81, eng-rtp-bld-31.cisco.com
X-Outbound-Node: alln-l-core-05.cisco.com
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
 doc/guides/rel_notes/release_25_07.rst |  3 +
 drivers/net/virtio/virtio_ethdev.c     | 76 ++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 093b85d206..ff2d81b400 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -55,6 +55,9 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated virtio driver.**
+
+  * Added support for rx_burst_mode_get and tx_burst_mode_get.
 
 Removed Items
 -------------
diff --git a/drivers/net/virtio/virtio_ethdev.c b/drivers/net/virtio/virtio_ethdev.c
index 1d7d10575c..2d2635b669 100644
--- a/drivers/net/virtio/virtio_ethdev.c
+++ b/drivers/net/virtio/virtio_ethdev.c
@@ -98,6 +98,11 @@ static int virtio_dev_queue_stats_mapping_set(
 static void virtio_notify_peers(struct rte_eth_dev *dev);
 static void virtio_ack_link_announce(struct rte_eth_dev *dev);
 
+static int virtio_rx_burst_mode_get(struct rte_eth_dev *dev,
+	__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
+static int virtio_tx_burst_mode_get(struct rte_eth_dev *dev,
+	__rte_unused uint16_t queue_id, struct rte_eth_burst_mode *mode);
+
 struct rte_virtio_xstats_name_off {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
 	unsigned offset;
@@ -636,6 +641,8 @@ static const struct eth_dev_ops virtio_eth_dev_ops = {
 	.rx_queue_intr_enable    = virtio_dev_rx_queue_intr_enable,
 	.rx_queue_intr_disable   = virtio_dev_rx_queue_intr_disable,
 	.tx_queue_setup          = virtio_dev_tx_queue_setup,
+	.rx_burst_mode_get       = virtio_rx_burst_mode_get,
+	.tx_burst_mode_get       = virtio_tx_burst_mode_get,
 	.rss_hash_update         = virtio_dev_rss_hash_update,
 	.rss_hash_conf_get       = virtio_dev_rss_hash_conf_get,
 	.reta_update             = virtio_dev_rss_reta_update,
@@ -1242,6 +1249,75 @@ virtio_interrupt_handler(void *param)
 	}
 }
 
+static const struct {
+	eth_tx_burst_t pkt_burst;
+	const char *info;
+} virtio_tx_burst_info[] = {
+	{	virtio_xmit_pkts, "Scalar"},
+	{	virtio_xmit_pkts_packed, "Scalar packed ring"},
+	{	virtio_xmit_pkts_inorder, "Scalar in order"},
+	{	virtio_xmit_pkts_packed_vec, "Vector packed ring"},
+};
+
+static int
+virtio_tx_burst_mode_get(struct rte_eth_dev *dev,
+				__rte_unused uint16_t queue_id,
+				struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->tx_pkt_burst;
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(virtio_tx_burst_info); i++) {
+		if (pkt_burst == virtio_tx_burst_info[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 virtio_tx_burst_info[i].info);
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
+} virtio_rx_burst_info[] = {
+	{	virtio_recv_pkts, "Scalar"},
+	{	virtio_recv_pkts_packed, "Scalar standard packed ring"},
+	{	virtio_recv_pkts_inorder, "Scalar"},
+	{	virtio_recv_mergeable_pkts, "Scalar mergeable"},
+	{	virtio_recv_mergeable_pkts_packed, "Scalar mergeable packed ring"},
+#ifdef RTE_ARCH_x86
+	{	virtio_recv_pkts_vec, "Vector SSE"},
+	{	virtio_recv_pkts_packed_vec, "Vector AVX512 packed ring"},
+#elif defined(RTE_ARCH_ARM)
+	{	virtio_recv_pkts_vec, "Vector NEON"},
+	{	virtio_recv_pkts_packed_vec, "Vector NEON packed ring"},
+#elif defined(RTE_ARCH_PPC_64)
+	{	virtio_recv_pkts_vec, "Vector Altivec"},
+	{	virtio_recv_pkts_packed_vec, "Vector Altivec packed ring"},
+#endif
+};
+
+static int
+virtio_rx_burst_mode_get(struct rte_eth_dev *dev,
+				__rte_unused uint16_t queue_id,
+				struct rte_eth_burst_mode *mode)
+{
+	eth_tx_burst_t pkt_burst = dev->rx_pkt_burst;
+	size_t i;
+
+	for (i = 0; i < RTE_DIM(virtio_rx_burst_info); i++) {
+		if (pkt_burst == virtio_rx_burst_info[i].pkt_burst) {
+			snprintf(mode->info, sizeof(mode->info), "%s",
+				 virtio_rx_burst_info[i].info);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 /* set rx and tx handlers according to what is supported */
 static void
 set_rxtx_funcs(struct rte_eth_dev *eth_dev)
-- 
2.35.6

