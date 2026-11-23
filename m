Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45657606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=marvell.com header.i=@marvell.com header.a=rsa-sha256 header.s=pfpt0220 header.b=X/DLUSaV
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A34644027A;
	Mon, 23 Nov 2026 13:34:44 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTPS id B98DA40262
 for <dev@dpdk.org>; Mon, 23 Nov 2026 13:34:42 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANCIqJ61687238; Mon, 23 Nov 2026 04:34:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=TcHSTUd2MJIyzz/wufBMeML
 51Hogz7RfSi3Qq3wx8Pk=; b=X/DLUSaVitc7NlQ+PJjMF2JBhX+ZVB+Rc/1o1OG
 bzHPTh6PIzWTcsLvIFtjX6F7sfhe/fmNcn1AV8KSlVtp8FnvPleNzsy0XT/vBik0
 vw+DTJ6xt3VyYrGTOLG6+GOvt3vukZmt7La1qBsePg0v1p13DIJk1a6odRH+tGRX
 a650343q09YpnyW1bxF08pWo8Zi5XY4TZi/abu1wUN+5DH4t2sHlGdz7ZHViOv9R
 Awnvymo1adrxqvcbzF/M+YrOwneH/882vBBqqC8JlKarwgVbZsxwkyhBUpagJgYj
 94fc1WYdH67YAuoOJfSM+W5glKuI5HNFEg0NfKbNkTDsBjA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4j3t0h3s81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 04:34:36 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 23 Nov 2026 04:34:35 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 23 Nov 2026 04:34:35 -0800
Received: from LYYJYPGKF4.marvell.com (unknown [10.28.161.76])
 by maili.marvell.com (Postfix) with ESMTP id C6BC43F704E;
 Mon, 23 Nov 2026 04:34:32 -0800 (PST)
From: <pbhagavatula@marvell.com>
To: <jerinj@marvell.com>, Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>
CC: <dev@dpdk.org>, Pavan Nikhilesh <pbhagavatula@marvell.com>
Subject: [PATCH] eal/arm: skip ISB for precise counter reads with ECV
Date: Mon, 23 Nov 2026 18:04:29 +0530
Message-ID: <20261123123429.31369-1-pbhagavatula@marvell.com>
X-Mailer: git-send-email 2.50.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0OCBTYWx0ZWRfXyx2/heUZCCwH
 v0GsnYkKE3DCjTZp5SvC6x3u+/NLcikGqwC0exLBvhdhCZZ16MpOUviKPIRrqhzBmmtHX2b1xbC
 6gYIU6va2xUX0P+mCFKAYhPYJaZegXUjS+iTBGZkxFPir5MNBiDf5Bx6KpRNsV10j4Y41braZPG
 oIYrutzwaCd7xHpEH8wtsNQtTnbRvTOkYF6Scw+S/59cKwzJPUIHxVB8gKD7ZgAGeUb6AB8PBkE
 XpUiA/XNjtiuXvPXeS7xSIUFrDuJI7oMjxmquRpf6T3ZTjC0/SiPMFdMmU60dQ6F/PhJBLw7zlI
 2qyuWiQUl2x/O5GPg0GUatJJHgaCKEZ+M5bVqlS/ItEYXYhWpBODO7LrsUZ2wAM6XMb3ZBMcXuy
 r8827b4aKzbAGKD2PCQv98/NUoedHKnlmJrP6/pQpA3z3yn9HjERtn1jnxKg4y3mx9zy2ZEzHuc
 ZDG3l9okMqcDRx7aXBg==
X-Proofpoint-ORIG-GUID: OQAUGn7PcdqHep-sq9w2pKnBbfItDBZ2
X-Proofpoint-GUID: OQAUGn7PcdqHep-sq9w2pKnBbfItDBZ2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0OCBTYWx0ZWRfX5gDADZ7So35s
 4NC9ydPmx4aRNvtNZuuZ2pk0LNMhNlgsnuazjYqGX49PiF3wMKQFnIsh2/84rp5YZ56mfl6BOab
 pXsYiCmzQfgnT7VXZzXTfcY9hqcHzOw=
