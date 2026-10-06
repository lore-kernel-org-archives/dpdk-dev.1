Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72223CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 08:21:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29A0940270;
	Tue,  6 Oct 2026 10:21:05 +0200 (CEST)
Received: from mx0a-003cac02.pphosted.com (mx0a-003cac02.pphosted.com
 [205.220.169.235])
 by mails.dpdk.org (Postfix) with ESMTP id A29004025F;
 Tue,  6 Oct 2026 10:21:03 +0200 (CEST)
Received: from pps.filterd (m0314249.ppops.net [127.0.0.1])
 by mx0a-003cac02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69662Xnk3870506; Tue, 6 Oct 2026 02:21:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=keysight.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=keysight-0815; bh=G+FIQ0CASVzyf+sTapgJE+ppu2AO4jO
 MrzUDohu0yOc=; b=s64woVIc+6y4/ezMLy0nOpBEnYNf66V0BYJWb/CCfy1W2Il
 hfDj/ODx8r9u7f0jMfgxwKJmULykS5u9M5R+iwxe5jFTD1TLbqZJXwnLxkgR7ztx
 9zUat79C4BCTjaHTMQfDmWQSk3q2clEG5m89Yuqpg5oqrm/W5yqmIII/cQaa9O/w
 wTKVEuzFB2qSoFQbRjiteGzAAtIVaZHLy5KTkUZ6M+XfktOU+wfu7QI0EOCv5WAK
 IyboqOowC3vKkIJzZsJGd31o21g/afpL+FQ/EhPkqslxH++m1I8sBKyW9aL9e5Hw
 1B61vDgfCA3EU/0dZ4OIjL4MdT5VksogA8wKGRg==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-003cac02.pphosted.com (PPS) with ESMTPS id 4h3hev3vhb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
 Tue, 06 Oct 2026 02:21:02 -0600 (MDT)
Received: from ppserconnector3.cos.dmz.keysight.com ([192.25.5.34])
 by cmsmtp with ESMTPSA
 id E0PnxkPbxyuTnE0Q1xJEj1; Tue, 06 Oct 2026 08:21:01 +0000
X-Mailer: SER-9da617c0781f77b24d454c2ffca1e7acced358b813e950646219cc1f5ae32690
X-Cloudmark-MID: E0PnxkPbxyuTnE0Q1xJEj1
pfptstatus: 1568ac97-559f-432f-801f-22d134b402f7@pfpt
X-Proofpoint-CID: 3612b050-454b-3384-9099-49ecf78b7412
Received: from eda-dev1.buh.is.keysight.com ([10.38.132.129])
 by ppserconnector3.cos.dmz.keysight.com with ESMTP
 id E0Pzx70Lm7E8iE0Pzxwmp4; Tue, 06 Oct 2026 08:21:01 +0000
ser_con_authuser: ??
From: Dragos Tarcatu <dragos.tarcatu@keysight.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, konstantin.v.ananyev@yandex.ru,
 Dragos Tarcatu <dragos.tarcatu@keysight.com>, stable@dpdk.org
Subject: [PATCH] eal/x86: check OS support for AVX and AVX512 state
Date: Tue,  6 Oct 2026 08:20:56 +0000
Message-Id: <20261006082056.46426-1-dragos.tarcatu@keysight.com>
X-Mailer: git-send-email 2.34.1
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

rte_cpu_get_flag_enabled() reads only the CPUID feature bits.
CPUID tells what the CPU implements, not what the OS enables.
If the OS does not enable the related state components in XCR0,
the first AVX or AVX512 instruction raises #UD.

CPUID can report AVX512 while XCR0 has no AVX512 state. Old kernels
without AVX512 state support leave XCR0 at 0x7. A kernel booted with
clearcpuid=avx512f removes the AVX512 state from XCR0, but CPUID still
reports AVX512F. Similarly, gather_data_sampling=force removes the AVX
state.

On such a system, the rte_net_crc constructor selects the AVX512 code
from CPUID alone. The dynamic loader runs this constructor before
main(), so the application gets SIGILL before EAL can parse any
argument.

For the AVX-class and AVX512-class flags, also read XCR0 with XGETBV.
Report the flag only when the OS has enabled the related state.
Use XGETBV only when CPUID reports OSXSAVE, because the instruction
faults otherwise.

This change also affects rte_cpu_is_supported(). If DPDK is built for
AVX512 and the OS does not enable AVX512 state, EAL can now stop with
an error that names the missing flag. This is possible only if no
AVX512 instruction executes before rte_eal_init(), for example in a
constructor.

