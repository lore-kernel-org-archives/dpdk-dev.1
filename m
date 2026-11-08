Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8B606A31C
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Nov 2026 18:39:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BB4240278;
	Sun,  8 Nov 2026 19:39:28 +0100 (CET)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTPS id A439440265
 for <dev@dpdk.org>; Sun,  8 Nov 2026 19:39:26 +0100 (CET)
Received: from ar (unknown [42.86.133.94])
 by APP-01 (Coremail) with SMTP id qwCowAD3I_7XwfBqxnKQAA--.31967S2;
 Mon, 09 Nov 2026 02:39:20 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Sun Yuechi <sunyuechi@iscas.ac.cn>,
 Daniel Gregory <daniel.gregory@bytedance.com>
Subject: [PATCH v2] eal/riscv: add support for zawrs extension
Date: Sun,  8 Nov 2026 10:39:19 -0800
Message-ID: <890bc1ae8c469d644e529a42924ed463bb606df4.1794162421.git.sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20240502144149.66446-1-daniel.gregory@bytedance.com>
References: <20240502144149.66446-1-daniel.gregory@bytedance.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAD3I_7XwfBqxnKQAA--.31967S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJF4ruw1ktFyrtr4DAw4Utwb_yoWDCFW3pF
 Z3Kr1ftws2qrn7G397tr109rWrAw4vga1UJryfZrW09wnxCrnIyrs8Ka4akFykJFs5Z3sI
 krWF9ryY9anrZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
 1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
 7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0E
 wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
 80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
 I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
 k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
 xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiDAEFAmrwkB5DhQAAsY
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Zawrs extension adds a pair of instructions that stall a core until
a memory location is written to. This patch uses one of them to
implement RISC-V specific versions of the rte_wait_until_equal_*
functions. This is potentially more energy efficient than the default
implementation that uses rte_pause/Zihintpause.

The technique works as follows:

* Check the value with a plain load first and return immediately if it
  already matches, as the generic implementation does
* Otherwise create a reservation set containing the address we want to
  wait on using an atomic load (lr.dw)
* Call wrs.nto - this blocks until the reservation set is invalidated by
  someone else writing to that address
* Execution can also resume arbitrarily, so we still need to check
  whether a change occurred and loop if not

Due to RISC-V atomics only supporting naturally aligned word (32 bit)
and double word (64 bit) loads, I've used pointer rounding and bit
shifting to implement waiting on 16-bit values.

The code is enabled at build time when the target ISA string contains
the Zawrs extension, detected through the compiler's __riscv_zawrs
architecture test macro, e.g. -Dcpu_instruction_set=rv64gcv_zawrs.

This is based on an earlier RFC by Daniel Gregory.