X-Authority-Analysis: v=2.4 cv=aO9lOr9m c=1 sm=1 tr=0 ts=6b0432dc cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=vXtn8tm3QcdZARTbHasA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-23_01,2025-10-01_01
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Pavan Nikhilesh <pbhagavatula@marvell.com>

CPUs with FEAT_ECV provide CNTVCTSS_EL0, a self-synchronized counter
read that does not need a preceding ISB. Use it for precise reads when
the CPU supports it, detected at init through the new RTE_CPUFLAG_ECV.

Builds for SoCs known to have ECV, such as cn20k, can define
RTE_ARM_FEATURE_ECV to skip the runtime check. The register is
accessed by name if the assembler supports it, else by its raw
encoding.

Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
---
 app/test/test_cpuflags.c              |  3 +++
 config/arm/meson.build                | 10 +++++++++-
 lib/eal/arm/include/rte_cpuflags_64.h |  3 +++
 lib/eal/arm/include/rte_cycles_64.h   | 27 +++++++++++++++++++++++++++
 lib/eal/arm/rte_cpuflags.c            |  1 +
 lib/eal/arm/rte_cycles.c              | 13 +++++++++++++
 6 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/app/test/test_cpuflags.c b/app/test/test_cpuflags.c
index a0ad0998153a..7353f686ee42 100644
--- a/app/test/test_cpuflags.c
+++ b/app/test/test_cpuflags.c
@@ -159,6 +159,9 @@ test_cpuflags(void)
 
 	printf("Check for WFXT:\t");
 	CHECK_FOR_FLAG(RTE_CPUFLAG_WFXT);
+
+	printf("Check for ECV:\t");
+	CHECK_FOR_FLAG(RTE_CPUFLAG_ECV);
 #endif
 
 #if defined(RTE_ARCH_X86_64) || defined(RTE_ARCH_I686)
diff --git a/config/arm/meson.build b/config/arm/meson.build
index 5e7f9d9398b9..44a242213d09 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -492,7 +492,8 @@ soc_cn20k = {
     'implementer' : '0x41',
     'flags': [
         ['RTE_MAX_LCORE', 42],
-        ['RTE_MAX_NUMA_NODES', 1]
+        ['RTE_MAX_NUMA_NODES', 1],
+        ['RTE_ARM_FEATURE_ECV', true]
     ],
     'part_number': '0xd8e',
     'numa': false
@@ -1050,3 +1051,10 @@ if cc.get_define('__ARM_FEATURE_CRYPTO', args: machine_args) != ''
     compile_time_cpuflags += ['RTE_CPUFLAG_AES', 'RTE_CPUFLAG_PMULL',
     'RTE_CPUFLAG_SHA1', 'RTE_CPUFLAG_SHA2']
 endif
+
+# Use the CNTVCTSS_EL0 name in inline asm only if the assembler knows it with
+# the selected machine args; the raw register encoding is used otherwise.
+if cc.compiles('''void f(void) { unsigned long v; __asm__ volatile("mrs %0, cntvctss_el0" : "=r"(v)); }''',
+        args: machine_args, name: 'assembler supports cntvctss_el0')
+    dpdk_conf.set('RTE_ARM_ASM_CNTVCTSS', 1)
+endif
diff --git a/lib/eal/arm/include/rte_cpuflags_64.h b/lib/eal/arm/include/rte_cpuflags_64.h
index 02ee422fd4bc..1917fd4a8ffc 100644
--- a/lib/eal/arm/include/rte_cpuflags_64.h
+++ b/lib/eal/arm/include/rte_cpuflags_64.h
@@ -83,6 +83,9 @@ enum rte_cpu_flag_t {
 
 	/* WFET and WFIT instructions */
 	RTE_CPUFLAG_WFXT,
+
+	/* Enhanced Counter Virtualization (self-synchronized counter reads) */
+	RTE_CPUFLAG_ECV,
 };
 
 #include "generic/rte_cpuflags.h"
diff --git a/lib/eal/arm/include/rte_cycles_64.h b/lib/eal/arm/include/rte_cycles_64.h
index bb76e4d7e0b2..cc38baded81c 100644
--- a/lib/eal/arm/include/rte_cycles_64.h
+++ b/lib/eal/arm/include/rte_cycles_64.h
@@ -6,6 +6,8 @@
 #ifndef _RTE_CYCLES_ARM64_H_
 #define _RTE_CYCLES_ARM64_H_
 
+#include <stdbool.h>
+
 #include "generic/rte_cycles.h"
 
 #ifdef __cplusplus
@@ -32,9 +34,30 @@ __rte_arm64_cntvct(void)
 	return tsc;
 }
 
