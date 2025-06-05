Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA06C5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 10:59:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1EB504065B;
	Thu,  5 Jun 2025 12:59:17 +0200 (CEST)
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com
 [203.205.221.164])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 8505B4026C
 for <dev@dpdk.org>; Thu,  5 Jun 2025 12:59:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749121147;
 bh=ybieP4zKu72WVgo9Gfqh5qxBj0n4YYK77ZkbLXt900o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nw79HiRyG7SKaNQRiG+KGCT5puWkbqls1ixl1F26qT7AcctI835KANB4K8F7B/fO7
 mg4OTTQpJeKYRY77IY8sihwJ7qLGtWFlt7l3BYRQ4DqqZI2tvbPXhIBxJ4s2JcFmfT
 gJ2OLheANqdfSRmK/tLSTVv+TPcIrEWf3b0zZmRU=
Received: from localhost.localdomain ([123.189.192.127])
 by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
 id EC60466D; Thu, 05 Jun 2025 18:59:06 +0800
X-QQ-mid: xmsmtpt1749121146t0igbp7ea
Message-ID: <tencent_B17E58054F806ABA85EFD05EF1E25C191606@qq.com>
X-QQ-XMAILINFO: NDz66ktblfzJJTMyfDgEDI+sCJ5sU9DyUnK6+7ZS7WmIgPpinPwr6ZlvVk+Iqr
 VE87x23nwYvT+A2ElvPOiisQtV1EXhnEXHuncA9ihwBvYr6N16B9cx6ltuZ4Cd0TW8msEowW4xMe
 Amj/svO5dtavSB9BfG7/eWrYvWxlzfuexDQMo+XLwI9t83oZMWT6Mm9YXolqib/NZKjJYv2G7xqC
 PX2Oz/lUdYX5kc1beIvBc1LSBRyVeH0ff6XLtcnezavs2ZayZB22RV0O6oVdD2bllvuhOkMzGNJt
 UgH7vGQHnUalX0GQ0M0YKl0Eg2ar1V2bnYBjHUeEbez4ihp/ds5npynq2mDamAdx1IwOlLawko59
 +8ahMo0aFm9Mxu5muB3y2JP8kCBoaqOP2HFwgyildIv7JVd21Jiu9oNq5w4tiwu2lAfNQodNosuK
 EtQGXgXU77XT0UyAovchgQn1S4RnlGLdCETP0S/u/yna7N29jBNh0/7CAvQzeU4SUb5CVDRjFnS+
 wOOcWmLRsHzplLEf/z/SCpeQmevHPKYUyCrAuPMqYQl6ZQivRKzuILnFV10dQJWpOj5gntb38//o
 rQWfmVIvL2/SZ4dOTBgxtk7CPPEzJ9RPU37LauiUmb62uBvgDJfxShm9b+YzoBJO0HkYCrgj0usG
 30lGlYH8SxV+MLS9KccOb3raSlnTZB4a3YpAHfJefVk7Jnu8dINwOpshXtQAslTyppvYy810GWrj
 k1x1WSbHtLKhmKfbTz7iB/g9fzDglB1Vgy+7UgbIPi3QFYlY5ojXw8R5mxIe2bcdqMZna6vmuWZr
 TYi59Ci4TTSUHcGUDU5EE3mmCWos3tLBp3b4yk6lpTXhZmdhJkR5345lp5q1yJRSh+/gZhm6Y6py
 3/fGDDen74BMmIsisQeO2Op/rCAgBQX9Btk7oS3jYeAsLWziR/Vnv+4pfFWeFIYg==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v4 2/3] lib/lpm: R-V V rte_lpm_lookupx4
Date: Thu,  5 Jun 2025 18:58:42 +0800
X-OQ-MSGID: <20250605105844.3931758-3-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605105844.3931758-1-uk7b@foxmail.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
 <20250605105844.3931758-1-uk7b@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The initialization of vtbl_entry is not fully vectorized here because
doing so would require __riscv_vluxei32_v_u32m1, which is slower
than the scalar approach in this small-scale scenario.

- Test: app/test/lpm_perf_autotest
- Platform: Banana Pi(BPI-F3)
- SoC: Spacemit X60 (8 cores with Vector extension)
- CPU Frequency: up to 1.6 GHz
- Cache: 256 KiB L1d ×8, 256 KiB L1i ×8, 1 MiB L2 ×2
- Memory: 16 GiB
- Kernel: Linux 6.6.36
- Compiler: GCC 14.2.0 (with RVV intrinsic support)

