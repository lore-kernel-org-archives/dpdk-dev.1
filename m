Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B228CA5FE2
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 07:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9809740A4B;
	Mon,  5 Oct 2026 09:04:51 +0200 (CEST)
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
 by mails.dpdk.org (Postfix) with ESMTP id EED184028D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 09:04:48 +0200 (CEST)
Received: from ar (unknown [42.58.232.122])
 by APP-03 (Coremail) with SMTP id rQCowAD39TMPTMNqBrKoCQ--.960S2;
 Mon, 05 Oct 2026 15:04:47 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org,
	Sun Yuechi <sunyuechi@iscas.ac.cn>
Subject: [PATCH 2/2] fib: gather entries at their own width with RVV
Date: Mon,  5 Oct 2026 00:04:46 -0700
Message-ID: <dda3bf6bcb76d01bc89a822a4dba5374b0bf40ae.1791183388.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1791183388.git.sunyuechi@iscas.ac.cn>
References: <cover.1791183388.git.sunyuechi@iscas.ac.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowAD39TMPTMNqBrKoCQ--.960S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF4rGry7KrW7Xr15ArWfGrg_yoW7Xw43pr
 W5Jayakr48ta17A34SqF13Ar1Y9r97Kr4ak3y8W3yrA343Cay7Cr9xJw1fZFZ8XF92ya4j
 yw4Dur18Zry7JrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYDGYDUUUU
X-Originating-IP: [42.58.232.122]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiBwYLAmrDJO1OcQABsW
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

The lookup loaded 64-bit words and shifted the entry out of them. That
takes LMUL=8 values whatever the next hop size, one register group more
than there is, so a group was spilled inside the loop. Gather the
entries at the size they are stored with instead.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/fib/dir24_8_rvv.c | 85 ++++++++++++++++++++++++-------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/lib/fib/dir24_8_rvv.c b/lib/fib/dir24_8_rvv.c
index 9c14ca0481..9b784bb3c5 100644
--- a/lib/fib/dir24_8_rvv.c
+++ b/lib/fib/dir24_8_rvv.c
@@ -10,55 +10,64 @@
 #include "dir24_8.h"
 #include "dir24_8_rvv.h"
 