+#ifdef RTE_ARM_FEATURE_ECV
+#define __rte_arm64_ecv_enabled() 1
+#else
+/** Set at EAL init if the CPU supports FEAT_ECV, false before that. */
+extern bool rte_arm64_ecv;
+#define __rte_arm64_ecv_enabled() rte_arm64_ecv
+#endif
+
+/** Read generic counter with ordering */
 static __rte_always_inline uint64_t
 __rte_arm64_cntvct_precise(void)
 {
+	uint64_t tsc;
+
+	if (__rte_arm64_ecv_enabled()) {
+		/* CNTVCTSS_EL0 (FEAT_ECV) is self-synchronized, no ISB needed. */
+#ifdef RTE_ARM_ASM_CNTVCTSS
+		asm volatile("mrs %0, cntvctss_el0" : "=r" (tsc) : : "memory");
+#else
+		/* Raw encoding of CNTVCTSS_EL0 for assemblers without ECV. */
+		asm volatile("mrs %0, s3_3_c14_c0_6" : "=r" (tsc) : : "memory");
+#endif
+		return tsc;
+	}
 	asm volatile("isb" : : : "memory");
 	return __rte_arm64_cntvct();
 }
@@ -94,8 +117,12 @@ rte_rdtsc(void)
 static __rte_always_inline uint64_t
 rte_rdtsc_precise(void)
 {
+#ifndef RTE_ARM_EAL_RDTSC_USE_PMU
+	return __rte_arm64_cntvct_precise();
+#else
 	asm volatile("isb" : : : "memory");
 	return rte_rdtsc();
+#endif
 }
 
 static __rte_always_inline uint64_t
diff --git a/lib/eal/arm/rte_cpuflags.c b/lib/eal/arm/rte_cpuflags.c
index 32243f293a45..8c781c4bb027 100644
--- a/lib/eal/arm/rte_cpuflags.c
+++ b/lib/eal/arm/rte_cpuflags.c
@@ -116,6 +116,7 @@ const struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(SVEF32MM,	REG_HWCAP2,   10)
 	FEAT_DEF(SVEF64MM,	REG_HWCAP2,   11)
 	FEAT_DEF(SVEBF16,	REG_HWCAP2,   12)
+	FEAT_DEF(ECV,		REG_HWCAP2,   19)
 	FEAT_DEF(WFXT,		REG_HWCAP2,   31)
 	FEAT_DEF(AARCH64,	REG_PLATFORM,  0)
 };
diff --git a/lib/eal/arm/rte_cycles.c b/lib/eal/arm/rte_cycles.c
index 5bd29b24b187..d04ad2d4166a 100644
--- a/lib/eal/arm/rte_cycles.c
+++ b/lib/eal/arm/rte_cycles.c
@@ -2,12 +2,25 @@
  * Copyright(c) 2015 Cavium, Inc
  */
 
+#include <stdbool.h>
+
+#include <rte_cpuflags.h>
+#include <eal_export.h>
+
 #include "eal_private.h"
 #include "rte_cycles.h"
 
+#ifndef RTE_ARM_FEATURE_ECV
+RTE_EXPORT_SYMBOL(rte_arm64_ecv)
+bool rte_arm64_ecv;
+#endif
+
 uint64_t
 get_tsc_freq_arch(void)
 {
+#if defined RTE_ARCH_ARM64 && !defined RTE_ARM_FEATURE_ECV
+	rte_arm64_ecv = rte_cpu_get_flag_enabled(RTE_CPUFLAG_ECV) > 0;
+#endif
 #if defined RTE_ARCH_ARM64 && !defined RTE_ARM_EAL_RDTSC_USE_PMU
 	return __rte_arm64_cntfrq();
 #elif defined RTE_ARCH_ARM64 && defined RTE_ARM_EAL_RDTSC_USE_PMU
-- 
2.50.1 (Apple Git-155)

