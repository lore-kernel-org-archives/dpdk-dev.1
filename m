Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815BCEF8FF4
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D84F4069F;
	Wed,  4 Mar 2026 16:16:32 +0100 (CET)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [13.75.44.102]) by mails.dpdk.org (Postfix) with ESMTP id 88BBD40265
 for <dev@dpdk.org>; Wed,  4 Mar 2026 07:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=whu.edu.cn; s=dkim; h=Received:Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=81kWb
 RDhrQS8asCxqCI2EipgMxxWEMxCS7PgZwwQA2o=; b=DwpXM2jwTMaVuq5felhbL
 JIqRBP7tZa3TmjEGjwtn1ogekns74SNKTke99phQRc0PcIuiJ/J2qG8u9tdwS9Ul
 V0603aBubTO9TANdKFQ4/9OID1QQT8FqghVPAW1yzYxSmVQrNSyRhUFRJE41wEMv
 jD46fYTfVnEMAnjNHbZZZk=
Received: from whu.edu.cn (unknown [10.1.14.9])
 by app1 (Coremail) with SMTP id Bg4BCgB3hjAizqdpOpQEAg--.30013S2;
 Wed, 04 Mar 2026 14:16:02 +0800 (CST)
Received: from localhost.localdomain (unknown [210.73.43.101])
 by mtasvr (Coremail) with SMTP id _____wCnlxwYzqdpUSUYAA--.24598S2;
 Wed, 04 Mar 2026 14:16:02 +0800 (CST)
From: P1erreCashon <2022302111412@whu.edu.cn>
To: Yipeng Wang <yipeng1.wang@intel.com>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, P1erreCashon <2022302111412@whu.edu.cn>,
 gong-flying <gongxiaofei24@iscas.ac.cn>
Subject: [PATCH] efd: lookup with RISC-V vector extension
Date: Wed,  4 Mar 2026 14:15:49 +0800
Message-ID: <20260304061550.1109972-1-2022302111412@whu.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Bg4BCgB3hjAizqdpOpQEAg--.30013S2
Authentication-Results: app1; spf=neutral smtp.mail=2022302111412@whu. edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxAr45ZryUKr48Gr1rZw1fZwb_yoW7JF1rpF
 WDJFWSyryUJ3W3G3ySvw1UXF1rCFyIyrsFkrZFga4rC3yfZ3s7urs7JryjkFZ8trWxurW7
 Xr45Wr1UWF15Zw7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
 v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
 x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
 v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
 0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4xMc
 Ij6xkF7I0En7xvr7AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
 r41lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GF4l4I8I3I
 0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
 GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
 0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
 rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r
 4UYxBIdaVFxhVjvjDU0xZFpf9x07U-VyxUUUUU=
X-CM-SenderInfo: qsqsjjyqsriiqursq4lkxovvfxof0/
X-Mailman-Approved-At: Wed, 04 Mar 2026 16:16:28 +0100
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

Implement EFD lookup internal function for RISC-V architecture
using RISC-V Vector Extension instruction set

Performance results (EFD perf autotest)
These performance results are the average of five test runs.
Results (in CPU cycles/operation):

Before optimization:
Keysize           Add               Lookup            Lookup_bulk       Delete
4                 136.0            5.6               5.0               25.6
8                 149.4            6.0               6.0               31.4
16                156.8           8.0               7.0               36.8
32                179.2           13.0             14.0              45.4
48                205.8           13.0             15.0              45.6
64                214.4           16.0            18.4               46.6
9                 152.8             6.2              6.0               30.0
13                160.6            7.2               7.0               35.0
37                191.2            12.0             13.0              44.2
40                195.0            12.0             13.6              43.2

After optimization:
Keysize           Add               Lookup            Lookup_bulk       Delete
4                 131.6             5.0               5.0               26.6
8                 143.6             6.0               6.2               33.0
16                153.2            7.0               7.0               35.8
32                173.6            14.0             14.0             45.0
48                201.6            12.6             14.0             46.2
64                211.4            15.0             16.0             46.8
9                 146.6             6.0               6.0              30.6
13                154.8            7.0               7.0               35.0
37                189.2            11.0             12.2             45.4
40                191.8            11.0             12.4             43.8

This patch is co-developed with Gong Xiaofei.

Signed-off-by: gong-flying <gongxiaofei24@iscas.ac.cn>
Signed-off-by: P1erreCashon <2022302111412@whu.edu.cn>
---
 lib/efd/rte_efd.c     | 20 +++++++++++++-
 lib/efd/rte_efd_rvv.h | 64 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 lib/efd/rte_efd_rvv.h

diff --git a/lib/efd/rte_efd.c b/lib/efd/rte_efd.c
index 4dfc0ec9a4..053ee4f232 100644
--- a/lib/efd/rte_efd.c
+++ b/lib/efd/rte_efd.c
@@ -29,6 +29,9 @@
 #include "rte_efd_x86.h"
 #elif defined(RTE_ARCH_ARM64)
 #include "rte_efd_arm64.h"