-#define DECLARE_VECTOR_FN(SFX, NH_SZ) \
+/* Byte offset of entry number idx, for each next hop size. */
+#define OFS_1b(idx, vl) ((void)(vl), (idx))
+#define OFS_2b(idx, vl) __riscv_vsll_vx_u32m4(idx, 1, vl)
+#define OFS_4b(idx, vl) __riscv_vsll_vx_u32m4(idx, 2, vl)
+#define OFS_8b(idx, vl) __riscv_vsll_vx_u32m4(idx, 3, vl)
+
+/* Entry without its low bit, as 32-bit tbl8 group number. */
+#define GRP_1b(ent, vl) \
+	__riscv_vzext_vf4_u32m4(__riscv_vsrl_vx_u8m1(ent, 1, vl), vl)
+#define GRP_2b(ent, vl) \
+	__riscv_vzext_vf2_u32m4(__riscv_vsrl_vx_u16m2(ent, 1, vl), vl)
+#define GRP_4b(ent, vl) __riscv_vsrl_vx_u32m4(ent, 1, vl)
+#define GRP_8b(ent, vl) __riscv_vnsrl_wx_u32m4(ent, 1, vl)
+
+/* Entry without its low bit, as 64-bit next hop. */
+#define NH_1b(ent, vl) \
+	__riscv_vzext_vf8_u64m8(__riscv_vsrl_vx_u8m1(ent, 1, vl), vl)
+#define NH_2b(ent, vl) \
+	__riscv_vzext_vf4_u64m8(__riscv_vsrl_vx_u16m2(ent, 1, vl), vl)
+#define NH_4b(ent, vl) \
+	__riscv_vzext_vf2_u64m8(__riscv_vsrl_vx_u32m4(ent, 1, vl), vl)
+#define NH_8b(ent, vl) __riscv_vsrl_vx_u64m8(ent, 1, vl)
+
+/* Entries are gathered at their own width, with 32-bit byte offsets. */
+#define DECLARE_VECTOR_FN(SFX, TYPE, BITS, LMUL) \
 void \
 rte_dir24_8_vec_lookup_bulk_##SFX(void *p, \
 		const uint32_t *ips, uint64_t *next_hops, unsigned int n) \
 { \
-	const uint8_t  idx_bits = 3 - NH_SZ; \
-	const uint32_t idx_mask = (1u << (3 - NH_SZ)) - 1u; \
-	const uint64_t e_mask   = ~0ULL >> (64 - (8u << NH_SZ)); \
-	struct dir24_8_tbl *tbl = (struct dir24_8_tbl *)p; \
-	const uint64_t *tbl24   = tbl->tbl24; \
+	const struct dir24_8_tbl *tbl = (const struct dir24_8_tbl *)p; \
+	const TYPE *tbl24 = (const TYPE *)tbl->tbl24; \
+	const TYPE *tbl8 = (const TYPE *)tbl->tbl8; \
 	size_t vl; \
 	for (unsigned int i = 0; i < n; i += vl) { \
 		vl = __riscv_vsetvl_e32m4(n - i); \
 		vuint32m4_t v_ips = __riscv_vle32_v_u32m4(&ips[i], vl); \
-		vuint64m8_t vtbl_word = __riscv_vluxei32_v_u64m8(tbl24, \
-				__riscv_vsll_vx_u32m4( \
-				__riscv_vsrl_vx_u32m4(v_ips, idx_bits + 8, vl), 3, vl), vl); \
-		vuint32m4_t v_tbl_index = __riscv_vsrl_vx_u32m4(v_ips, 8, vl); \
-		vuint32m4_t v_entry_idx = __riscv_vand_vx_u32m4(v_tbl_index, idx_mask, vl); \
-		vuint32m4_t v_shift     = __riscv_vsll_vx_u32m4(v_entry_idx, 3 + NH_SZ, vl); \
-		vuint64m8_t vtbl_entry  = __riscv_vand_vx_u64m8( \
-				__riscv_vsrl_vv_u64m8(vtbl_word, \
-					__riscv_vwcvtu_x_x_v_u64m8(v_shift, vl), vl), e_mask, vl); \
-		vbool8_t mask = __riscv_vmseq_vx_u64m8_b8( \
-				__riscv_vand_vx_u64m8(vtbl_entry, 1, vl), 1, vl); \
-		if (__riscv_vcpop_m_b8(mask, vl)) { \
-			const uint64_t *tbl8 = tbl->tbl8; \
-			v_tbl_index = __riscv_vadd_vv_u32m4_mu(mask, v_tbl_index, \
-					__riscv_vsll_vx_u32m4( \
-						__riscv_vnsrl_wx_u32m4(vtbl_entry, 1, vl), 8, vl), \
-						__riscv_vand_vx_u32m4(v_ips, 0xFF, vl), vl); \
-			vtbl_word = __riscv_vluxei32_v_u64m8_mu(mask, vtbl_word, tbl8, \
-					__riscv_vsll_vx_u32m4( \
-					__riscv_vsrl_vx_u32m4(v_tbl_index, idx_bits, vl), 3, vl), \
-						vl); \
-			v_entry_idx = __riscv_vand_vx_u32m4(v_tbl_index, idx_mask, vl); \
-			v_shift     = __riscv_vsll_vx_u32m4(v_entry_idx, 3 + NH_SZ, vl); \
-			vtbl_entry  = __riscv_vand_vx_u64m8( \
-					__riscv_vsrl_vv_u64m8(vtbl_word, \
-					__riscv_vwcvtu_x_x_v_u64m8(v_shift, vl), vl), e_mask, vl); \
+		vuint##BITS##m##LMUL##_t v_ent = \
+			__riscv_vluxei32_v_u##BITS##m##LMUL(tbl24, \
+				OFS_##SFX(__riscv_vsrl_vx_u32m4(v_ips, 8, vl), \
+					vl), vl); \
+		vbool8_t mask = __riscv_vmsne_vx_u##BITS##m##LMUL##_b8( \
+			__riscv_vand_vx_u##BITS##m##LMUL(v_ent, \
+				DIR24_8_EXT_ENT, vl), 0, vl); \
+		if (unlikely(__riscv_vfirst_m_b8(mask, vl) >= 0)) { \
+			vuint32m4_t v_idx = __riscv_vadd_vv_u32m4( \
+				__riscv_vsll_vx_u32m4(GRP_##SFX(v_ent, vl), \
+					8, vl), \
+				__riscv_vand_vx_u32m4(v_ips, 0xFF, vl), vl); \
+			v_ent = __riscv_vluxei32_v_u##BITS##m##LMUL##_mu(mask, \
+				v_ent, tbl8, OFS_##SFX(v_idx, vl), vl); \
 		} \
-		__riscv_vse64_v_u64m8(&next_hops[i], \
-				__riscv_vsrl_vx_u64m8(vtbl_entry, 1, vl), vl); \
+		__riscv_vse64_v_u64m8(&next_hops[i], NH_##SFX(v_ent, vl), vl); \
 	} \
 }
 
-DECLARE_VECTOR_FN(1b, 0)
-DECLARE_VECTOR_FN(2b, 1)
-DECLARE_VECTOR_FN(4b, 2)
-DECLARE_VECTOR_FN(8b, 3)
+DECLARE_VECTOR_FN(1b, uint8_t, 8, 1)
+DECLARE_VECTOR_FN(2b, uint16_t, 16, 2)
+DECLARE_VECTOR_FN(4b, uint32_t, 32, 4)
+DECLARE_VECTOR_FN(8b, uint64_t, 64, 8)
 
 #endif
-- 
2.56.0

