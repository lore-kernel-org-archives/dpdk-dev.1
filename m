Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD22DC636A0
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Feb 2026 15:30:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D908B40395;
	Sun, 22 Feb 2026 16:30:43 +0100 (CET)
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com
 [95.215.58.177]) by mails.dpdk.org (Postfix) with ESMTP id A8026402E6
 for <dev@dpdk.org>; Sun, 22 Feb 2026 16:30:32 +0100 (CET)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danielg0.com;
 s=key1; t=1771774232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PYS6+wU+f6QE5wweIR0bQG7E3cTp5X6vrcELl1tsnHA=;
 b=f9ijJRWEiXQCF/VSllnIkXYaBcZrSs22hnR1OmsLj7AHoyx5UFgZUs043eP4tUhArm9ebW
 fb7P6+/lEP9kCs7JeUFAKa6q6EHs5eR9AGpmd5T+OzfGWrU5X4mOgdU1E0YIH3ve4ec0pK
 c1HiKCx+NNBRwcHVnZDkablmMAxrmrE=
From: Daniel Gregory <code@danielg0.com>
To: =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: Daniel Gregory <daniel.gregory@bytedance.com>, dev@dpdk.org,
 Punit Agrawal <punit.agrawal@bytedance.com>,
 Liang Ma <liangma@liangbit.com>,
 Pengcheng Wang <wangpengcheng.pp@bytedance.com>,
 Chunsong Feng <fengchunsong@bytedance.com>,
 Daniel Gregory <code@danielg0.com>
Subject: [PATCH v4 01/10] config/riscv: detect presence of Zbc extension
Date: Sun, 22 Feb 2026 16:29:55 +0100
Message-ID: <02da1bd0fddc16075e0dba3de56ff7356ea23f97.1771772598.git.code@danielg0.com>
In-Reply-To: <cover.1771772598.git.code@danielg0.com>
References: <20240827153230.52880-1-daniel.gregory@bytedance.com>
 <cover.1771772598.git.code@danielg0.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Daniel Gregory <daniel.gregory@bytedance.com>

The RISC-V Zbc extension adds carry-less multiply instructions we can
use to implement more efficient CRC hashing algorithms.

The RISC-V C api defines Zbc intrinsics we can use rather than inline
assembly on newer versions of GCC (14.1.0+) and Clang (18.1.0+). We can
detect whether these are supported on the compiler and -march we're
building with by using the architecture extension macros in combination
with checking compiler version.

The Linux kernel exposes a RISC-V hardware probing syscall for getting
information about the system at run-time including which extensions are
available. We detect whether this interface is present by looking for
the <asm/hwprobe.h> header, as it's only present in newer kernels
(v6.4+). Furthermore, support for detecting certain extensions,
including Zbc, wasn't present until versions after this, so we need to
check the constants this header exports.

The kernel exposes bitmasks for each extension supported by the probing
interface, rather than the bit index that is set if that extensions is
present, so modify the existing cpu flag HWCAP table entries to line up
with this. The values returned by the interface are 64-bits long, so
grow the hwcap registers array to be able to hold them.

If the Zbc extension and intrinsics are both present and we can detect
the Zbc extension at runtime, we define a flag, RTE_RISCV_FEATURE_ZBC.

Signed-off-by: Daniel Gregory <daniel.gregory@bytedance.com>
Signed-off-by: Daniel Gregory <code@danielg0.com>
---
 config/riscv/meson.build             |  32 ++++++++
 lib/eal/riscv/include/rte_cpuflags.h |   2 +
 lib/eal/riscv/rte_cpuflags.c         | 112 +++++++++++++++++++--------
 3 files changed, 114 insertions(+), 32 deletions(-)

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index a06429a1e2..65ab4b7347 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -131,6 +131,16 @@ else
     warning('RISC-V architecture extension test macros not available. Build-time detection of extensions not possible')
 endif
 