Test results(LPM LookupX4):
    scalar: 5.7 cycles
    rvv:    4.6 cycles

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 MAINTAINERS           |  2 ++
 lib/lpm/meson.build   |  1 +
 lib/lpm/rte_lpm.h     |  2 ++
 lib/lpm/rte_lpm_rvv.h | 62 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+)
 create mode 100644 lib/lpm/rte_lpm_rvv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e16789250..0f207ac129 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -340,6 +340,8 @@ M: Stanislaw Kardach <stanislaw.kardach@gmail.com>
 F: config/riscv/
 F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
 F: lib/eal/riscv/
+M: sunyuechi <sunyuechi@iscas.ac.cn>
+F: lib/**/*rvv*
 
 Intel x86
 M: Bruce Richardson <bruce.richardson@intel.com>
diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
index fae4f79fb9..09133061e5 100644
--- a/lib/lpm/meson.build
+++ b/lib/lpm/meson.build
@@ -17,6 +17,7 @@ indirect_headers += files(
         'rte_lpm_scalar.h',
         'rte_lpm_sse.h',
         'rte_lpm_sve.h',
+        'rte_lpm_rvv.h',
 )
 deps += ['hash']
 deps += ['rcu']
diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
index 7df64f06b1..b06517206f 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -408,6 +408,8 @@ rte_lpm_lookupx4(const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4],
 #include "rte_lpm_altivec.h"
 #elif defined(RTE_ARCH_X86)
 #include "rte_lpm_sse.h"
+#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
+#include "rte_lpm_rvv.h"
 #else
 #include "rte_lpm_scalar.h"
 #endif
diff --git a/lib/lpm/rte_lpm_rvv.h b/lib/lpm/rte_lpm_rvv.h
new file mode 100644
index 0000000000..5f48fb2b32
--- /dev/null
+++ b/lib/lpm/rte_lpm_rvv.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
+ */
+
+#ifndef _RTE_LPM_RVV_H_
+#define _RTE_LPM_RVV_H_
+
+#include <rte_vect.h>
+
+#include <rte_cpuflags.h>
+#include <riscv_vector.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define RTE_LPM_LOOKUP_SUCCESS 0x01000000
+#define RTE_LPM_VALID_EXT_ENTRY_BITMASK 0x03000000
+
+static inline void rte_lpm_lookupx4(
+	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
+{
+	size_t vl = 4;
+
+	const uint32_t *tbl24_p = (const uint32_t *)lpm->tbl24;
+	uint32_t tbl_entries[4] = {
+		tbl24_p[((uint32_t)ip[0]) >> 8],
+		tbl24_p[((uint32_t)ip[1]) >> 8],
+		tbl24_p[((uint32_t)ip[2]) >> 8],
+		tbl24_p[((uint32_t)ip[3]) >> 8],
+	};
+	vuint32m1_t vtbl_entry = __riscv_vle32_v_u32m1(tbl_entries, vl);
+
+	vbool32_t mask = __riscv_vmseq_vx_u32m1_b32(
+	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl),
+	    RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
+
+	vuint32m1_t vtbl8_index = __riscv_vsll_vx_u32m1(
+	    __riscv_vadd_vv_u32m1(
+		__riscv_vsll_vx_u32m1(__riscv_vand_vx_u32m1(vtbl_entry, 0x00FFFFFF, vl), 8, vl),
+		__riscv_vand_vx_u32m1(
+		    __riscv_vle32_v_u32m1((const uint32_t *)&ip, vl), 0x000000FF, vl),
+		vl),
+	    2, vl);
+
+	vtbl_entry = __riscv_vluxei32_v_u32m1_mu(
+	    mask, vtbl_entry, (const uint32_t *)(lpm->tbl8), vtbl8_index, vl);
+
+	vuint32m1_t vnext_hop = __riscv_vand_vx_u32m1(vtbl_entry, 0x00FFFFFF, vl);
+	mask = __riscv_vmseq_vx_u32m1_b32(
+	    __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_LOOKUP_SUCCESS, vl), 0, vl);
+
+	vnext_hop = __riscv_vmerge_vxm_u32m1(vnext_hop, defv, mask, vl);
+
+	__riscv_vse32_v_u32m1(hop, vnext_hop, vl);
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_LPM_RVV_H_ */
-- 
2.49.0

