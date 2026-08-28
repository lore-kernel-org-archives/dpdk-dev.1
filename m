Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2652EC61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:38:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43C1540A6D;
	Fri, 28 Aug 2026 09:38:08 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 2D11140A7A
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:38:05 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn7DrbOpFqPsxzBg--.58228S2;
 Fri, 28 Aug 2026 15:38:04 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 15/45] net/sxe2: fix QinQ and RSS offload capability report
Date: Fri, 28 Aug 2026 15:38:03 +0800
Message-ID: <20260828073803.2248337-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn7DrbOpFqPsxzBg--.58228S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrXFy7Gw13XF48JrW3GFg_yoW5ZrWfpF
 4rJa4rJFs8tFySqwn5ua1xuF90kr1kKw4qkF43A34FyFyUJr17XFsrtFy3Aw12kry7X3ZY
 qa43Z343C3WUGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkqb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
 C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
 Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJV
 W8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF
 04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY
 6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8gtxDUUUUU==
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
when no port VLAN is configured. Advertise RTE_ETH_RX_OFFLOAD_RSS_HASH
unconditionally and report the buffer split supported header ptypes
count in sxe2_buffer_split_supported_hdr_ptypes_get().

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