+# check if we can use hwprobe interface for runtime extension detection
+riscv_hwprobe = false
+if (cc.check_header('asm/hwprobe.h', args: machine_args))
+  message('Detected hwprobe interface, enabling runtime detection of supported extensions')
+  machine_args += ['-DRTE_RISCV_FEATURE_HWPROBE']
+  riscv_hwprobe = true
+else
+  warning('Hwprobe interface not available (present in Linux v6.4+), instruction extensions won\'t be enabled')
+endif
+
 # detect extensions
 # Requires intrinsics available in GCC 14.1.0+ and Clang 18.1.0+
 if (riscv_extension_macros and
@@ -147,6 +157,28 @@ if (riscv_extension_macros and
     endif
 endif
 
+# detect extensions
+# RISC-V Carry-less multiplication extension (Zbc) for hardware implementations
+# of CRC-32C (lib/hash/rte_crc_riscv64.h) and CRC-32/16 (lib/net/net_crc_zbc.c).
+# Requires intrinsics available in GCC 14.1.0+ and Clang 18.1.0+
+if (riscv_extension_macros and riscv_hwprobe and
+    (cc.get_define('__riscv_zbc', args: machine_args) != ''))
+  if ((cc.get_id() == 'gcc' and cc.version().version_compare('>=14.1.0'))
+      or (cc.get_id() == 'clang' and cc.version().version_compare('>=18.1.0')))
+    # determine whether we can detect Zbc extension (this wasn't possible until
+    # Linux kernel v6.8)
+    if (cc.compiles('''#include <asm/hwprobe.h>
+                       int a = RISCV_HWPROBE_EXT_ZBC;''', args: machine_args))
+      message('Compiling with the Zbc extension')
+      machine_args += ['-DRTE_RISCV_FEATURE_ZBC']
+    else
+      warning('Detected Zbc extension but cannot use because runtime detection doesn\'t support it (support present in Linux kernel v6.8+)')
+    endif
+  else
+    warning('Detected Zbc extension but cannot use because intrinsics are not available (present in GCC 14.1.0+ and Clang 18.1.0+)')
+  endif
+endif
+
 # apply flags
 foreach flag: dpdk_flags
     if flag.length() > 0
diff --git a/lib/eal/riscv/include/rte_cpuflags.h b/lib/eal/riscv/include/rte_cpuflags.h
index b1bd7953d4..a208c203f3 100644
--- a/lib/eal/riscv/include/rte_cpuflags.h
+++ b/lib/eal/riscv/include/rte_cpuflags.h
@@ -38,6 +38,8 @@ enum rte_cpu_flag_t {
 	RTE_CPUFLAG_RISCV_ISA_X, /* Non-standard extension present */
 	RTE_CPUFLAG_RISCV_ISA_Y, /* Reserved */
 	RTE_CPUFLAG_RISCV_ISA_Z, /* Reserved */
+
+	RTE_CPUFLAG_RISCV_EXT_ZBC, /* Carry-less multiplication */
 };
 
 #include "generic/rte_cpuflags.h"
diff --git a/lib/eal/riscv/rte_cpuflags.c b/lib/eal/riscv/rte_cpuflags.c
index 4dec491b0d..f141556f23 100644
--- a/lib/eal/riscv/rte_cpuflags.c
+++ b/lib/eal/riscv/rte_cpuflags.c
@@ -12,6 +12,15 @@
 #include <assert.h>
 #include <unistd.h>
 #include <string.h>
+#include <sys/syscall.h>
+
+/*
+ * when hardware probing is not possible, we assume all extensions are missing
+ * at runtime
+ */
+#ifdef RTE_RISCV_FEATURE_HWPROBE
+#include <asm/hwprobe.h>
+#endif
 
 #ifndef AT_HWCAP
 #define AT_HWCAP 16
@@ -30,54 +39,90 @@ enum cpu_register_t {
 	REG_HWCAP,
 	REG_HWCAP2,
 	REG_PLATFORM,
-	REG_MAX
+	REG_HWPROBE_IMA_EXT_0,
+	REG_MAX,
 };
 
-typedef uint32_t hwcap_registers_t[REG_MAX];
+typedef uint64_t hwcap_registers_t[REG_MAX];
 
 /**
  * Struct to hold a processor feature entry
  */
 struct feature_entry {
 	uint32_t reg;
-	uint32_t bit;
+	uint64_t mask;
 #define CPU_FLAG_NAME_MAX_LEN 64
 	char name[CPU_FLAG_NAME_MAX_LEN];
 };
 
-#define FEAT_DEF(name, reg, bit) \
-	[RTE_CPUFLAG_##name] = {reg, bit, #name},
+#define FEAT_DEF(name, reg, mask) \
+	[RTE_CPUFLAG_##name] = {reg, mask, #name},
 
 typedef Elf64_auxv_t _Elfx_auxv_t;
 
 const struct feature_entry rte_cpu_feature_table[] = {
-	FEAT_DEF(RISCV_ISA_A, REG_HWCAP,    0)
-	FEAT_DEF(RISCV_ISA_B, REG_HWCAP,    1)
-	FEAT_DEF(RISCV_ISA_C, REG_HWCAP,    2)
-	FEAT_DEF(RISCV_ISA_D, REG_HWCAP,    3)
-	FEAT_DEF(RISCV_ISA_E, REG_HWCAP,    4)
-	FEAT_DEF(RISCV_ISA_F, REG_HWCAP,    5)
-	FEAT_DEF(RISCV_ISA_G, REG_HWCAP,    6)
-	FEAT_DEF(RISCV_ISA_H, REG_HWCAP,    7)
-	FEAT_DEF(RISCV_ISA_I, REG_HWCAP,    8)
-	FEAT_DEF(RISCV_ISA_J, REG_HWCAP,    9)
-	FEAT_DEF(RISCV_ISA_K, REG_HWCAP,   10)
-	FEAT_DEF(RISCV_ISA_L, REG_HWCAP,   11)
-	FEAT_DEF(RISCV_ISA_M, REG_HWCAP,   12)
-	FEAT_DEF(RISCV_ISA_N, REG_HWCAP,   13)
-	FEAT_DEF(RISCV_ISA_O, REG_HWCAP,   14)
-	FEAT_DEF(RISCV_ISA_P, REG_HWCAP,   15)
-	FEAT_DEF(RISCV_ISA_Q, REG_HWCAP,   16)
-	FEAT_DEF(RISCV_ISA_R, REG_HWCAP,   17)
-	FEAT_DEF(RISCV_ISA_S, REG_HWCAP,   18)
-	FEAT_DEF(RISCV_ISA_T, REG_HWCAP,   19)
-	FEAT_DEF(RISCV_ISA_U, REG_HWCAP,   20)
-	FEAT_DEF(RISCV_ISA_V, REG_HWCAP,   21)
-	FEAT_DEF(RISCV_ISA_W, REG_HWCAP,   22)
-	FEAT_DEF(RISCV_ISA_X, REG_HWCAP,   23)
-	FEAT_DEF(RISCV_ISA_Y, REG_HWCAP,   24)
-	FEAT_DEF(RISCV_ISA_Z, REG_HWCAP,   25)
+	FEAT_DEF(RISCV_ISA_A, REG_HWCAP, 1 <<  0)
+	FEAT_DEF(RISCV_ISA_B, REG_HWCAP, 1 <<  1)
+	FEAT_DEF(RISCV_ISA_C, REG_HWCAP, 1 <<  2)
+	FEAT_DEF(RISCV_ISA_D, REG_HWCAP, 1 <<  3)
+	FEAT_DEF(RISCV_ISA_E, REG_HWCAP, 1 <<  4)
+	FEAT_DEF(RISCV_ISA_F, REG_HWCAP, 1 <<  5)
+	FEAT_DEF(RISCV_ISA_G, REG_HWCAP, 1 <<  6)
+	FEAT_DEF(RISCV_ISA_H, REG_HWCAP, 1 <<  7)
+	FEAT_DEF(RISCV_ISA_I, REG_HWCAP, 1 <<  8)
+	FEAT_DEF(RISCV_ISA_J, REG_HWCAP, 1 <<  9)
+	FEAT_DEF(RISCV_ISA_K, REG_HWCAP, 1 << 10)
+	FEAT_DEF(RISCV_ISA_L, REG_HWCAP, 1 << 11)
+	FEAT_DEF(RISCV_ISA_M, REG_HWCAP, 1 << 12)
+	FEAT_DEF(RISCV_ISA_N, REG_HWCAP, 1 << 13)
+	FEAT_DEF(RISCV_ISA_O, REG_HWCAP, 1 << 14)
+	FEAT_DEF(RISCV_ISA_P, REG_HWCAP, 1 << 15)
+	FEAT_DEF(RISCV_ISA_Q, REG_HWCAP, 1 << 16)
+	FEAT_DEF(RISCV_ISA_R, REG_HWCAP, 1 << 17)
+	FEAT_DEF(RISCV_ISA_S, REG_HWCAP, 1 << 18)
+	FEAT_DEF(RISCV_ISA_T, REG_HWCAP, 1 << 19)
+	FEAT_DEF(RISCV_ISA_U, REG_HWCAP, 1 << 20)
+	FEAT_DEF(RISCV_ISA_V, REG_HWCAP, 1 << 21)
+	FEAT_DEF(RISCV_ISA_W, REG_HWCAP, 1 << 22)
+	FEAT_DEF(RISCV_ISA_X, REG_HWCAP, 1 << 23)
+	FEAT_DEF(RISCV_ISA_Y, REG_HWCAP, 1 << 24)
+	FEAT_DEF(RISCV_ISA_Z, REG_HWCAP, 1 << 25)
+
+#ifdef RTE_RISCV_FEATURE_ZBC
+	FEAT_DEF(RISCV_EXT_ZBC, REG_HWPROBE_IMA_EXT_0, RISCV_HWPROBE_EXT_ZBC)
+#else
+	FEAT_DEF(RISCV_EXT_ZBC, REG_HWPROBE_IMA_EXT_0, 0)
+#endif
 };
+
+#ifdef RTE_RISCV_FEATURE_HWPROBE
+/*
+ * Use kernel interface for probing hardware capabilities to get extensions
+ * present on this machine
+ */
+static uint64_t
+rte_cpu_hwprobe_ima_ext(void)
+{
+	long ret;
+	struct riscv_hwprobe extensions_pair;
+
+	struct riscv_hwprobe *pairs = &extensions_pair;
+	size_t pair_count = 1;
+	/* empty set of cpus returns extensions present on all cpus */
+	cpu_set_t *cpus = NULL;
+	size_t cpusetsize = 0;
+	unsigned int flags = 0;
+
+	extensions_pair.key = RISCV_HWPROBE_KEY_IMA_EXT_0;
+	ret = syscall(__NR_riscv_hwprobe, pairs, pair_count, cpusetsize, cpus,
+		      flags);
+
+	if (ret != 0)
+		return 0;
+	return extensions_pair.value;
+}
+#endif /* RTE_RISCV_FEATURE_HWPROBE */
+
 /*
  * Read AUXV software register and get cpu features for ARM
  */
@@ -86,6 +131,9 @@ rte_cpu_get_features(hwcap_registers_t out)
 {
 	out[REG_HWCAP] = rte_cpu_getauxval(AT_HWCAP);
 	out[REG_HWCAP2] = rte_cpu_getauxval(AT_HWCAP2);
+#ifdef RTE_RISCV_FEATURE_HWPROBE
+	out[REG_HWPROBE_IMA_EXT_0] = rte_cpu_hwprobe_ima_ext();
+#endif
 }
 
 /*
@@ -106,7 +154,7 @@ rte_cpu_get_flag_enabled(enum rte_cpu_flag_t feature)
 		return -EFAULT;
 
 	rte_cpu_get_features(regs);
-	return (regs[feat->reg] >> feat->bit) & 1;
+	return (regs[feat->reg] & feat->mask) != 0;
 }
 
 RTE_EXPORT_SYMBOL(rte_cpu_get_flag_name)
-- 
2.53.0

