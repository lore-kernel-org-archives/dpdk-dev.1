Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4263EC7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 03:59:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5311140658;
	Fri, 27 Jun 2025 05:59:01 +0200 (CEST)
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com
 [162.62.57.87])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 6325740649
 for <dev@dpdk.org>; Fri, 27 Jun 2025 05:58:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1750996737;
 bh=7KApfoQ5c0k/0mrXnbhiOPt8JWKMISNXk7lHFudhQLg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cwTnR+nEiadUfuOLv4PeDO/c2gAw1zV8Sum4Q9vEdzPAP18sf5cxObd73RsGQgjMZ
 bnj+atcUN3wjeBzxajjN7Fd/HfQtbn0X3oyS9Cp1UUiuD5x9gqld3tSFs1m9HQMGXN
 HXLkRwmbY1WBiVtFVbFkU20JO3KxAR51wxfL0dH0=
Received: from localhost.localdomain ([113.231.69.199])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id EB1AC470; Fri, 27 Jun 2025 11:58:49 +0800
X-QQ-mid: xmsmtpt1750996729tjqge3dzs
Message-ID: <tencent_6CB362A839262CB3B0581E3555530BF32107@qq.com>
X-QQ-XMAILINFO: NDgMZBR9sMma3ec2tmjNpSakxeqY/utQjJGf7uE7OreI6XKEIUssEbhX3Ut1rn
 u1ke0+USRtTjQC5n2ZaqgQ2cBnVItOizAoErkUBYu1PGar6nd0MY5uM8hEHIBjFcwqW90TL9IIBf
 xQ33ERQhK41ig6OP9MkT95ejyH7HP/MZHQ1WeG76xzKnnqcy8YxC8U9somcJ6H9VuaBnWpLq+drK
 idKDKN+tIDCo90Epn/cIUAuM2i/DQB6Q/twTCpoE/z5DFqJSuiJh7qFiLrcYCTdg4EJvVHwkKiF1
 uadgFFVOKMpjFYEMoYujd3bs4wl6Mp6I55xRBWV0xudrljX7/vq2gMydatUn+L3JdIng4VBXmvL8
 VR28tE/257h2JsZDHEGrawejZhGzoVXrNuaiuOv7536nHWh8CRLcg10CBc5ANQNY7Nf4negHSs6a
 ic3o9NYJML0LcueCubp/RFQAJmPj04ZJaoHWjZYD5K5g8D3ozbEQwMhY4/y0AI9T1WdOssnXKEIR
 rOl98ADKhK5DDIO5AfrcDYf97xRtmMILqtwESEDUbwfBsNSLNKRLFsTppX/DoeA2xi8rwMpYjL4S
 FKPE1FPiXtrC7+AeCWTGA4GdVNKZ/heebjjL6zHjcSk8lH6e+D51YdGzFA6v77PTzSBZ/b2oXb5M
 bWoUxf7H6+gn6MjKukiWGtHFibpth1zZa9kPAfeFGoSSA3CeolDFMn36A7emOxQLdIWJkgCOMBRI
 /7zi3qa7e2gHHSEV0vvQDJwdz/5yd97L0U53tAC6K5WPZCROayiTWYPuJiMlp+TQPO0j1UB+MqnS
 mScbB0YKPo4q0+cAKZszwHFz6fOlO0IHLYazf9ygFnS8PIu7cRYofdSuQjMh3pA49SWXCAnPwS/D
 0Krx3eSP1TJHp38R+IwwhOKRNggpwVJrkAyYdi+4mKdyXQF60iz02gir8upXIZkvfvlYsxgt/n
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v6 2/3] lib/lpm: R-V V rte_lpm_lookupx4
Date: Fri, 27 Jun 2025 11:58:13 +0800
X-OQ-MSGID: <20250627035814.670775-3-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250627035814.670775-1-uk7b@foxmail.com>
References: <tencent_6985C4D07FF1CB5C3AD652182E4F9DAA9906@qq.com>
 <20250627035814.670775-1-uk7b@foxmail.com>
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