Fixes: 3934bb741354 ("eal/x86: identify AVX512 CPU flag")
Cc: stable@dpdk.org

Signed-off-by: Dragos Tarcatu <dragos.tarcatu@keysight.com>
---
 lib/eal/include/generic/rte_cpuflags.h |   3 +
 lib/eal/x86/rte_cpuflags.c             | 102 ++++++++++++++++++++-----
 2 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/lib/eal/include/generic/rte_cpuflags.h b/lib/eal/include/generic/rte_cpuflags.h
index 26d5229b8e..af7eff6bb6 100644
--- a/lib/eal/include/generic/rte_cpuflags.h
+++ b/lib/eal/include/generic/rte_cpuflags.h
@@ -63,6 +63,9 @@ rte_cpu_get_flag_name(enum rte_cpu_flag_t feature);
 /**
  * Function for checking a CPU flag availability
  *
+ * A flag is available only if the CPU implements the feature
+ * and the OS enables the feature for use.
+ *
  * @param feature
  *     CPU flag to query CPU for
  * @return
diff --git a/lib/eal/x86/rte_cpuflags.c b/lib/eal/x86/rte_cpuflags.c
index 80b71a3ce0..925add6375 100644
--- a/lib/eal/x86/rte_cpuflags.c
+++ b/lib/eal/x86/rte_cpuflags.c
@@ -14,6 +14,23 @@
 #include "rte_cpuid.h"
 #include "rte_atomic.h"
 
+#ifdef RTE_TOOLCHAIN_MSVC
+#include <immintrin.h>
+#endif
+
+/*
+ * XCR0 state components that the OS must enable before
+ * the related instructions can execute without faulting.
+ */
+#define XSTATE_SSE      (UINT64_C(1) << 1)
+#define XSTATE_YMM      (UINT64_C(1) << 2)
+#define XSTATE_OPMASK   (UINT64_C(1) << 5)
+#define XSTATE_ZMM_H256 (UINT64_C(1) << 6)
+#define XSTATE_HI16_ZMM (UINT64_C(1) << 7)
+
+#define XSTATE_AVX    (XSTATE_SSE | XSTATE_YMM)
+#define XSTATE_AVX512 (XSTATE_AVX | XSTATE_OPMASK | XSTATE_ZMM_H256 | XSTATE_HI16_ZMM)
+
 /**
  * Struct to hold a processor feature entry
  */
