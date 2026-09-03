Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2550AC61DD6
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 01:55:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EDD614278D;
	Thu,  3 Sep 2026 03:55:25 +0200 (CEST)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
 by mails.dpdk.org (Postfix) with ESMTP id 2C8BC4114B;
 Thu,  3 Sep 2026 03:55:22 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-05 (Coremail) with SMTP id zQCowABnlkCH05hqORRABw--.38235S2;
 Thu, 03 Sep 2026 09:55:20 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v10 15/48] net/sxe2: fix QinQ and RSS offload capability report
Date: Thu,  3 Sep 2026 09:55:19 +0800
Message-ID: <20260903015519.161978-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
References: <20260902021650.83354-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABnlkCH05hqORRABw--.38235S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrXrW8uFy5Jw48AFWrKrg_yoW5Cw1rpF
 4rJa4rJFs8tFySqwn5ua1xuF909r1kKw4qkF43A34FyFyUJr17XFsrtFy3Aw12kry7X3ZY
 qa43Z343C3WUGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
 6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
 W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAKj4xx
 MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
 0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
 wIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJV
 W8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4v38UUUUU=
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

From: Jie Liu <liujie5@linkdatatechnology.com>

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