Signed-off-by: Daniel Gregory <daniel.gregory@bytedance.com>
Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
v2:
* rebased on main
* use build-time detection via __riscv_zawrs instead of a manual meson flag
* change memorder parameter type from int to rte_memory_order
* fix inverted alignment assert in RTE_WAIT_UNTIL_MASKED
* make the size in RTE_WAIT_UNTIL_MASKED a compile-time constant
* add a plain load before taking the reservation
* add release notes and cross-build documentation

 config/riscv/meson.build                      |   9 +
 .../linux_gsg/cross_build_dpdk_for_riscv.rst  |  26 +++
 doc/guides/rel_notes/release_26_11.rst        |   8 +
 lib/eal/riscv/include/rte_pause.h             | 159 ++++++++++++++++++
 4 files changed, 202 insertions(+)

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index 7f3e3301bb..5370aeac9e 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -153,6 +153,15 @@ if (riscv_extension_macros and
     endif
 endif
 
+# detect Zawrs (wait-on-reservation-set) extension, used by rte_wait_until_equal_*
+# to stall the hart until the polled memory location is written instead of spinning
+if (riscv_extension_macros and
+        (cc.get_define('__riscv_zawrs', args: machine_args) != ''))
+    message('Compiling with the Zawrs extension')
+    machine_args += ['-DRTE_RISCV_FEATURE_ZAWRS']
+    dpdk_flags += [['RTE_RISCV_FEATURE_ZAWRS', 1],]
+endif
+
 # apply flags
 foreach flag: dpdk_flags
     if flag.length() > 0
diff --git a/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst b/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
index bcba12a604..c7be173b9e 100644
--- a/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
+++ b/doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
@@ -115,3 +115,29 @@ Currently the following targets are supported:
 To add a new target support, ``config/riscv/meson.build`` has to be modified by
 adding a new vendor/architecture id and a corresponding cross-file has to be
 added to ``config/riscv`` directory.
+
+
+Optional ISA extensions
+-----------------------
+
+Some optimisations are enabled at build time when the target ISA string
+includes the extension.
+The build looks at the per-extension macros the compiler defines when
+``__riscv_arch_test`` is available, such as ``__riscv_zawrs``:
+
+``v``
+   Vector implementations (``RTE_RISCV_FEATURE_V``).
+
+``zawrs``
+   ``rte_wait_until_equal_*`` stall the hart with ``wrs.nto``
+   instead of spinning (``RTE_RISCV_FEATURE_ZAWRS``).
+
+Pass the full ISA string to enable them.
+For native builds use ``-Dcpu_instruction_set``::
+
+   meson setup build -Dcpu_instruction_set=rv64gcv_zawrs
+
+For cross builds, set ``cpu`` in the cross-file instead::
+
+   [host_machine]
+   cpu = 'rv64gcv_zawrs'
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8ca8379cc6..4cce0b478a 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -68,6 +68,14 @@ New Features
   and use pointer arithmetic instead of integer casts to enable compiler optimizations.
   See API changes below.
 
+* **Added RISC-V Zawrs support for wait-until-equal helpers.**
+
+  On RISC-V targets built with the Zawrs extension in the ISA string
+  (for example ``-Dcpu_instruction_set=rv64gcv_zawrs``),
+  ``rte_wait_until_equal_*`` and ``RTE_WAIT_UNTIL_MASKED`` now stall the hart
+  with ``wrs.nto`` until the polled address is written instead of spinning
+  on ``pause``.
+
 * **Added API to get CPU socket ID.**
 
   Added the experimental ``rte_cpu_socket_id()`` function
diff --git a/lib/eal/riscv/include/rte_pause.h b/lib/eal/riscv/include/rte_pause.h
index 3f473cd8db..99d7f46711 100644
--- a/lib/eal/riscv/include/rte_pause.h
+++ b/lib/eal/riscv/include/rte_pause.h
@@ -7,6 +7,14 @@
 #ifndef RTE_PAUSE_RISCV_H
 #define RTE_PAUSE_RISCV_H
 
+#include <rte_config.h>
+
+#ifdef RTE_RISCV_FEATURE_ZAWRS
+#define RTE_WAIT_UNTIL_EQUAL_ARCH_DEFINED
+#endif
+
+#include <rte_debug.h>
+
 #include "rte_atomic.h"
 
 #include "generic/rte_pause.h"
@@ -24,6 +32,157 @@ static inline void rte_pause(void)
 	asm volatile(".int 0x0100000F" : : : "memory");
 }
 
