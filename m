Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0F7CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 16:36:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E954E4068A;
	Fri, 19 Sep 2025 18:36:10 +0200 (CEST)
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com
 [162.62.58.216])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 98D5240669
 for <dev@dpdk.org>; Fri, 19 Sep 2025 18:36:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1758299761;
 bh=xgPNCz5eUWNBKQ2bI3pKTQy0GcjXJXY6Q7K/wnvatNQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uQ4OVMcWAsLwROeWy0MusOQxwUFxiDekQR0urlQegjCapqujcFIqbWdtgiLdfjZGJ
 ACBmfMy22OcMq8UI1ywGXM8ezicQ7bmywzWVRTzG0Ztc0nqP1tgsuz63+akk3eU/4L
 pQNYPX0cevfEUXnOjGw8LvWuq1bSaXxyntSLDF3w=
Received: from ar ([42.177.177.196])
 by newxmesmtplogicsvrsza56-0.qq.com (NewEsmtp) with SMTP
 id 8FBA927D; Sat, 20 Sep 2025 00:35:59 +0800
X-QQ-mid: xmsmtpt1758299759txjkfilql
Message-ID: <tencent_DCD86DAE038B30CC8DA74E95C5C27708B605@qq.com>
X-QQ-XMAILINFO: MIAHdi1iQo+zuettQcIvteTQaHIY+5u62mH9JyV4SGX2G4JLb9lDmxvk7gsOf6
 dLtS+wzgcNUQSJjmDB3yv7it8gL0cMjAVBonEtR3OU6GMw6+ulEsrxxAuZwaXNsbSjhvH8+pBE1e
 F3XuaEqlY4vj2QENdelz23a4aOZU3FUe+CdomXshIk63ghTkb0i2toh7hIFMdw2oh2zDM2GfTHFD
 /3NESs4LK67/rm3hT/ag7HvR7I5N+3BB8QCT7sTmqioznl3qB+bq5jq8zZKDMDVt2G0JhzP6k37h
 WRNrVIpNvdepGNBpLj22PF+UKGcNpQC11TpGA3SlkesH4OE7ciC4MI16iMXRrMxmhLiPj8UaPyZF
 OmI17FeWnTZc+e+rvSXuHCUFPrmjDKuak7c3etGv898VPADut/hFnNpOAv0NKQR09S8PmRH8OQqO
 n8UkB+LCZRNl4wxr6ib4cuT2ejsCEjFVvfqdjM0OULxG0vgY+W6rNukLdM8/2tFHQIfOasgTyP96
 qrQ30Byb03r2+e/R7ij+B5HcHdv3R+weEtguTRJT0RdMTfEa6T829nE6aQjyqc/UW8TeaREIZcg0
 Wf48FzvtLVzaV4zTTF6CefZdHM7d/w2YzBmPnXlmQ9JVMOPdgkNEPIA4V385lM2JbLxgyqENYiJh
 kxucuLHZ9EhAlql9IzHGXfXAkyvXzY3X+4QvXwDHR4mdyO9aJxSvVc93L4nU8L2gFz1XeocFl7MB
 4SJf3TotKbPmtGtdMtZhdegOG2N0CYW4APXL2yROsBZX0sOnBp40RVgFbdrw/pr+JeLZvkNb02W8
 G36jQQxz25a84Ws98DdG6Ci62lQp/jbox/c1q5/vV7xo7gDxHZXJn4w1ba7ZnTXTVpOuh6M6jhbX
 EQza83Mt/1/k2h1Qd2tXY/V9FzU8SIjZgE/uYtaTFwDbXsmQJ3wJxgRysPUJizMui/dbEYG6ajXz
 fEUel69/g=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v3 3/4] lib/fib: R-V V rte_fib_lookup_bulk
Date: Sat, 20 Sep 2025 00:33:56 +0800
X-OQ-MSGID: <20250919163358.2887335-4-uk7b@foxmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919163358.2887335-1-uk7b@foxmail.com>
References: <20250919163358.2887335-1-uk7b@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sun Yuechi <sunyuechi@iscas.ac.cn>

Implement rte_fib_lookup_bulk function for RISC-V architecture using RISC-V
Vector Extension instruction set

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 lib/fib/dir24_8.c     | 20 ++++++++++++++
 lib/fib/dir24_8_rvv.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 lib/fib/dir24_8_rvv.h | 26 ++++++++++++++++++
 lib/fib/meson.build   |  2 ++
 4 files changed, 112 insertions(+)
 create mode 100644 lib/fib/dir24_8_rvv.c
 create mode 100644 lib/fib/dir24_8_rvv.h

diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
index 2ba7e93511..c652d3ca98 100644
--- a/lib/fib/dir24_8.c
+++ b/lib/fib/dir24_8.c
@@ -20,6 +20,10 @@
 
 #include "dir24_8_avx512.h"
 
+#elif defined(RTE_RISCV_FEATURE_V)
+
+#include "dir24_8_rvv.h"
+
 #endif /* CC_AVX512_SUPPORT */
 
 #define DIR24_8_NAMESIZE	64
@@ -88,6 +92,22 @@ get_vector_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_addr)
 	default:
 		return NULL;
 	}
+#elif defined(RTE_RISCV_FEATURE_V)
+	RTE_SET_USED(be_addr);
+	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V) <= 0)
+		return NULL;
+	switch (nh_sz) {
+	case RTE_FIB_DIR24_8_1B:
+		return rte_dir24_8_vec_lookup_bulk_1b;
+	case RTE_FIB_DIR24_8_2B:
+		return rte_dir24_8_vec_lookup_bulk_2b;
+	case RTE_FIB_DIR24_8_4B:
+		return rte_dir24_8_vec_lookup_bulk_4b;
+	case RTE_FIB_DIR24_8_8B:
+		return rte_dir24_8_vec_lookup_bulk_8b;
+	default:
+		return NULL;
+	}
 #else
 	RTE_SET_USED(nh_sz);
 	RTE_SET_USED(be_addr);
