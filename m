Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D26AC5B549
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Jun 2025 13:08:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8771642DD9;
	Wed,  4 Jun 2025 15:08:03 +0200 (CEST)
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com
 [162.62.57.49])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 6D8D942DDF
 for <dev@dpdk.org>; Wed,  4 Jun 2025 15:08:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749042474;
 bh=yCM3ebb0HBzSlvM4xEXYz6MBcD70ZkSKjlMZj32w5MM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JOrGkGH97MpE1q83pPQ/XXv1mpRt3trvGX2lfnk4Qo3kl5k9nyguU9UVfQ7bXQrxY
 zR8INthRfvkVubONa5w/QsDGv+vvSh2zVTQsUUbYieqj2hIp5DUgLwsrWXiBjIehJO
 KBFr5c5gclDzgXKebPCtqiYRWFYBHOrNpUwX+pp4=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id 1F534271; Wed, 04 Jun 2025 21:07:53 +0800
X-QQ-mid: xmsmtpt1749042473tizdmw5d7
Message-ID: <tencent_9569AA1116614369C50173A5582861053C08@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9Xk5dXhK/OZXsLB6u6EMcUuuNINZcVCPChMt8tfWZ7bErl26LaWS
 MS8G8D6zaM9tLIDXnJhi6fYF8jsNtZ/b8bnhYdk2E6AxALnmyVTBKEdmUJxHtrXBUr8EQfZUfnI8
 ooo1NzncTouyH5PLUci8/0rIa+7SxYxKAJ+R4erAZ5Z/0aGpnWgzjkWkrz40DFearlJHaEcUT3on
 7GT73uXbfJxQaAKak615FKnzt278yw93zFqfFPdtyZ/mKb0UNJvowOmIfFxXIHfkAx9xgpBrmnm9
 bTFI+rG3oyaaF6vAatE2/553KXqa2JxP8pZD+H2oog0YFFoS2rTieob+PuEWkoCqyT50YFgu0faw
 Y01y9Bd7eKvCSfQ984aDJvY1xa1Jcey3QuLb7tNWyW/+AVHqK7t1G6BTT60GGiUU7xarvB2W0dOO
 97lUzDCniKegcdqMM8+4e3K4hmVhZxe+DmGVi/mICMO6G39zkGtDURe+nXDgUBoVr3mLRS24x3q7
 eaZqNRRDE0kk/dqWb2Nnz8X5JS4ohzMYa66sk5ISZlqMUGbiq31xeD8KvkqFWcqBEamvZHpQVJ5I
 uWX0vQut6iUg6/O1i8JjNdWXTIlnmFAPNYzw3SPCqpHkoB9wVw+gO4ktcUrmDD5nMA74SXDQvn84
 uEDMz6pEtYhaD5ZPUNuq3gNWjMJKK9HrFYuyKluffSJLMbGbyqeSD4QLhT13Jy1xfWPr+OEvLcfC
 AF51srTl5ypgDeWs/yejubVZlc773lfe/8hh35hSTspLjwJb4MQqNQI9g9hBcRp7A8vAixgEmSsS
 zRPe7CzyMTM0RRVj3myXE41awT4iKO26RGIfVqB4jsdht2Gna1qQuTtgt/rI40Wjz26a6o3H3Q2+
 n8jhgER2V5AQnicfqj7yaYrS2EVRqvb78R0Rjm3lYKubor915L9fDBZXeX7H2GucDXnYYDzZL0jW
 m//7/2BCOnUIQw4j3ZytgwrzuWj2FKK4FuRUE0xBcEnkNv2bJKgZkn8Ru1At9UcvdqLU1W8BoDC0
 u3QJKrZw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v2 2/3] lib/lpm: R-V V rte_lpm_lookupx4
Date: Wed,  4 Jun 2025 21:07:42 +0800
X-OQ-MSGID: <20250604130742.2348000-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
References: <tencent_3C14F3CE0963698675F04CA9725B540D5D0A@qq.com>
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

