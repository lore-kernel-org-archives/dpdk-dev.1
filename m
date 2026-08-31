Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22572C61DE2
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Aug 2026 02:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58B2640E41;
	Mon, 31 Aug 2026 04:46:20 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 1F7FB40E27;
 Mon, 31 Aug 2026 04:45:53 +0200 (CEST)
Received: from localhost.localdomain (unknown [118.112.177.181])
 by APP-03 (Coremail) with SMTP id rQCowABncD7e6pRq89yjBg--.55231S2;
 Mon, 31 Aug 2026 10:45:52 +0800 (CST)
From: liujie5@linkdatatechnology.com
To: stephen@networkplumber.org
Cc: dev@dpdk.org,
	Jie Liu <liujie5@linkdatatechnology.com>,
	stable@dpdk.org
Subject: [PATCH v7 47/47] net/sxe2: fix VEC mode selection in mode set
 functions
Date: Mon, 31 Aug 2026 10:45:49 +0800
Message-ID: <20260831024549.3231744-1-liujie5@linkdatatechnology.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
References: <20260828074056.2250222-1-liujie5@linkdatatechnology.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowABncD7e6pRq89yjBg--.55231S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrWxury3KryxZF4fGry3Arb_yoWrGw1kpa
 1rGFWFkas8XF90q3yfJrWxWr45Gr1xJryDCrWrAF15u3sFkF12yw1ftF13tFy5ZrZruFn5
 Aay0y3ZrGay8WaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
 JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
 4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
 Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lw4CEc2x0rVAK
 j4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26F1j6w1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 W8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8
 Jr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0pR9NV
 PUUUUU=
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

The Tx/Rx mode set functions pre-assigned tx_mode_flags/rx_mode_flags
from vec_flags (SXE2_{TX,RX}_MODE_VEC_SIMPLE or _VEC_OFFLOAD) before
the per-ISA capability checks. As SXE2_{TX,RX}_MODE_VEC_SET_MASK
includes the SIMPLE and OFFLOAD bits, the subsequent
"(flags & SET_MASK) == 0" guards never matched, so the AVX2 and SSE
VEC mode bits were never set and the vectorized path fell back to SSE
even when AVX2 was available.

Remove the pre-assignment and OR in "vec_flags | MODE" at each ISA
selection branch so the correct VEC mode bit is selected on every
architecture.

Fixes: ac60f302cbef ("net/sxe2: add vectorized Rx and Tx")
Cc: stable@dpdk.org
Signed-off-by: Jie Liu <liujie5@linkdatatechnology.com>
---
 drivers/net/sxe2/sxe2_txrx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_txrx.c b/drivers/net/sxe2/sxe2_txrx.c
index f7276f6a19..824ac1a3f2 100644
--- a/drivers/net/sxe2/sxe2_txrx.c
+++ b/drivers/net/sxe2/sxe2_txrx.c
@@ -319,13 +319,12 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 		ret = sxe2_tx_vec_support_check(dev, &vec_flags);
 		if (ret == 0 &&
 		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-			tx_mode_flags = vec_flags;
 #ifdef RTE_ARCH_X86
 			if ((rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512) &&
 			    (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
 			    (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)) {
 #ifdef CC_AVX512_SUPPORT
-				tx_mode_flags |= SXE2_TX_MODE_VEC_AVX512;
+				tx_mode_flags |= (vec_flags | SXE2_TX_MODE_VEC_AVX512);
 #else
 				PMD_LOG_INFO(TX, "AVX512 is not supported in build env.");
 #endif
@@ -334,10 +333,10 @@ void sxe2_tx_mode_func_set(struct rte_eth_dev *dev)
 			    ((rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1) ||
 			    (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1)) &&
 			    (rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256))
-				tx_mode_flags |= SXE2_TX_MODE_VEC_AVX2;
+				tx_mode_flags |= (vec_flags | SXE2_TX_MODE_VEC_AVX2);
 
 			if ((0 == (tx_mode_flags & SXE2_TX_MODE_VEC_SET_MASK)))
-				tx_mode_flags |=  SXE2_TX_MODE_VEC_SSE;
+				tx_mode_flags |= (vec_flags | SXE2_TX_MODE_VEC_SSE);
 #elif defined(RTE_ARCH_ARM64)
 			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_NEON) == 1)
 				tx_mode_flags |= (vec_flags | SXE2_TX_MODE_VEC_NEON);
@@ -520,13 +519,12 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 		ret = sxe2_rx_vec_support_check(dev, &vec_flags);
 		if (ret == 0 &&
 		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128) {
-			rx_mode_flags = vec_flags;
 #ifdef RTE_ARCH_X86
 			if ((rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512) &&
 				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
 				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1)) {
 #ifdef CC_AVX512_SUPPORT
-				rx_mode_flags |= SXE2_RX_MODE_VEC_AVX512;
+				rx_mode_flags |= (vec_flags | SXE2_RX_MODE_VEC_AVX512);
 #else
 				PMD_LOG_INFO(RX, "AVX512 support detected but not enabled");
 #endif
@@ -535,11 +533,11 @@ void sxe2_rx_mode_func_set(struct rte_eth_dev *dev)
 				((rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1) ||
 				(rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1)) &&
 				(rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256))
-				rx_mode_flags |= SXE2_RX_MODE_VEC_AVX2;
+				rx_mode_flags |= (vec_flags | SXE2_RX_MODE_VEC_AVX2);
 
 			if (((rx_mode_flags & SXE2_RX_MODE_VEC_SET_MASK) == 0) &&
 				rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128)
-				rx_mode_flags |= SXE2_RX_MODE_VEC_SSE;
+				rx_mode_flags |= (vec_flags | SXE2_RX_MODE_VEC_SSE);
 
 #elif defined(RTE_ARCH_ARM64)
 			if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_NEON) == 1) {
-- 
2.52.0

