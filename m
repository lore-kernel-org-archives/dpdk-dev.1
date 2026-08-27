Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F378C61DBD
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 02:39:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0809240E01;
	Thu, 27 Aug 2026 04:39:55 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9200640B9C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 04:39:22 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-01 (Coremail) with SMTP id qwCowAC3i+9Yo49qtJOjBg--.32567S2;
 Thu, 27 Aug 2026 10:39:21 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v4 31/44] net/sxe2: refine vectorized Tx/Rx mode setup
Date: Thu, 27 Aug 2026 10:39:20 +0800
Message-ID: <20260827023920.1431552-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
References: <20260826085836.993490-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAC3i+9Yo49qtJOjBg--.32567S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4xXw13Kw4fGr13KryrCrg_yoW5Cw48pa
 yxWFWFv3W7JFyYgw4fZa1ruF15Kr1DXryI9rZxC3WfC34vy34qvF4jqF95Zwn8ArZ7ArZY
 yF4Utw4kG39YgF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
 0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr
 1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCF04k2
 0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
 8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
 IxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMI
 IF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E
 87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxK9aDUUUU
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
 drivers/net/sxe2/sxe2_txrx.c | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

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
index 79870866d1..d27d2ce630 100644
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
@@ -386,21 +386,25 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 		}
 #elif defined(RTE_ARCH_ARM64)
 		if (tx_mode_flags & SXE2_TX_MODE_VEC_NEON) {
-			dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
-			dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon;
-		} else {
-			dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon_simple;
+			if (tx_mode_flags & SXE2_TX_MODE_VEC_OFFLOAD) {
+				dev->tx_pkt_prepare = sxe2_tx_pkts_prepare;
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon;
+			} else {
+				dev->tx_pkt_burst = sxe2_tx_pkts_vec_neon_simple;
+			}
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
@@ -582,6 +586,9 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
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

