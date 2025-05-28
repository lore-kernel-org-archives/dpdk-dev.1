Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18276C5AD49
	for <dpdk-dev@archiver.kernel.org>; Thu, 29 May 2025 09:56:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 23902410FD;
	Thu, 29 May 2025 11:56:15 +0200 (CEST)
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com
 [203.205.221.236])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 3C80940156
 for <dev@dpdk.org>; Wed, 28 May 2025 19:00:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1748451626;
 bh=NtkxTbw4mi9L0/sKTf/kfTq73lC2VElCqoY2HgD5lr0=;
 h=From:To:Cc:Subject:Date;
 b=cAgoiSANc9/bfJMxMLqWyAMH8Jtz7UH4J3REEOG1iq/H8LcbTmIwpCrPu0Y751juV
 vm5iiZ8csL7yKJbBv2SJfJEtqlCDhQK7nj5kkseNoRqBKlphAxLGGUNNu9T0zF0xAO
 LdRC6mnTFHM5ZdKHzDFtUO9GlPFefjY6ly9KLx2g=
Received: from localhost.localdomain ([116.139.97.45])
 by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
 id 122ECA3; Thu, 29 May 2025 01:00:18 +0800
X-QQ-mid: xmsmtpt1748451618t9ead8id0
Message-ID: <tencent_A2BD85C9F3B0AA4658640DA91443CDF5630A@qq.com>
X-QQ-XMAILINFO: NF40XPoX5hMVkjC7XW3B9DdsBIpS+dK5bObVWB2k0UD23sVsYlhfl4i+tEqPJZ
 ZjCA3ILQRH6+G0iswFTHn2ja7kyhWNicH2/tgVIFagiPmoj3KKr00GsiBHXQmDcAs6gO08FSqrX7
 +7b5NN6McEZRidMthUa30piIx3gk0OOWJUJz7v1FZd7mE5xM7ES+l6WFk6yOaR767Eq8umtUNHzb
 ejCHTdgMA8E3+A6D4GPALW3cLnjTBWYgdX7ZaIfCn8WsYUK3D6INGtDToJoNWq6C2lrvu1hej1Go
 Ce7XOfyoj/QvTCQ46WabFF9ikkx0r+OOJUjSBZNK5Yd258Uq7f8eJqDrZ+QzqsxYa8jFpK3U5n9t
 4bzb0eIf9L6A6dRkwTWl5VjHjDDpkYXOBTJG4KlUXix0ekNRX6HrUDqr8WcJB/HQ/1rhqUD9wsty
 MzHT/9By7TNtB8hKfxeASVpHrjcKiRgaV1rByGitzaeiJ9Ipp1ZUFEQfaLmDcVfP4gT++Cg6rC6m
 /b1wESyyO0p8ak/CT1j2Ik8StEPTIjf7aHuGbuHxbnWE1CIGw3ncHyHm5yywOoYtMOoVHjwsxWwU
 eqhUweFtuYyPWcXe/agHzAz1V06NEPEvEynsHFLX1BL+kb9Q9+fFQh6ZWN843I7ltOn3IE8eMvqc
 nxTxDZtojjx+F6lNlNY5FT4JuIw77zifCYbxerSMrHK05MZsKESTigriVnG86SMHFoTEdequ3mFZ
 ygwSwhZJdUva4ftcFDIIohcUseD/noLU+4betUMeqqTOsxINsezsLhEmuuEHqxDxhmqbrwh1kS2s
 77hLJFob7wzfifkXJCb4RyeHOFcgJTRCY7l691SxaVAiaKBzW9hinXe6AsDnRk8wQTVMpecw1KYh
 A9nX17qOkZwBlq+2vdCZoe/ulQ074ZQaLUCjctIoatPNP6MFBfXZDhMlZSl+M/Ag==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: sunyuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH 2/3] lib/lpm: R-V V rte_lpm_lookupx4
Date: Thu, 29 May 2025 01:00:16 +0800
X-OQ-MSGID: <20250528170016.231422-1-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 May 2025 11:56:11 +0200
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

bpi-f3:
    scalar: 5.7 cycles
    rvv:    2.4 cycles

Maybe runtime detection in LPM should be added for all architectures,
but this commit is only about the RVV part.

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
index 0000000000..d6aa1500be
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
+typedef void (*lpm_lookupx4_fn)(const struct rte_lpm *, xmm_t, uint32_t[4], uint32_t);
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

