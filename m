Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C57C61DCD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 07:39:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7FD040DF5;
	Fri, 28 Aug 2026 09:39:42 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id F308E40A72
 for <dev@dpdk.org>; Fri, 28 Aug 2026 09:39:37 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowADn7Do3O5FqPtNzBg--.58243S2;
 Fri, 28 Aug 2026 15:39:36 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 31/45] net/sxe2: refine vectorized Tx/Rx mode setup
Date: Fri, 28 Aug 2026 15:39:35 +0800
Message-ID: <20260828073935.2249401-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
References: <20260828032731.2109423-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADn7Do3O5FqPtNzBg--.58243S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4xXw13Kw4kAFWkWw1UAwb_yoW5ZFyxpa
 yxWFWFva17JFyYgw4fXa1rXF15Kr1DXr1I9rZxu3WfG34vy34q9F4jqF95Zwn8ArZ7ArZY
 yF4Utr4kG3sYgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
 vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
 FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr
 0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAKzVCY07xG64k0F24l
 42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
 WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAK
 I48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r
 4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
 0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUcoqcUUUUU
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

Set rte_eth_tx_pkt_prepare_dummy for the simple and vectorized Tx paths
instead of leaving the prepare callback unset, and split the NEON
simple/offload mode selection based on the offload flag. Log the selected
Tx/Rx mode flags and apply the default Rx free threshold when the
configured value is zero.

Fixes: ac60f302cbef ("net/sxe2: add vectorized Rx and Tx")
Cc: stable@dpdk.org
Cc: stephen@networkplumber.org

Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_rx.c   |  3 ++-
 drivers/net/sxe2/sxe2_txrx.c | 20 +++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_rx.c b/drivers/net/sxe2/sxe2_rx.c
index d700c60083..3830c676d7 100644
--- a/drivers/net/sxe2/sxe2_rx.c
+++ b/drivers/net/sxe2/sxe2_rx.c
@@ -319,7 +319,8 @@ int32_t __rte_cold sxe2_rx_queue_setup(struct rte_eth_dev *dev,
 		rxq->mb_pool = mp;
 	}
 
-	rxq->rx_free_thresh = rx_conf->rx_free_thresh;
+	rxq->rx_free_thresh = (rx_conf->rx_free_thresh == 0) ?
+		SXE2_DEFAULT_RX_FREE_THRESH : rx_conf->rx_free_thresh;
 	rxq->port_id = dev->data->port_id;
 	rxq->offloads = offloads;
 	if (offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index 79870866d1..f7276f6a19 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -358,7 +358,7 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 	}
 
 	if (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK) {
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 #ifdef RTE_ARCH_X86
 		if (tx_mode_flags & SXE2_TX_MODE_VEC_AVX512) {
 #ifdef CC_AVX512_SUPPORT
@@ -386,21 +386,28 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 		}
 #elif defined(RTE_ARCH_ARM64)
 		if (tx_mode_flags & SXE2_TX_MODE_VEC_NEON) {
-			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
-			dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon;
+			if (tx_mode_flags & SXE2_TX_MODE_VEC_OFFLOAD) {
+				dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon;
+			} else {
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon_simple;
+			}
 		} else {
-			dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon_simple;
+			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+			dev->tx_pkt_burst = sxe2_tx_pkts;
 		}
 #endif
 	} else {
 		if (tx_mode_flags & SXE2_TX_MODE_SIMPLE_BATCH) {
-			dev->tx_pkt_prepare = NULL;
+			dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 			dev->tx_pkt_burst = sxe2_tx_pkts_simple;
 		} else {
 			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
 			dev->tx_pkt_burst = sxe2_tx_pkts;
 		}
 	}
+	PMD_LOG_DEBUG(TX, "Tx mode flags:0x%016x port_id:%u.",
+				tx_mode_flags, dev->data->port_id);
 }
 
 static const struct {
@@ -582,6 +589,9 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 		dev->rx_pkt_burst = sxe2_rx_pkts_scattered_split;
 	else
 		dev->rx_pkt_burst = sxe2_rx_pkts_scattered;
+
+	PMD_LOG_DEBUG(RX, "Rx mode flags:0x%016x port_id:%u.",
+				rx_mode_flags, dev->data->port_id);
 }
 
 static const struct {
-- 
2.52.0

