Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832FC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 18:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67AC340678;
	Tue,  1 Jul 2025 20:20:56 +0200 (CEST)
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com
 [203.205.221.192])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 3F965402E3
 for <dev@dpdk.org>; Tue,  1 Jul 2025 20:20:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751394051;
 bh=PutZ37rHbszLrnLkIRnHrRkMzNC1xWzcFwrsDBdnpZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=CKcIjTGV3OgSlixczYVqyIZYfgXhk2fsNcgVOYPn2Iq5IOpUliWoVp1uVYSjfeaZz
 QGIi+zCkGPVOgdeJ/aQz8gcmRMDw6EXem6e9BolRN0v/knhmCEh6Q1cpaZk8NDIqSg
 mKbWK0lRC2FVOqApFMg1n912nIYokWYpPClG8H/A=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrsza28-0.qq.com (NewEsmtp) with SMTP
 id 52C03A07; Wed, 02 Jul 2025 02:20:44 +0800
X-QQ-mid: xmsmtpt1751394044t4up2ou13
Message-ID: <tencent_78E26E08AE98768E000B338C8B474EB5C005@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uSbs0zRyVidrHRwUyNztKG6y5KSlW/CKuEmKMaE/pcIkOyGgFIU
 OVg5NQpNjHHy2ZbVgpvG9brXgb9dZwG62mUnYoaYmOoBbyK7faYmIUMgA9jtT9WO5x3Xt+Vaya5F
 vN0dySc/DWk2a9lUM32uYfT6OXWDp6NoT6TGKk5As8APhcSrZ49LCZVqvFHT0+n13xTwV6aJ0KIR
 qJaIwbZ2CBNZQBQbW67Vfr93ZVH6qkoUWDk4UJSxpuikdOSp3lLd9L1vuvtCyS9igMMUggYfx8dd
 wbPS3DEZIt6aoAPNPOk9BoQsP9PGILKLEy6JZ0tFE+uLdS5rGj0erGydwJiQj2Aki+8/JmTEeXZv
 JGrwITMRqMxJLc5GDsMhHfhvjNEJFjQcGBBYWeBUMEmZP26DmqitnQ4bkmIsyRN/GgMGnDjE50Rh
 Lo0Tay7Jf/AIMad1dPZOwmVYLl1TIfdyljlJmCcCFBxhRPVqc7shEqCaFO+rMjpbkzGZOoUU8fcy
 eVmSPrdwEnTtUx59OB2hPj1Rtq2YdnXduHUP8yMSH6vfBHcbI0/NZBvdEXb13fiokKMfykg0pao+
 /y8H3ne15MTjg9udOMZV5zZ29xqjtgACwe9ZBd4HPzoaHL4ES1Xqti6icnvJAwLPuNzOIu1xdJ2g
 h1YLaN6eoiLiyDXCFs46Igmu/vqiP77SgCG/ZJmPkPSSWJxy+AhenZiFthRquoUUxX5FA4r9lLzJ
 lMwsUI7pReDNZewn73rBz2bJTJ7ZenHFNQ0a+cWdQh9Vfd0ocKFrWWojzLB0YuqbfAT3jD9gfGCE
 k75D2b3pcSyv8QxRbXFtmhvqVHnlqsJtKrmee0tC0X/SNndWf8GSuhYCaOR/JoRRHTZRs9vuBgVS
 K4jIzmUPQI3/oQktx/OdReJT0MTbyBddge1fgCD7ssSCKvZfwQyzj9fV1RkXYLJ+uDguHIJTfclO
 YM4mN7aIXeSLf91l1vEKNRohigCamUFLs0MtPU6pY=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v2 3/5] lib/lpm: R-V V rte_lpm_lookupx4
Date: Wed,  2 Jul 2025 02:20:31 +0800
X-OQ-MSGID: <20250701182033.642384-4-uk7b@foxmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701182033.642384-1-uk7b@foxmail.com>
References: <20250701182033.642384-1-uk7b@foxmail.com>
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
2.50.0

