Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E2C678DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 15:00:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6E2A402EA;
	Wed, 11 Jun 2025 17:00:28 +0200 (CEST)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
 by mails.dpdk.org (Postfix) with UTF8SMTP id 9EFF5402DB
 for <dev@dpdk.org>; Wed, 11 Jun 2025 17:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1749654020;
 bh=HKwitkeHfHZNXPslfQTs4p0Q8o6oxSvdkdLHVd6BzvM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RFNAW//gDg10qiitXM03zdefG6Rbj5pZA/NvYEX2QEgUioc04Vi7jtKLgIXiFy6zX
 w+prU+8l60rojEPTe0RFLr8Gmcz5cQ6A4J3XaOH9LeBhg5hX22WazczbpmBCqRBder
 Sv+/qG3xMmP8qS3DfCt56vXTXGThGiMIzuXqOvTg=
Received: from localhost.localdomain ([123.189.192.127])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id 12A12DB; Wed, 11 Jun 2025 23:00:18 +0800
X-QQ-mid: xmsmtpt1749654018tqr0kfvyf
Message-ID: <tencent_396508A23869CE024B322C86674E15CB2205@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9zTD/5IOSKW4dzw1u+WsiLtWarU3+UF/CmqY8QrrFc88Lifc+N+
 abRVGvX0XMLe8ifqBbhpmNxMOqFk9N1wx3C0vNRJZcTepuCXS2B5RRNIbh2nJEo3xg0OnAnFrPUb
 CkXVpN2lC2GUhBVRCLCrnP2IF9wOyvN6T+sY3R6vIO6uNfm9zIbH+hOLou/z/gZMWyfb0mngw/tY
 Ett9fjbtNFrxMSWD+YuYOdrueXxO2p9/ExTGwiTZoEFJrdKL7Q4J8EfqsEsAbfbusVrz7v0xAW0w
 3oTSVUioUqjPgw2zP5uT3Di7PZZozhj5KFY1jFS/qmGC+1Gtzqnn4BysXuV5GzmgMKAKDWRLc2bC
 lPEzdVhzTY6A9Faz5QBUACX9DYIi9BMi28GNwZErvyvhznd2jHkuUtjnhWNqUuhzHfeaYxf2BN13
 ha7cxzT04tfHn6ngU44x19atLUK1ymUQffKPd5CBWbgWFjrYiTqHisFhc/H++oJOArkNu9/V6GeE
 Gdyybr+PjF/fhRc2ZVUQFDzW3szTjcFBURO4l9BQsFRXdyRPSqD4Wlp4J/Cr3Q0rJUqhRvypagOS
 8anwj+E912l+3VmlAcQrRnGJs6GZemyyqOCBACXvH2646WH0+JR6HR51xyeskeo6RO6ABnLG48jQ
 VtYEz0ljWtmwYUH//7ddlNHYa9LWhxzYt54h1oLnb0A6CJUxAsLOVFcmi/b7+4ZaM+IquYouUVri
 JFaD/zXcSJrIqWEK330PYVzx1/nep6euYTBSFaUiTbzLisTBO/n7oFqVnCpFWeNYvxvxeIDSoxT7
 U5EpPw/2CnfhcPGtIBEIu++L9PHQELD3HDUE2foozeMq2DZY6RUUcqtwpR28BW3fGrlGJjbLCHS9
 n86qiv6TnN2wxp6U65W12nRakCgOXvuZOP7xDd04CZxb03T0shDc1uXj4UE+KLJQ==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH v5 2/3] lib/lpm: R-V V rte_lpm_lookupx4
Date: Wed, 11 Jun 2025 22:59:13 +0800
X-OQ-MSGID: <20250611145915.854026-3-uk7b@foxmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611145915.854026-1-uk7b@foxmail.com>
References: <tencent_C18B280C87275E35D0427508AF98674E1005@qq.com>
 <20250611145915.854026-1-uk7b@foxmail.com>
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

Implement LPM lookupx4 function for RISC-V architecture using RISC-V
Vector Extension instruction set

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

