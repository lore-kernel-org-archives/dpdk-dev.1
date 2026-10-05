Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BE6CA5FE2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 06:30:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ADB0640687;
	Mon,  5 Oct 2026 08:30:25 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id 8E563402DD
 for <dev@dpdk.org>; Mon,  5 Oct 2026 08:30:22 +0200 (CEST)
Received: from ar (unknown [42.58.232.122])
 by APP-03 (Coremail) with SMTP id rQCowAAHED78Q8NqqwCoCQ--.278S2;
 Mon, 05 Oct 2026 14:30:20 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH 2/2] lpm: use scalar lookupx4 on RISC-V
Date: Sun,  4 Oct 2026 23:30:18 -0700
Message-ID: <9013c7b7edb04168b401030af5271ceb377cc047.1791181595.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791181595.git.sunyuechi@iscas.ac.cn>
References: <cover.1791181595.git.sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAAHED78Q8NqqwCoCQ--.278S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW7tFyxuw4DCF13Gw4kJFb_yoW5ur48pa
 sxCa1ayr48XF4ft34rtr1UJryIgF92kr4UGrWDW3yrArsI9w17AFWktw18AFW3AryDZayf
 JF4UGrW8uw4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYDGYDUUUU
X-Originating-IP: [42.58.232.122]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAELAmrDJI0-YAABsa
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

The RVV lookupx4 loads tbl24 with scalar code and always issues a
masked gather for tbl8. With the previous patch the scalar version is
faster on every core tried, so remove the RVV one.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/lpm/meson.build   |  1 -
 lib/lpm/rte_lpm.h     |  2 --
 lib/lpm/rte_lpm_rvv.h | 59 -------------------------------------------
 3 files changed, 62 deletions(-)
 delete mode 100644 lib/lpm/rte_lpm_rvv.h

diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
index c4522eaf0c..cff8fed473 100644
--- a/lib/lpm/meson.build
+++ b/lib/lpm/meson.build
@@ -11,7 +11,6 @@ indirect_headers += files(
         'rte_lpm_scalar.h',
         'rte_lpm_sse.h',
         'rte_lpm_sve.h',
-        'rte_lpm_rvv.h',
 )
 deps += ['hash']
 deps += ['rcu']
diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
index 38a061513f..bcd3da9706 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -421,8 +421,6 @@ rte_lpm_lookupx4(const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4],
 #include "rte_lpm_altivec.h"
 #elif defined(RTE_ARCH_X86)
 #include "rte_lpm_sse.h"
-#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
-#include "rte_lpm_rvv.h"
 #else
 #include "rte_lpm_scalar.h"
 #endif
diff --git a/lib/lpm/rte_lpm_rvv.h b/lib/lpm/rte_lpm_rvv.h
deleted file mode 100644
index 0d3dc91055..0000000000
--- a/lib/lpm/rte_lpm_rvv.h
+++ /dev/null
@@ -1,59 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
- */
-
-#ifndef _RTE_LPM_RVV_H_
-#define _RTE_LPM_RVV_H_
-
-#include <rte_vect.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-#define RTE_LPM_LOOKUP_SUCCESS 0x01000000
-#define RTE_LPM_VALID_EXT_ENTRY_BITMASK 0x03000000
-
-static inline void rte_lpm_lookupx4(
-	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
-{
-	size_t vl = 4;
-
-	const uint32_t *tbl24_p = (const uint32_t *)lpm->tbl24;
-	uint32_t tbl_entries[4] = {
-		tbl24_p[((uint32_t)ip[0]) >> 8],
-		tbl24_p[((uint32_t)ip[1]) >> 8],
-		tbl24_p[((uint32_t)ip[2]) >> 8],
-		tbl24_p[((uint32_t)ip[3]) >> 8],
-	};
-	vuint32m1_t vtbl_entry = __riscv_vle32_v_u32m1(tbl_entries, vl);
-
-	vbool32_t mask = __riscv_vmseq_vx_u32m1_b32(
-	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl),
-	    RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
-
-	vuint32m1_t vtbl8_index = __riscv_vsll_vx_u32m1(
-	    __riscv_vadd_vv_u32m1(
-		__riscv_vsll_vx_u32m1(__riscv_vand_vx_u32m1(vtbl_entry, 0x00FFFFFF, vl), 8, vl),
-		__riscv_vand_vx_u32m1(
-		    __riscv_vle32_v_u32m1((const uint32_t *)&ip, vl), 0x000000FF, vl),
-		vl),
-	    2, vl);
-
-	vtbl_entry = __riscv_vluxei32_v_u32m1_mu(
-	    mask, vtbl_entry, (const uint32_t *)(lpm->tbl8), vtbl8_index, vl);
-
-	vuint32m1_t vnext_hop = __riscv_vand_vx_u32m1(vtbl_entry, 0x00FFFFFF, vl);
-	mask = __riscv_vmseq_vx_u32m1_b32(
-	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_LOOKUP_SUCCESS, vl), 0, vl);
-
-	vnext_hop = __riscv_vmerge_vxm_u32m1(vnext_hop, defv, mask, vl);
-
-	__riscv_vse32_v_u32m1(hop, vnext_hop, vl);
-}
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* _RTE_LPM_RVV_H_ */
-- 
2.56.0

