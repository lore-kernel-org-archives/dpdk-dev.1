Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1B0C61DE4
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:42:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A247D40DC9;
	Mon, 31 Aug 2026 04:42:38 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 0461740374;
 Mon, 31 Aug 2026 04:42:36 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn7DoW6pRqEtSjBg--.28045S2;
 Mon, 31 Aug 2026 10:42:30 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 15/47] net/sxe2: fix QinQ and RSS offload capability report
Date: Mon, 31 Aug 2026 10:42:30 +0800
Message-ID: <20260831024230.3230714-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn7DoW6pRqEtSjBg--.28045S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWrXrW8uFy5Jw48AFWrKrg_yoW5Cw1rpF
 4rJa4rJFs8tFySqwn5ua1xuF909r1kKw4qkF43A34FyFyUJr17XFsrtFy3Aw12kry7X3ZY
 qa43Z343C3WUGaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0
 F24lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
 0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
 17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcV
 C0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
 0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWI
 evJa73UjIFyTuYvjfU1ksgUUUUU
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

