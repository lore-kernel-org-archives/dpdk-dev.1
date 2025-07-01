Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49484C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 16:15:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DED21406B7;
	Tue,  1 Jul 2025 18:15:07 +0200 (CEST)
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com
 [203.205.221.236])
 by mails.dpdk.org (Postfix) with UTF8SMTP id DBD4640676
 for <dev@dpdk.org>; Tue,  1 Jul 2025 18:15:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1751386494;
 bh=PutZ37rHbszLrnLkIRnHrRkMzNC1xWzcFwrsDBdnpZU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NKyhoCGn5ryG98x//hnIBQH1BtECI/Lo4L1vSY6z7kG2khnB/E2OlqRGvwYS6Hjfg
 /D58fjEsGtDKi5Z1cXDx3v0SgczpGunHapLSdUVXe1TlTpx+OeE++VifVNJKhcwTpr
 skVKn02DmBSsd8x0y8AazfFOm/XO72KMlltlviHI=
Received: from ar ([113.231.127.221])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id 3B4950C3; Wed, 02 Jul 2025 00:14:52 +0800
X-QQ-mid: xmsmtpt1751386492trc8wyqym
Message-ID: <tencent_BEE794B130C284789C553B2C8E86FE8AB709@qq.com>
X-QQ-XMAILINFO: M+5cKLn0wXDt8gFgPB92/In8Qo3UfoqG4Yld7q34P7VYUviCOXeMYnj0Z3Fn00
 lnrQoord0GHq2Lh2odyTpYhcbsm6qyS8FoTbt/whRWTCvFAFXmMp+JcZyv+pE6XtfqWiIhMi81YO
 Zne0tEnxJbX3n0Xz54/HKX37o9CTGd6p9b3oNJ1woMSvFKfjr0vXzRDM0qG2ooZZ2kDfzbU0pdbj
 MpnNPqau7GRkQICSMp+U8lIiQjT/luHUNfEeci/fIAKaHaqBoQeCohe1HGZOTsoRTJ5/iKEUWm8/
 oUkag+C7Ln0aL0bd83C6jsXWnroS+YLgisbaXk7VlM+ESl2gT3uIDh1MG+H1UFtmtzvCXIWAshfN
 U5sExXB2iCBqvCQ/fhGVwXV5LEiopUdm4sBykwAbjnq432PXE3631UtNg73RYQK9711o/SM6YBP8
 ql8UJulsyX3EGwUQb0TO+2wTgtbl8kpPIwgR8esjlux0RtKFGKbHcUroWFdtFlI2Rw5fHkvKbfdq
 hOWVzVr2P3PcCNnjD+ksJvg08FScmVLBkgdg9MTiKT3AxwalcPTexEhWjcy0Upo7NaJfGwtwZXAd
 mluO66HzU/i51lfySVztB7aeu/yQazPNEcO31lZm8iPCWEgTDi15TXQmj2JFKc6/B8X0Xz6GdTqe
 HrE1Nz2VNsRiQvEsb4XUmDCOv6QQZLblNXacp5FHMvs54ogeHJwqdNjoflHxtU1QZ3kYGeWAZsDk
 PUD1QkkBEk03NZC6ecTs8K1tW0HHCnMIELs8QWqjNARzYDVPBuPqaJkSSAcwXxJXljzRYiU58jCT
 qNuclyymk46SmrBjSXur9jopeLgMRu2BM95XvGTq0ZK55T8IQ50oq2oufqd/0a7KFwRAXQqLdIvi
 /8rYd5GbevqQYs+V2d+PPO5mKPRs/XtnKIqj1vvfM0kuoqBuYxXGyRJ1sNOVHyPLco3biQEJLg0F
 SKNtXiUac+hItNjcOG/CUK8s8Q3RrO
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: uk7b@foxmail.com
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>, Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Stanislaw Kardach <stanislaw.kardach@gmail.com>
Subject: [PATCH 3/5] lib/lpm: R-V V rte_lpm_lookupx4
Date: Wed,  2 Jul 2025 00:13:40 +0800
X-OQ-MSGID: <20250701161342.46750-4-uk7b@foxmail.com>
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

