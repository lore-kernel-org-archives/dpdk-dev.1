Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC5BC83038
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 16:15:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A672740684;
	Tue,  1 Jul 2025 18:15:05 +0200 (CEST)
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com
 [203.205.221.190])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 20BCE4067D
 for <dev@dpdk.org>; Tue,  1 Jul 2025 18:15:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751386496;
 bh=b+vQ3MCYJof5QnjG6MB9E4DDN6/fUc1ZE2ku5sl3feM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=q4TNBvKTpIMYDySZ0FCzKVF4pfqla1TDAQ86zB+jC8N6kzRcf7cWsOqjy+jQkSjE2
 hmJWFCMxcozFTc3CAP787sEsgZkz0n2EH/2oh7GKZCseLgjb7Pt5mCjC2d81pxYE9U
 eveyCtoO63waSafawfMqm/0dizM2qtvwa0tv04tM=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
 id 3B704AB7; Wed, 02 Jul 2025 00:14:55 +0800
X-QQ-mid: xmsmtpt1751386495ta1oqs79h
Message-ID: <tencent_DA88B9D864AE0FCB358C9DC74B55CBC27505@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iClSeWWH9BhZSYiJeo/fi2pw4WfO9muhRTW8rNhfrD1Uc7NiEvmw
 V7ewcMq7DetitZub5BILBI/ssilWVuUEgxiJ73KkZGUIH/gqFQrrJS5r1lNhvUCJPGRF3XupXCZC
 tiVxH+cTM8aLv0aKBVVTuULt0WeNsgsIn81sDRUQ6oiY574rtNEeH+d3pL5OnI8AQj4+uv7ikKpn
 OF8+8fEMFPuM9aK6QAneP/K9PnrGIbWwY+BVzH9Updy/PX7/ipyQOsL0kgS+nl6XyHk0t9tR5zQp
 xQNO/imhyM//Y+3d5ryrY8zq4RmcmhlUlHxE4lnEb2PZqwD2cfHKa4p5pOCW5I+3phrZ14WT1FZK
 c5Bik8PRwjo5vzOoFxMjpveH+2cXoST9/zTt8JQxo+vzdy+DOFIg1bX+H1PbUo8ETj3+0aqlVK+G
 htEmn95Vfrsh/38hKzmSue2mD4N2uwOTt/pTpwZ3dWg72SA47k3JDJmxsfmlu8+q8v5K3f7yE4vo
 T4TcWVw2AMkycWkEQfb10c7IuLFMnjH4qyink8eBd/bYDImR4Zf2b4v9CqxHcKS9ZjQ2DBwqOHB2
 7NXNikvyDbyxwgm0at6yM+v/VYU1D6uU5OPsvHQJ18S8uLwHJgoJ92H2GSF6NQ783j8cr7DPJF8j
 mgbWNP7+YT+GAOH/UQf9XfaPu6CkGDSV8cbFxX1qxuEDtWRZAbMp8OFgx03VaCZI5EvlYUgnfZtI
 CslZtEmGNH0lPyCP7UTW3kEUpA8v5t6KYmgSUEpxEhU5vMXYmTGUTtpTCOySYUNYZL/Yj2Hyj8/I
 6q3TEVObYkVLuFERpJr1Nk6PLpSfcZWpu76VBslcFtevaleHl2QwiTUQywh5YdWtsHQRskJ17oSN
 DO6sWXSd+wEWz9nnK4mxWdYn52GnsxTF/ghiuemoCuZL7LNMCIL2aFvvHIXxUZ53N/1QfyhVcsSs
 b9ODMm7Xg=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH 4/5] lib/fib: R-V V rte_fib_lookup_bulk
Date: Wed,  2 Jul 2025 00:13:41 +0800
X-OQ-MSGID: <20250701161342.46750-5-uk7b@foxmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701161342.46750-1-uk7b@foxmail.com>
References: <20250701161342.46750-1-uk7b@foxmail.com>
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
 lib/fib/dir24_8.c     | 20 +++++++++++++++
 lib/fib/dir24_8_rvv.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 lib/fib/dir24_8_rvv.h | 24 +++++++++++++++++
 lib/fib/meson.build   |  2 ++
 4 files changed, 106 insertions(+)
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
index 0000000000..f2c139c5fd
--- /dev/null
+++ b/lib/fib/dir24_8_rvv.c
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
+ */
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
diff --git a/lib/fib/dir24_8_rvv.h b/lib/fib/dir24_8_rvv.h
new file mode 100644
index 0000000000..7be99f7882
--- /dev/null
+++ b/lib/fib/dir24_8_rvv.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
+ */
+
+#ifndef _DIR248_RVV_H_
+#define _DIR248_RVV_H_
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
2.50.0

