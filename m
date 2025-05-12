Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C5C3ABCB
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 May 2025 21:52:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4CBEF402D7;
	Mon, 12 May 2025 23:52:12 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7A5BB4025F;
 Mon, 12 May 2025 23:52:10 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 7C27B211429F; Mon, 12 May 2025 14:52:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7C27B211429F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1747086729;
 bh=LdOPz59NmKWkDeVsNKdLZiIgH7DvUJIUd2a1/UutqF8=;
 h=From:To:Cc:Subject:Date:From;
 b=CfVSwZiGO0Oa6KE9kdk3Y5XQodVnHovMOQd/ogbcLMK4OVkOmcNClL8IxleYkN77b
 Y4P6EOC9/FntOBaIc/nq3xyJ5113VskGORcFvxvrThhU4FOrQwF6qv2rK0xEgQjELP
 G19YCbdcSUaNeUxQNDvuS8WCPZ4jiDGPWG6AQvP8=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH] net/mana: check for vendor_part_id when probing RDMA device
Date: Mon, 12 May 2025 14:52:02 -0700
Message-Id: <1747086722-456-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
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

From: Long Li <longli@microsoft.com>

The RDMA kernel driver may expose two MANA RDMA devices, for RC and RAW
QP types. The purpose is to support fast service mode at SOC. Depending
on kernel version, the probe may fail if DPDK picks up the wrong device.

Add check for vendor_part_id and RAW QP capability when probing the MANA
device. This check is compatible with all kernel versions.

Fixes: 517ed6e2d590 ("net/mana: add basic driver with build environment")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/mana/mana.c | 14 ++++++++++++++
 drivers/net/mana/mana.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 2934da29f7..c42a987a30 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -1490,6 +1490,20 @@ mana_pci_probe_mac(struct rte_pci_device *pci_dev,
 			continue;
 		}
 
+		if (dev_attr.orig_attr.vendor_part_id) {
+			if (dev_attr.orig_attr.vendor_part_id !=
+			    GDMA_DEVICE_MANA) {
+				DRV_LOG(INFO, "Skip device vendor part id %x",
+					dev_attr.orig_attr.vendor_part_id);
+				continue;
+			}
+			if (!dev_attr.raw_packet_caps) {
+				DRV_LOG(INFO,
+					"Skip device without RAW support");
+				continue;
+			}
+		}
+
 		for (port = 1; port <= dev_attr.orig_attr.phys_port_cnt;
 		     port++) {
 			struct rte_ether_addr addr;
diff --git a/drivers/net/mana/mana.h b/drivers/net/mana/mana.h
index 855d98911b..6309cae76b 100644
--- a/drivers/net/mana/mana.h
+++ b/drivers/net/mana/mana.h
@@ -12,6 +12,10 @@ struct mana_shared_data {
 	RTE_ATOMIC(uint32_t) secondary_cnt;
 };
 
+/* vendor_part_id returned from ibv_query_device */
+#define GDMA_DEVICE_MANA	2
+#define GDMA_DEVICE_MANA_IB	3
+
 #define MANA_MAX_MTU	9000
 #define MIN_RX_BUF_SIZE	1024
 #define MANA_MAX_MAC_ADDR 1
-- 
2.34.1

