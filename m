Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F64CAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 16:36:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92FBF40673;
	Fri, 19 Sep 2025 18:36:08 +0200 (CEST)
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 1D8CB40612
 for <dev@dpdk.org>; Fri, 19 Sep 2025 18:36:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1758299759;
 bh=Wtp8QCAyqkMOUwRgQPcmIk433wt+G6yTxnrsHk7bTZo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=e0IlJ1xGo4cBB3offU7CmmeYFPpqk38TWB7VzmQ6O0+DTRx/2Sur5rpUsMaQrdEIN
 v2wvhvU1SuJwP8LC+oD/5/AlQS++qshRYRkXucxE16Qb8Qa0T0T6KI3qUTBT3kNp8k
 j870hdUAbxcjC0F0lictkOyLp31YDw8KeEs5YcEU=
Received: from ar ([42.177.177.196])
 by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
 id 8F998C88; Sat, 20 Sep 2025 00:35:57 +0800
X-QQ-mid: xmsmtpt1758299757t9u1wud7k
Message-ID: <tencent_7B0BC50C737C584B612A3C3DAA1316974308@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuF7dsOx4wrq8sStRCSWQXM314kFQeBhsJYqCfN8xLnmYljNRU4N
 YlmOXMa0E58FRz+HyGwu3wg/5ADUXOhpuDoyNwBcdc75VdXutx32qQsUpfe7ihQWI98ykQqwJTzD
 0RNqQnIETJ3ORcsLpL5xdrxP+6nFLV1f4fxoH7yDOG4472eu2Ohy1GN+u7iWX2cEZ99K9fhog4DI
 y1J+dNLjJlPjTVYNC+WTEOVSyQePqW3wku1MDuPu52B5kyovXncwiaKHBp6a4u7IsvbXrOBVb5g6
 0ShAsnHgwOcKwhXv/g44/63I5Zyf+8RWF25eHkLlBDqRVS6RGltpmU2v7jFE6gG7Cw5G+u03mz0y
 4oeauOQMDFwLlmFF0Lowlqnc4OaMVANjbSlByk7UsS4h11E9w0MPduGK4IcxRBIY8a5qxQ+R5oca
 s/uM36k0NQeKFcqB9VQTRWcdtub7Huxjn4hu/MEtL46jck0+MuvEgY1h7hFI5u9BpEWoTmpdu8Lk
 Wt2TQsTZ4mh3yJB91fNSDA3Sjcsxdkxr0QWlCcEKFk1z0bbIkoBiAG5jTRWkpDCRROGrS5xxNoZR
 wxUSNfqup17RVZEQDtK+PDqdeZYWeLont8X/dxPpIkaax6E9vfIBRcQZPFIdnO1ZiawOLlXHrV2R
 SUa/+PbrUZWkMHt7VMQmNWIiuX2k7OVYHwmvwTMC2qkVKQUertcnEoqiMlqdDIJO+Iak1h6vh5lC
 tfVd3aU8BedGOFqGBzoFhkbIDjrVnfQtAmVOX329B83Hh9ZRbICZkR3t5eH1wULegXS/5enz5ahn
 RC0xP2tJhDwoBRxdOcP0oCqgkiTfkP0uWPgQXWgCKy5hKQasA+7Cj2RCAHBw0wGxp2ucrMVJvxJV
 eMj1JTObWjax90a7Szm9iYf6CVuBs1Y71PYF39qlSkWPmExl3DlmGPDW627LVJun5z/tYYzLFmXd
 lcjUqcWyVspV6tPZTmIIcaHSWtJNyfiAI6446gni+2LYlFejiJYg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v3 2/4] lib/lpm: R-V V rte_lpm_lookupx4
Date: Sat, 20 Sep 2025 00:33:55 +0800
X-OQ-MSGID: <20250919163358.2887335-3-uk7b@foxmail.com>
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

Implement LPM lookupx4 function for RISC-V architecture using RISC-V
Vector Extension instruction set

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 MAINTAINERS           |  2 ++
 lib/lpm/meson.build   |  1 +
 lib/lpm/rte_lpm.h     |  2 ++
 lib/lpm/rte_lpm_rvv.h | 59 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+)
 create mode 100644 lib/lpm/rte_lpm_rvv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 0e9357f3a3..9bd97879b6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -341,6 +341,8 @@ M: Stanislaw Kardach <stanislaw.kardach@gmail.com>
 F: config/riscv/
 F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
 F: lib/eal/riscv/
+M: sunyuechi <sunyuechi@iscas.ac.cn>
+F: lib/**/*rvv*
 
 Intel x86
 M: Bruce Richardson <bruce.richardson@intel.com>
diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
index cff8fed473..c4522eaf0c 100644
--- a/lib/lpm/meson.build
+++ b/lib/lpm/meson.build
@@ -11,6 +11,7 @@ indirect_headers += files(
         'rte_lpm_scalar.h',
         'rte_lpm_sse.h',
         'rte_lpm_sve.h',
+        'rte_lpm_rvv.h',
 )
 deps += ['hash']
 deps += ['rcu']
diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
index 6bf8d9d883..edfe77b458 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -420,6 +420,8 @@ rte_lpm_lookupx4(const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4],
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
index 0000000000..0d3dc91055
--- /dev/null
+++ b/lib/lpm/rte_lpm_rvv.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (ISCAS).
+ */
+
+#ifndef _RTE_LPM_RVV_H_
+#define _RTE_LPM_RVV_H_
+
+#include <rte_vect.h>
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
2.51.0