diff --git a/lib/fib/dir24_8_rvv.c b/lib/fib/dir24_8_rvv.c
new file mode 100644
index 0000000000..9c14ca0481
--- /dev/null
+++ b/lib/fib/dir24_8_rvv.c
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
+ */
+
+#if defined(RTE_RISCV_FEATURE_V)
+
+#include <rte_vect.h>
+#include <rte_fib.h>
+
+#include "dir24_8.h"
+#include "dir24_8_rvv.h"
+
+#define DECLARE_VECTOR_FN(SFX, NH_SZ) \
+void \
+rte_dir24_8_vec_lookup_bulk_##SFX(void *p, \
+		const uint32_t *ips, uint64_t *next_hops, unsigned int n) \
+{ \
+	const uint8_t  idx_bits = 3 - NH_SZ; \
+	const uint32_t idx_mask = (1u << (3 - NH_SZ)) - 1u; \
+	const uint64_t e_mask   = ~0ULL >> (64 - (8u << NH_SZ)); \
+	struct dir24_8_tbl *tbl = (struct dir24_8_tbl *)p; \
+	const uint64_t *tbl24   = tbl->tbl24; \
+	size_t vl; \
+	for (unsigned int i = 0; i < n; i += vl) { \
+		vl = __riscv_vsetvl_e32m4(n - i); \
+		vuint32m4_t v_ips = __riscv_vle32_v_u32m4(&ips[i], vl); \
+		vuint64m8_t vtbl_word = __riscv_vluxei32_v_u64m8(tbl24, \
+				__riscv_vsll_vx_u32m4( \
+				__riscv_vsrl_vx_u32m4(v_ips, idx_bits + 8, vl), 3, vl), vl); \
+		vuint32m4_t v_tbl_index = __riscv_vsrl_vx_u32m4(v_ips, 8, vl); \
+		vuint32m4_t v_entry_idx = __riscv_vand_vx_u32m4(v_tbl_index, idx_mask, vl); \
+		vuint32m4_t v_shift     = __riscv_vsll_vx_u32m4(v_entry_idx, 3 + NH_SZ, vl); \
+		vuint64m8_t vtbl_entry  = __riscv_vand_vx_u64m8( \
+				__riscv_vsrl_vv_u64m8(vtbl_word, \
+					__riscv_vwcvtu_x_x_v_u64m8(v_shift, vl), vl), e_mask, vl); \
+		vbool8_t mask = __riscv_vmseq_vx_u64m8_b8( \
+				__riscv_vand_vx_u64m8(vtbl_entry, 1, vl), 1, vl); \
+		if (__riscv_vcpop_m_b8(mask, vl)) { \
+			const uint64_t *tbl8 = tbl->tbl8; \
+			v_tbl_index = __riscv_vadd_vv_u32m4_mu(mask, v_tbl_index, \
+					__riscv_vsll_vx_u32m4( \
+						__riscv_vnsrl_wx_u32m4(vtbl_entry, 1, vl), 8, vl), \
+						__riscv_vand_vx_u32m4(v_ips, 0xFF, vl), vl); \
+			vtbl_word = __riscv_vluxei32_v_u64m8_mu(mask, vtbl_word, tbl8, \
+					__riscv_vsll_vx_u32m4( \
+					__riscv_vsrl_vx_u32m4(v_tbl_index, idx_bits, vl), 3, vl), \
+						vl); \
+			v_entry_idx = __riscv_vand_vx_u32m4(v_tbl_index, idx_mask, vl); \
+			v_shift     = __riscv_vsll_vx_u32m4(v_entry_idx, 3 + NH_SZ, vl); \
+			vtbl_entry  = __riscv_vand_vx_u64m8( \
+					__riscv_vsrl_vv_u64m8(vtbl_word, \
+					__riscv_vwcvtu_x_x_v_u64m8(v_shift, vl), vl), e_mask, vl); \
+		} \
+		__riscv_vse64_v_u64m8(&next_hops[i], \
+				__riscv_vsrl_vx_u64m8(vtbl_entry, 1, vl), vl); \
+	} \
+}
+
+DECLARE_VECTOR_FN(1b, 0)
+DECLARE_VECTOR_FN(2b, 1)
+DECLARE_VECTOR_FN(4b, 2)
+DECLARE_VECTOR_FN(8b, 3)
+
+#endif
diff --git a/lib/fib/dir24_8_rvv.h b/lib/fib/dir24_8_rvv.h
new file mode 100644
index 0000000000..c75057e266
--- /dev/null
+++ b/lib/fib/dir24_8_rvv.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
+ */
+
+#ifndef _DIR248_RVV_H_
+#define _DIR248_RVV_H_
+
+#include "rte_cpuflags.h"
+
+void
+rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+void
+rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint32_t *ips,
+	uint64_t *next_hops, const unsigned int n);
+
+#endif /* _DIR248_RVV_H_ */
diff --git a/lib/fib/meson.build b/lib/fib/meson.build
index 6992ccc040..573fc50ff1 100644
--- a/lib/fib/meson.build
+++ b/lib/fib/meson.build
@@ -10,4 +10,6 @@ deps += ['net']
 
 if dpdk_conf.has('RTE_ARCH_X86_64')
     sources_avx512 += files('dir24_8_avx512.c', 'trie_avx512.c')
+elif dpdk_conf.has('RTE_ARCH_RISCV')
+    sources += files('dir24_8_rvv.c')
 endif
-- 
2.51.0