+#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
+#include <riscv_vector.h>
+#include "rte_efd_rvv.h"
 #endif
 
 RTE_LOG_REGISTER_DEFAULT(efd_logtype, INFO);
@@ -85,7 +88,8 @@ enum efd_lookup_internal_function {
 	EFD_LOOKUP_SCALAR = 0,
 	EFD_LOOKUP_AVX2,
 	EFD_LOOKUP_NEON,
-	EFD_LOOKUP_NUM
+	EFD_LOOKUP_NUM,
+	EFD_LOOKUP_RVV
 };
 
 TAILQ_HEAD(rte_efd_list, rte_tailq_entry);
@@ -675,6 +679,12 @@ rte_efd_create(const char *name, uint32_t max_num_rules, uint32_t key_len,
 			rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_128)
 		table->lookup_fn = EFD_LOOKUP_NEON;
 	else
+#endif
+#if defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
+	if (RTE_EFD_VALUE_NUM_BITS > 16 &&
+		__riscv_vsetvl_e32m1(4) == 4)
+		table->lookup_fn = EFD_LOOKUP_RVV;
+	else
 #endif
 		table->lookup_fn = EFD_LOOKUP_SCALAR;
 
@@ -1305,6 +1315,14 @@ efd_lookup_internal(const struct efd_online_group_entry * const group,
 					hash_val_a,
 					hash_val_b);
 		break;
+#endif
+#if defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
+	case EFD_LOOKUP_RVV:
+		return efd_lookup_internal_rvv(group->hash_idx,
+				group->lookup_table,
+				hash_val_a,
+				hash_val_b);
+		break;
 #endif
 	case EFD_LOOKUP_SCALAR:
 	/* Fall-through */
diff --git a/lib/efd/rte_efd_rvv.h b/lib/efd/rte_efd_rvv.h
new file mode 100644
index 0000000000..e8ea6e0343
--- /dev/null
+++ b/lib/efd/rte_efd_rvv.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Institute of Software Chinese Academy of Sciences (ISCAS).
+ */
+
+#ifndef __RTE_EFD_RISCV_H__
+#define __RTE_EFD_RISCV_H__
+
+#include <riscv_vector.h>
+
+static inline efd_value_t
+efd_lookup_internal_rvv(const efd_hashfunc_t *group_hash_idx,
+				const efd_lookuptbl_t *group_lookup_table,
+				const uint32_t hash_val_a, const uint32_t hash_val_b)
+{
+		efd_value_t value = 0;
+		const uint32_t N = RTE_EFD_VALUE_NUM_BITS;
+		size_t vl = 4;
+		vuint32m1_t vhash_val_a = __riscv_vmv_v_x_u32m1(hash_val_a, vl);
+		vuint32m1_t vhash_val_b = __riscv_vmv_v_x_u32m1(hash_val_b, vl);
+		vuint32m1_t vshift = __riscv_vid_v_u32m1(vl);
+		vuint32m1_t vmask = __riscv_vmv_v_x_u32m1(0x1, vl);
+		vuint32m1_t vincr = __riscv_vmv_v_x_u32m1(0, vl);
+		for (unsigned int i = 0; i < N; i += vl) {
+			vuint16mf2_t vhash_idx16 =
+				__riscv_vle16_v_u16mf2(
+					(const uint16_t *)&group_hash_idx[i], vl);
+
+			vuint32m1_t vhash_idx =
+				__riscv_vwcvtu_x_x_v_u32m1(vhash_idx16, vl);
+
+			vuint16mf2_t vlookup16 =
+				__riscv_vle16_v_u16mf2(
+					(const uint16_t *)&group_lookup_table[i], vl);
+
+			vuint32m1_t vlookup =
+				__riscv_vwcvtu_x_x_v_u32m1(vlookup16, vl);
+
+			vuint32m1_t vhash =
+				__riscv_vmadd_vv_u32m1(vhash_idx, vhash_val_b, vhash_val_a, vl);
+
+			vuint32m1_t vbucket =
+				__riscv_vsrl_vx_u32m1(vhash, EFD_LOOKUPTBL_SHIFT, vl);
+
+			vuint32m1_t vresult =
+				__riscv_vsrl_vv_u32m1(vlookup, vbucket, vl);
+
+			vresult = __riscv_vand_vv_u32m1(vresult, vmask, vl);
+
+			vresult = __riscv_vsll_vv_u32m1(vresult, vshift, vl);
+
+			vuint32m1_t vzero = __riscv_vmv_v_x_u32m1(0, vl);
+
+			vuint32m1_t vsum =
+				__riscv_vredsum_vs_u32m1_u32m1(vresult, vzero, vl);
+
+			value |= __riscv_vmv_x_s_u32m1_u32(vsum);
+
+			vshift = __riscv_vadd_vv_u32m1(vshift, vincr, vl);
+		}
+
+		return value;
+}
+
+#endif /* __RTE_EFD_RISCV_H__ */
-- 
2.43.0