+#ifdef RTE_RISCV_FEATURE_ZAWRS
+
+/*
+ * Atomic load from an address, it returns either a sign-extended word or
+ * doubleword and creates a 'reservation set' containing the read memory
+ * location. When someone else writes to the reservation set, it is invalidated,
+ * causing any stalled WRS instructions to resume.
+ *
+ * Address needs to be naturally aligned.
+ */
+#define __RTE_RISCV_LR_32(src, dst, memorder) do {                \
+	if ((memorder) == rte_memory_order_relaxed) {             \
+		asm volatile("lr.w %0, (%1)"                      \
+				: "=r" (dst)                      \
+				: "r" (src)                       \
+				: "memory");                      \
+	} else {                                                  \
+		asm volatile("lr.w.aq %0, (%1)"                   \
+				: "=r" (dst)                      \
+				: "r" (src)                       \
+				: "memory");                      \
+	} } while (0)
+#define __RTE_RISCV_LR_64(src, dst, memorder) do {                \
+	if ((memorder) == rte_memory_order_relaxed) {             \
+		asm volatile("lr.d %0, (%1)"                      \
+				: "=r" (dst)                      \
+				: "r" (src)                       \
+				: "memory");                      \
+	} else {                                                  \
+		asm volatile("lr.d.aq %0, (%1)"                   \
+				: "=r" (dst)                      \
+				: "r" (src)                       \
+				: "memory");                      \
+	} } while (0)
+
+/*
+ * There's not a RISC-V atomic load primitive for halfwords, so cast up to a
+ * _naturally aligned_ word and extract the halfword we want
+ */
+#define __RTE_RISCV_LR_16(src, dst, memorder) do {                      \
+	uint32_t word;                                                  \
+	__RTE_RISCV_LR_32(((uintptr_t)(src) & (~3)), word, (memorder)); \
+	if ((size_t)(src) & 3)                                          \
+		(dst) = (typeof(dst))(word >> 16);                      \
+	else                                                            \
+		(dst) = (typeof(dst))(word & 0xFFFF);                   \
+} while (0)
+
+#define __RTE_RISCV_LR(src, dst, memorder, size) {                \
+	RTE_BUILD_BUG_ON(size != 16 && size != 32 && size != 64); \
+	if (size == 16)                                           \
+		__RTE_RISCV_LR_16(src, dst, memorder);            \
+	else if (size == 32)                                      \
+		__RTE_RISCV_LR_32(src, dst, memorder);            \
+	else if (size == 64)                                      \
+		__RTE_RISCV_LR_64(src, dst, memorder);            \
+}
+
+/*
+ * Wait-on-Reservation-Set extension instruction, it stalls execution until the
+ * reservation set is invalidated or an interrupt is observed.
+ * A loop is likely still needed as it may stop stalling arbitrarily.
+ */
+#define __RTE_RISCV_WRS_NTO() { asm volatile("wrs.nto" : : : "memory"); }
+
+static inline void
+rte_wait_until_equal_16(volatile uint16_t *addr, uint16_t expected,
+		rte_memory_order memorder)
+{
+	uint16_t value;
+
+	RTE_ASSERT(memorder == rte_memory_order_acquire ||
+		memorder == rte_memory_order_relaxed);
+	RTE_ASSERT(((size_t)addr & 1) == 0);
+
+	/* fast path: a plain load is cheaper than taking a reservation */
+	if (rte_atomic_load_explicit((volatile __rte_atomic uint16_t *)addr,
+			memorder) == expected)
+		return;
+
+	__RTE_RISCV_LR_16(addr, value, memorder);
+	while (value != expected) {
+		__RTE_RISCV_WRS_NTO();
+		__RTE_RISCV_LR_16(addr, value, memorder);
+	}
+}
+
+static inline void
+rte_wait_until_equal_32(volatile uint32_t *addr, uint32_t expected,
+		rte_memory_order memorder)
+{
+	uint32_t value;
+
+	RTE_ASSERT(memorder == rte_memory_order_acquire ||
+		memorder == rte_memory_order_relaxed);
+	RTE_ASSERT(((size_t)addr & 3) == 0);
+
+	/* fast path: a plain load is cheaper than taking a reservation */
+	if (rte_atomic_load_explicit((volatile __rte_atomic uint32_t *)addr,
+			memorder) == expected)
+		return;
+
+	__RTE_RISCV_LR_32(addr, value, memorder);
+	while (value != expected) {
+		__RTE_RISCV_WRS_NTO();
+		__RTE_RISCV_LR_32(addr, value, memorder);
+	}
+}
+
+static inline void
+rte_wait_until_equal_64(volatile uint64_t *addr, uint64_t expected,
+		rte_memory_order memorder)
+{
+	uint64_t value;
+
+	RTE_ASSERT(memorder == rte_memory_order_acquire ||
+		memorder == rte_memory_order_relaxed);
+	RTE_ASSERT(((size_t)addr & 7) == 0);
+
+	/* fast path: a plain load is cheaper than taking a reservation */
+	if (rte_atomic_load_explicit((volatile __rte_atomic uint64_t *)addr,
+			memorder) == expected)
+		return;
+
+	__RTE_RISCV_LR_64(addr, value, memorder);
+	while (value != expected) {
+		__RTE_RISCV_WRS_NTO();
+		__RTE_RISCV_LR_64(addr, value, memorder);
+	}
+}
+
+#define RTE_WAIT_UNTIL_MASKED(addr, mask, cond, expected, memorder) do { \
+	RTE_BUILD_BUG_ON(!__builtin_constant_p(memorder));               \
+	RTE_BUILD_BUG_ON(memorder != rte_memory_order_acquire &&         \
+		memorder != rte_memory_order_relaxed);                   \
+	RTE_ASSERT(((size_t)(addr) & (sizeof(*(addr)) - 1)) == 0);       \
+	enum { size = sizeof(*(addr)) << 3 };                            \
+	typeof(*(addr)) expected_value = (expected);                     \
+	typeof(*(addr)) value;                                           \
+	if ((rte_atomic_load_explicit((addr), (memorder)) & (mask))      \
+			cond expected_value)                             \
+		break;                                                   \
+	__RTE_RISCV_LR((addr), value, memorder, size);                   \
+	while (!((value & (mask)) cond expected_value)) {                \
+		__RTE_RISCV_WRS_NTO();                                   \
+		__RTE_RISCV_LR((addr), value, memorder, size);           \
+	}                                                                \
+} while (0)
+
+#endif /* RTE_RISCV_FEATURE_ZAWRS */
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.56.0

