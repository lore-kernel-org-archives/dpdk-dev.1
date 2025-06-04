Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5253C5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 15:47:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20D8F42E87;
	Wed,  4 Jun 2025 17:47:45 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by mails.dpdk.org (Postfix) with UTF8SMTP id CE29F42E68
 for <dev@dpdk.org>; Wed,  4 Jun 2025 17:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749052061;
 bh=yCM3ebb0HBzSlvM4xEXYz6MBcD70ZkSKjlMZj32w5MM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f1Yzu5jWQJVrW6K0MsH/ClCEOIkcACwOMNQieATpAeWiDJ8lVXflgHSFGmInSTOAZ
 w6rGhmWlE8RNLFVDS0h1hgOce4OM6KSU2ilTZsb5qcOz5JCEcQARjzVMtbrcTBBl7t
 5av7EE4G3kkHp0m2Gr0hkfzyb/VrXX6uKa9F4SMk=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszgpua8-0.qq.com (NewEsmtp) with SMTP
 id BDD82630; Wed, 04 Jun 2025 23:47:29 +0800
X-QQ-mid: xmsmtpt1749052049te0cx8qk9
Message-ID: <tencent_93499E20550C8BACA1D4E2C9391DACAEB007@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb51hQuHRHBPMbcO6nyqErraAG+bvjx1Sm+YEs5ewx4zKTbpkvk5O
 Kk89oWPYUTKN4NdJR/31TXXDUz6azcINXZfFXrKqP9ucK/v7OKNQVUdHEiCIiZgGzy2W+kC2WFcx
 81C6eBd0RCeHFXyhcciJIlw/lB2LsBYrRRU0rlG9JL6sN3fiqsK6fBZiyI9vkB+oB1yuI5IG/Idq
 BS8wtv4phEJ7ie9ZzYUOiA6Z3BlROH7+xOC2pNWusp7TfXpnx0AzrNG4WHbGoMNEN6JVAhfzllc7
 4f4VZMIR88Ux+ZJJR/LXQRa5+ILea0YWqE2GyJVq98pMulDHlWMKSQj08vvEGzp01dI6BXp5+JNZ
 +/x2Sr0IbGV+1rLDyLY7PrnRHAuEw6lHP7xgvCeXWoqur5381I+UiSGwpXz/YFgnXFPk9jkr92gb
 ip5op6HC08YGBqjzu/rekUEEvWYQA4BDQOMG152C665ccvrp8/uWrO4skkse2blNM0CPEz6Hb4mi
 pB1NAlxdUG28OdkKf65xA5L4GvmdJ9qk1t9OU3hpJzXO09sv/0TPnTCTSFJ35Wleqp2mrZML+o1f
 IUtAM3MfoVItq6KBbeIA8aAIXrNxoqvYy5nUKtJ2VHCsZYOio4YvpLi+FJvZ+9YF6aq3UlmOLLrO
 m7B0xRr2BUSRLWK/Oai4paNnp125Ihh6VjEhasMWEH0Clp1UPeIrp23Zc1YpftRsZpQ1yK1zbX0c
 Q81S8ZLm8MglfkAB93JBQeBkgLG6c2Lhm7y84Xql/yqJdOlFSz+OncGawyAcA9DfuBbQjVTXnl/B
 vvp3ZgjMHEnuSb5hTwPDJoZu6+5F6Ofm4xD5L+o7jMbsHJXZJz2QOL6faN/OyXdWQhyAOC1a9mUy
 KrLOylSjZuRaEnlGKe1AKksHBwCGMl75wFtm8iqte4whiy+OtIhmDVa4vzNb/DdgZHwYTE5gjJus
 eLdKgDnaL+jiqgqtEZVC5sq7QxMCWvC6aXkp/J91s/fFU+zE6sliCCHqxVHZ9CeRxmct3xJqnj+8
 U0lsyyEvOU7FVMgIFgHnpd8pf43tfTUXrsFltsnQ==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v3 2/3] lib/lpm: R-V V rte_lpm_lookupx4
Date: Wed,  4 Jun 2025 23:47:19 +0800
X-OQ-MSGID: <20250604154720.3078131-3-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250604154720.3078131-1-uk7b@foxmail.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
 <20250604154720.3078131-1-uk7b@foxmail.com>
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

From: sunyuechi <sunyuechi@iscas.ac.cn>

Test results using lpm_perf_autotest on BPI-F3:
    scalar: 5.7 cycles
    rvv:    2.4 cycles

The best way to call this RVV function is to follow the approach used in
lib/fib, where all architectures initialize a function pointer in a
unified way. However, other architectures in lib/lpm do not follow this
pattern. Therefore, to avoid affecting other architectures, this commit
does not modify lib/lpm/rte_lpm.c.

Unifying the code style between lpm and fib may be worth considering
in the future.

Signed-off-by: sunyuechi <sunyuechi@iscas.ac.cn>
---
 MAINTAINERS           |  2 +
 lib/lpm/meson.build   |  1 +
 lib/lpm/rte_lpm.h     |  2 +
 lib/lpm/rte_lpm_rvv.h | 91 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)
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
index 0000000000..e39ade3f07
--- /dev/null
+++ b/lib/lpm/rte_lpm_rvv.h
@@ -0,0 +1,91 @@
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
+typedef void (*lpm_lookupx4_fn)(const struct rte_lpm *, xmm_t, uint32_t *, uint32_t);
+
+static lpm_lookupx4_fn lpm_lookupx4_impl;
+
+static inline void rte_lpm_lookupx4_scalar(
+	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
+{
+	uint32_t nh;
+	int ret;
+
+	for (int i = 0; i < 4; i++) {
+		ret = rte_lpm_lookup(lpm, ip[i], &nh);
+		hop[i] = (ret == 0) ? nh : defv;
+	}
+}
+
+static inline void rte_lpm_lookupx4_rvv(
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
+static inline void rte_lpm_lookupx4(
+	const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t defv)
+{
+	lpm_lookupx4_impl(lpm, ip, hop, defv);
+}
+
+RTE_INIT(rte_lpm_init_alg)
+{
+	lpm_lookupx4_impl = rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V)
+	    ? rte_lpm_lookupx4_rvv
+	    : rte_lpm_lookupx4_scalar;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_LPM_RVV_H_ */
-- 
2.49.0

