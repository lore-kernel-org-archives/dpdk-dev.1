Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12127CA5FCE
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:30:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DFBF640658;
	Mon,  5 Oct 2026 08:30:24 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id EDDE1402B5
 for <dev@dpdk.org>; Mon,  5 Oct 2026 08:30:21 +0200 (CEST)
Received: from ar (unknown [42.58.232.122])
 by APP-03 (Coremail) with SMTP id rQCowADX4T_7Q8NqowCoCQ--.287S2;
 Mon, 05 Oct 2026 14:30:20 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH 1/2] lpm: load tbl24 entries up front in scalar lookupx4
Date: Sun,  4 Oct 2026 23:30:17 -0700
Message-ID: <a15de663ab1703af8dcb0bd8f41a503d91af4cfe.1791181595.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791181595.git.sunyuechi@iscas.ac.cn>
References: <cover.1791181595.git.sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADX4T_7Q8NqowCoCQ--.287S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW8Xw1UXFW5uryfAFWUJwb_yoW8uw43p3
 9xCrW3Jr18Xr1fGw1Sqr4UXF4Ygr1xKrsrX3srC3yfJF4S9w1FqFykGr1j9345CryfZrs8
 tF42ya18uF17ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUdEfOUUUUU=
X-Originating-IP: [42.58.232.122]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRQLAmrDI35BYQAAsA
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

Read the four tbl24 entries before resolving any of them, as the SSE
and NEON versions do. On an in-order core the cache misses then
overlap instead of being served one after another.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/lpm/rte_lpm_scalar.h | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/lib/lpm/rte_lpm_scalar.h b/lib/lpm/rte_lpm_scalar.h
index df4f83fa48..9ad25838fd 100644
--- a/lib/lpm/rte_lpm_scalar.h
+++ b/lib/lpm/rte_lpm_scalar.h
@@ -13,22 +13,40 @@
 extern "C" {
 #endif
 
+static inline uint32_t
+__rte_lpm_lookupx4_hop(const struct rte_lpm *lpm, uint32_t tbl_entry,
+		uint32_t ip, uint32_t defv)
+{
+	if (unlikely((tbl_entry & RTE_LPM_VALID_EXT_ENTRY_BITMASK) ==
+			RTE_LPM_VALID_EXT_ENTRY_BITMASK)) {
+		const uint32_t *tbl8 = (const uint32_t *)lpm->tbl8;
+
+		tbl_entry = tbl8[(uint8_t)ip + (tbl_entry & 0x00FFFFFF) *
+				RTE_LPM_TBL8_GROUP_NUM_ENTRIES];
+	}
+
+	return (tbl_entry & RTE_LPM_LOOKUP_SUCCESS) ?
+		(tbl_entry & 0x00FFFFFF) : defv;
+}
+
 static inline void
 rte_lpm_lookupx4(const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4],
 		uint32_t defv)
 {
 	rte_xmm_t xip = { .x = ip };
-	uint32_t nh;
-	int ret;
-
-	ret = rte_lpm_lookup(lpm, xip.u32[0], &nh);
-	hop[0] = (ret == 0) ? nh : defv;
-	ret = rte_lpm_lookup(lpm, xip.u32[1], &nh);
-	hop[1] = (ret == 0) ? nh : defv;
-	ret = rte_lpm_lookup(lpm, xip.u32[2], &nh);
-	hop[2] = (ret == 0) ? nh : defv;
-	ret = rte_lpm_lookup(lpm, xip.u32[3], &nh);
-	hop[3] = (ret == 0) ? nh : defv;
+	const uint32_t *tbl24 = (const uint32_t *)lpm->tbl24;
+	uint32_t tbl0, tbl1, tbl2, tbl3;
+
+	/* Issue the four tbl24 loads before any entry is examined. */
+	tbl0 = tbl24[xip.u32[0] >> 8];
+	tbl1 = tbl24[xip.u32[1] >> 8];
+	tbl2 = tbl24[xip.u32[2] >> 8];
+	tbl3 = tbl24[xip.u32[3] >> 8];
+
+	hop[0] = __rte_lpm_lookupx4_hop(lpm, tbl0, xip.u32[0], defv);
+	hop[1] = __rte_lpm_lookupx4_hop(lpm, tbl1, xip.u32[1], defv);
+	hop[2] = __rte_lpm_lookupx4_hop(lpm, tbl2, xip.u32[2], defv);
+	hop[3] = __rte_lpm_lookupx4_hop(lpm, tbl3, xip.u32[3], defv);
 }
 
 #ifdef __cplusplus
-- 
2.56.0