@@ -26,11 +43,19 @@ struct feature_entry {
 	char name[CPU_FLAG_NAME_MAX_LEN];       /**< String for printing */
 	bool has_value;
 	bool value;
+	uint64_t xstate;			/**< XCR0 bits the OS must enable */
 };
 
 #define FEAT_DEF(name, leaf, subleaf, reg, bit) \
 	[RTE_CPUFLAG_##name] = {leaf, subleaf, reg, bit, #name },
 
+/*
+ * A VEX or EVEX encoded feature also needs OS support for its register state.
+ * Use FEAT_DEF_XSTATE for such a feature, with the XCR0 bits that it needs.
+ */
+#define FEAT_DEF_XSTATE(name, leaf, subleaf, reg, bit, xs) \
+	[RTE_CPUFLAG_##name] = {leaf, subleaf, reg, bit, #name, .xstate = xs },
+
 struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(SSE3, 0x00000001, 0, RTE_REG_ECX,  0)
 	FEAT_DEF(PCLMULQDQ, 0x00000001, 0, RTE_REG_ECX,  1)
@@ -43,7 +68,7 @@ struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(TM2, 0x00000001, 0, RTE_REG_ECX,  8)
 	FEAT_DEF(SSSE3, 0x00000001, 0, RTE_REG_ECX,  9)
 	FEAT_DEF(CNXT_ID, 0x00000001, 0, RTE_REG_ECX, 10)
-	FEAT_DEF(FMA, 0x00000001, 0, RTE_REG_ECX, 12)
+	FEAT_DEF_XSTATE(FMA, 0x00000001, 0, RTE_REG_ECX, 12, XSTATE_AVX)
 	FEAT_DEF(CMPXCHG16B, 0x00000001, 0, RTE_REG_ECX, 13)
 	FEAT_DEF(XTPR, 0x00000001, 0, RTE_REG_ECX, 14)
 	FEAT_DEF(PDCM, 0x00000001, 0, RTE_REG_ECX, 15)
@@ -58,8 +83,8 @@ struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(AES, 0x00000001, 0, RTE_REG_ECX, 25)
 	FEAT_DEF(XSAVE, 0x00000001, 0, RTE_REG_ECX, 26)
 	FEAT_DEF(OSXSAVE, 0x00000001, 0, RTE_REG_ECX, 27)
-	FEAT_DEF(AVX, 0x00000001, 0, RTE_REG_ECX, 28)
-	FEAT_DEF(F16C, 0x00000001, 0, RTE_REG_ECX, 29)
+	FEAT_DEF_XSTATE(AVX, 0x00000001, 0, RTE_REG_ECX, 28, XSTATE_AVX)
+	FEAT_DEF_XSTATE(F16C, 0x00000001, 0, RTE_REG_ECX, 29, XSTATE_AVX)
 	FEAT_DEF(RDRAND, 0x00000001, 0, RTE_REG_ECX, 30)
 	FEAT_DEF(HYPERVISOR, 0x00000001, 0, RTE_REG_ECX, 31)
 
@@ -107,34 +132,34 @@ struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(FSGSBASE, 0x00000007, 0, RTE_REG_EBX,  0)
 	FEAT_DEF(BMI1, 0x00000007, 0, RTE_REG_EBX,  3)
 	FEAT_DEF(HLE, 0x00000007, 0, RTE_REG_EBX,  4)
-	FEAT_DEF(AVX2, 0x00000007, 0, RTE_REG_EBX,  5)
+	FEAT_DEF_XSTATE(AVX2, 0x00000007, 0, RTE_REG_EBX,  5, XSTATE_AVX)
 	FEAT_DEF(SMEP, 0x00000007, 0, RTE_REG_EBX,  7)
 	FEAT_DEF(BMI2, 0x00000007, 0, RTE_REG_EBX,  8)
 	FEAT_DEF(ERMS, 0x00000007, 0, RTE_REG_EBX,  9)
 	FEAT_DEF(INVPCID, 0x00000007, 0, RTE_REG_EBX, 10)
 	FEAT_DEF(RTM, 0x00000007, 0, RTE_REG_EBX, 11)
-	FEAT_DEF(AVX512F, 0x00000007, 0, RTE_REG_EBX, 16)
-	FEAT_DEF(AVX512DQ, 0x00000007, 0, RTE_REG_EBX, 17)
+	FEAT_DEF_XSTATE(AVX512F, 0x00000007, 0, RTE_REG_EBX, 16, XSTATE_AVX512)
+	FEAT_DEF_XSTATE(AVX512DQ, 0x00000007, 0, RTE_REG_EBX, 17, XSTATE_AVX512)
 	FEAT_DEF(RDSEED, 0x00000007, 0, RTE_REG_EBX, 18)
-	FEAT_DEF(AVX512IFMA, 0x00000007, 0, RTE_REG_EBX, 21)
-	FEAT_DEF(AVX512CD, 0x00000007, 0, RTE_REG_EBX, 28)
-	FEAT_DEF(AVX512BW, 0x00000007, 0, RTE_REG_EBX, 30)
-	FEAT_DEF(AVX512VL, 0x00000007, 0, RTE_REG_EBX, 31)
+	FEAT_DEF_XSTATE(AVX512IFMA, 0x00000007, 0, RTE_REG_EBX, 21, XSTATE_AVX512)
+	FEAT_DEF_XSTATE(AVX512CD, 0x00000007, 0, RTE_REG_EBX, 28, XSTATE_AVX512)
+	FEAT_DEF_XSTATE(AVX512BW, 0x00000007, 0, RTE_REG_EBX, 30, XSTATE_AVX512)
+	FEAT_DEF_XSTATE(AVX512VL, 0x00000007, 0, RTE_REG_EBX, 31, XSTATE_AVX512)
 
-	FEAT_DEF(AVX512VBMI, 0x00000007, 0, RTE_REG_ECX,  1)
+	FEAT_DEF_XSTATE(AVX512VBMI, 0x00000007, 0, RTE_REG_ECX,  1, XSTATE_AVX512)
 	FEAT_DEF(WAITPKG, 0x00000007, 0, RTE_REG_ECX,  5)
-	FEAT_DEF(AVX512VBMI2, 0x00000007, 0, RTE_REG_ECX,  6)
+	FEAT_DEF_XSTATE(AVX512VBMI2, 0x00000007, 0, RTE_REG_ECX,  6, XSTATE_AVX512)
 	FEAT_DEF(GFNI, 0x00000007, 0, RTE_REG_ECX,  8)
-	FEAT_DEF(VAES, 0x00000007, 0, RTE_REG_ECX,  9)
-	FEAT_DEF(VPCLMULQDQ, 0x00000007, 0, RTE_REG_ECX, 10)
-	FEAT_DEF(AVX512VNNI, 0x00000007, 0, RTE_REG_ECX, 11)
-	FEAT_DEF(AVX512BITALG, 0x00000007, 0, RTE_REG_ECX, 12)
-	FEAT_DEF(AVX512VPOPCNTDQ, 0x00000007, 0, RTE_REG_ECX, 14)
+	FEAT_DEF_XSTATE(VAES, 0x00000007, 0, RTE_REG_ECX,  9, XSTATE_AVX)
+	FEAT_DEF_XSTATE(VPCLMULQDQ, 0x00000007, 0, RTE_REG_ECX, 10, XSTATE_AVX)
+	FEAT_DEF_XSTATE(AVX512VNNI, 0x00000007, 0, RTE_REG_ECX, 11, XSTATE_AVX512)
+	FEAT_DEF_XSTATE(AVX512BITALG, 0x00000007, 0, RTE_REG_ECX, 12, XSTATE_AVX512)
+	FEAT_DEF_XSTATE(AVX512VPOPCNTDQ, 0x00000007, 0, RTE_REG_ECX, 14, XSTATE_AVX512)
 	FEAT_DEF(CLDEMOTE, 0x00000007, 0, RTE_REG_ECX, 25)
 	FEAT_DEF(MOVDIRI, 0x00000007, 0, RTE_REG_ECX, 27)
 	FEAT_DEF(MOVDIR64B, 0x00000007, 0, RTE_REG_ECX, 28)
 
-	FEAT_DEF(AVX512VP2INTERSECT, 0x00000007, 0, RTE_REG_EDX,  8)
+	FEAT_DEF_XSTATE(AVX512VP2INTERSECT, 0x00000007, 0, RTE_REG_EDX,  8, XSTATE_AVX512)
 
 	FEAT_DEF(LAHF_SAHF, 0x80000001, 0, RTE_REG_ECX,  0)
 	FEAT_DEF(LZCNT, 0x80000001, 0, RTE_REG_ECX,  5)
@@ -149,6 +174,38 @@ struct feature_entry rte_cpu_feature_table[] = {
 	FEAT_DEF(INVTSC, 0x80000007, 0, RTE_REG_EDX,  8)
 };
 
+static uint64_t
+xcr0_read(void)
+{
+#ifdef RTE_TOOLCHAIN_MSVC
+	return _xgetbv(0);
+#else
+	uint32_t eax, edx;
+
+	/* use the raw mnemonic: _xgetbv() would need -mxsave */
+	asm volatile("xgetbv" : "=a" (eax), "=d" (edx) : "c" (0));
+	return ((uint64_t)edx << 32) | eax;
+#endif
+}
+
+/*
+ * CPUID reports what the CPU implements, not what the OS enables.
+ * Check that the OS saves the register state that the feature uses.
+ */
+static bool
+xstate_enabled(uint64_t xstate)
+{
+	/*
+	 * XGETBV faults unless the OS has set CR4.OSXSAVE.
+	 * The OSXSAVE entry must not have an xstate mask,
+	 * else this call recurses without end.
+	 */
+	if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_OSXSAVE) != 1)
+		return false;
+
+	return (xcr0_read() & xstate) == xstate;
+}
+
 RTE_EXPORT_SYMBOL(rte_cpu_get_flag_enabled)
 int
 rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
@@ -156,6 +213,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 	struct feature_entry *feat;
 	cpuid_registers_t regs;
 	unsigned int maxleaf;
+	bool value;
 
 	if ((unsigned int)feature >= RTE_DIM(rte_cpu_feature_table))
 		/* Flag does not match anything in the feature tables */
@@ -185,7 +243,13 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 #endif
 
 	/* check if the feature is enabled */
-	feat->value = (regs[feat->reg] >> feat->bit) & 1;
+	value = (regs[feat->reg] >> feat->bit) & 1;
+
+	/* check if the OS enabled the register state for the feature */
+	if (value && feat->xstate != 0)
+		value = xstate_enabled(feat->xstate);
+
+	feat->value = value;
 out:
 	rte_compiler_barrier();
 	feat->has_value = true;
-- 
2.34.1

