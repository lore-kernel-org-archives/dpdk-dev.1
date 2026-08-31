Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FDFC61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:36:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5AAE40B8C;
	Mon, 31 Aug 2026 04:35:36 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 63A5F40264;
 Mon, 31 Aug 2026 04:35:12 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABnckBX6JRq27+jBg--.24645S17;
 Mon, 31 Aug 2026 10:35:08 +0800 (CST)
From: Jie Liu <liujie5@linkdatatechnology.com>
To: dev@dpdk.org
Cc: Jie Liu <liujie5@linkdatatechnology.com>, stable@dpdk.org,
 stephen@networkplumber.org
Subject: [PATCH v7 15/47] net/sxe2: fix QinQ and RSS offload capability report
Date: Mon, 31 Aug 2026 10:34:28 +0800
Message-ID: <20260831023500.3229289-16-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
 <20260831023500.3229289-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABnckBX6JRq27+jBg--.24645S17
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrXrW8uFy5Jw48AFWrKrg_yoW5CF1UpF
 4rJa4rJFs8tFySqwn5ua1xuF909r1kKw4qkF43A34rtFyUJr17XFsrtFy3Aw1akry7X3ZY
 qa45Z343C3WUGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
 kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
 z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
 1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4U
 JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
 IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
 M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
 wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
 v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-Originating-IP: [118.112.177.181]
X-CM-SenderInfo: xolxyxrhv6zxpqngt3pdwhux5qro0w31of0z/
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

Make the QINQ offload capabilities conditional on the port VLAN
setting: only advertise RTE_ETH_TX_OFFLOAD_QINQ_INSERT,
RTE_ETH_RX_OFFLOAD_QINQ_STRIP and RTE_ETH_RX_OFFLOAD_VLAN_FILTER
when no port VLAN is configured. Report the buffer split supported
header ptypes count in sxe2_buffer_split_supported_hdr_ptypes_get().

Fixes: a2b79a93515e ("net/sxe2: support L2 filtering and MAC config")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_ethdev.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_ethdev.c b/drivers/net/sxe2/sxe2_ethdev.c
index e85e34aa1a..7a11a93dff 100644
--- a/drivers/net/sxe2/sxe2_ethdev.c
+++ b/drivers/net/sxe2/sxe2_ethdev.c
@@ -804,15 +804,11 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_RX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT |
-#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
-		RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
-#endif
 		RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
 		RTE_ETH_RX_OFFLOAD_TCP_LRO;
 
 	dev_info->tx_offload_capa =
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT |
-		RTE_ETH_TX_OFFLOAD_QINQ_INSERT |
 		RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE |
 		RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
@@ -855,14 +851,22 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 		RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
 
 
-	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_PTP)
-		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
-
 	if (sxe2_ipsec_supported(adapter)) {
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SECURITY;
 		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_SECURITY;
 	}
 
+	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_PTP)
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+
+	if (!sxe2_dev_port_vlan_check(dev)) {
+		dev_info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_QINQ_INSERT;
+#ifndef RTE_LIBRTE_SXE2_16BYTE_RX_DESC
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_QINQ_STRIP;
+#endif
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+	}
+
 	if (adapter->cap_flags & SXE2_DEV_CAPS_OFFLOAD_RSS) {
 		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_RSS_HASH;
 		dev_info->flow_type_rss_offloads  |= SXE2_RSS_HF_SUPPORT_ALL;
@@ -934,7 +938,7 @@ static int32_t sxe2_dev_infos_get(struct rte_eth_dev *dev,
 
 static const uint32_t *
 sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
-					   size_t *no_of_elements __rte_unused)
+					   size_t *no_of_elements)
 {
 	static const uint32_t ptypes[] = {
 		RTE_PTYPE_L2_ETHER,
@@ -972,6 +976,7 @@ sxe2_buffer_split_supported_hdr_ptypes_get(struct rte_eth_dev *dev __rte_unused,
 
 		RTE_PTYPE_UNKNOWN
 	};
+	*no_of_elements = RTE_DIM(ptypes) - 1;
 
 	return ptypes;
 }
-- 
2.52.0

