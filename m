Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A47CCCA470
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 06:32:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B67214060F;
	Thu,  9 Oct 2025 08:32:09 +0200 (CEST)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by mails.dpdk.org (Postfix) with ESMTP id 9A38B40277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 08:32:07 +0200 (CEST)
Received: from ar (unknown [42.58.228.253])
 by APP-01 (Coremail) with SMTP id qwCowACX8KLjVudoos4xDQ--.28421S2;
 Thu, 09 Oct 2025 14:32:04 +0800 (CST)
From: Sun Yuechi <sunyuechi@iscas.ac.cn>
To: dev@dpdk.org
Cc: Sun Yuechi <sunyuechi@iscas.ac.cn>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] eal/riscv: optimize memcpy for small copies under 64 bytes
Date: Thu,  9 Oct 2025 14:30:30 +0800
Message-ID: <20251009063030.2776794-1-sunyuechi@iscas.ac.cn>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowACX8KLjVudoos4xDQ--.28421S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw13WryDAw1DCr4xuw13XFb_yoW7Xry8pF
 nxGr4YgF1kJ3WfXFyfGry7Xw43Xwn3Zr15GFykur4kAFs7JryUXa9Fgr4fAF1fW3yIyrWa
 ga95uay5GayDu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUym14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
 0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
 2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
 W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ7UUUUU=
X-Originating-IP: [42.58.228.253]
X-CM-SenderInfo: 5vxq53phfkxq5lvft2wodfhubq/1tbiCRAKAmjnOBdmOAABsu
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

Improve rte_memcpy implementation on RISC-V platform for sizes under
64 bytes, based on the ARM implementation.

Enhanced handling for cases smaller than 64 bytes shows very significant
performance benefits, while the impact is minimal after 64 bytes.

This optimization is disabled by default as a conservative measure,
since future glibc versions may include similar improvements that
could conflict with this implementation.

Use RTE_ARCH_RISCV_MEMCPY to enable this optimization.

Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
---
 config/riscv/meson.build           |   5 ++
 lib/eal/riscv/include/rte_memcpy.h | 122 +++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index f93ea3e145..73fd0ab4da 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -20,6 +20,11 @@ dpdk_conf.set('RTE_FORCE_INTRINSICS', 1)
 
 # common flags to all riscv builds, with lowest priority
 flags_common = [
+    # Accelerate rte_memcpy for copies smaller than 64 bytes. Be sure to run
+    # the unit test (memcpy_perf_autotest) to verify performance improvements.
+    # Refer to notes in source file (lib/eal/riscv/include/rte_memcpy.h) for
+    # more details.
+    ['RTE_ARCH_RISCV_MEMCPY', false],
     ['RTE_ARCH_RISCV', true],
     ['RTE_CACHE_LINE_SIZE', 64],
     # Manually set wall time clock frequency for the target. If 0, then it is
diff --git a/lib/eal/riscv/include/rte_memcpy.h b/lib/eal/riscv/include/rte_memcpy.h
index d8a942c5d2..ae6e79e2fc 100644
--- a/lib/eal/riscv/include/rte_memcpy.h
+++ b/lib/eal/riscv/include/rte_memcpy.h
@@ -2,6 +2,7 @@
  * Copyright(c) 2022 StarFive
  * Copyright(c) 2022 SiFive
  * Copyright(c) 2022 Semihalf
+ * Copyright(c) 2025 ISCAS
  */
 
 #ifndef RTE_MEMCPY_RISCV_H
@@ -14,6 +15,125 @@
 
 #include "generic/rte_memcpy.h"
 
+#ifdef RTE_ARCH_RISCV_MEMCPY
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * This implementation is improved from eal/arm/include/rte_memcpy_64.h,
+ * targeting only cases of < 64 bytes.
+ * Currently shows significant performance improvement over various glibc versions,
+ * but is disabled by default due to uncertainty about potential performance
+ * degradation in future versions.
+ * You can use memcpy_perf_autotest to test the performance.
+ */
+
+static __rte_always_inline
+void rte_mov16(uint8_t *dst, const uint8_t *src)
+{
+	__uint128_t *dst128 = (__uint128_t *)dst;
+	const __uint128_t *src128 = (const __uint128_t *)src;
+	*dst128 = *src128;
+}
+
+static __rte_always_inline
+void rte_mov32(uint8_t *dst, const uint8_t *src)
+{
+	__uint128_t *dst128 = (__uint128_t *)dst;
+	const __uint128_t *src128 = (const __uint128_t *)src;
+	const __uint128_t x0 = src128[0], x1 = src128[1];
+	dst128[0] = x0;
+	dst128[1] = x1;
+}
+
+static __rte_always_inline
+void rte_mov48(uint8_t *dst, const uint8_t *src)
+{
+	__uint128_t *dst128 = (__uint128_t *)dst;
+	const __uint128_t *src128 = (const __uint128_t *)src;
+	const __uint128_t x0 = src128[0], x1 = src128[1], x2 = src128[2];
+	dst128[0] = x0;
+	dst128[1] = x1;
+	dst128[2] = x2;
+}
+
+static __rte_always_inline void
+rte_mov64(uint8_t *dst, const uint8_t *src)
+{
+	memcpy(dst, src, 64);
+}
+
+static __rte_always_inline void
+rte_mov128(uint8_t *dst, const uint8_t *src)
+{
+	memcpy(dst, src, 128);
+}
+
+static __rte_always_inline void
+rte_mov256(uint8_t *dst, const uint8_t *src)
+{
+	memcpy(dst, src, 256);
+}
+
+static __rte_always_inline void
+rte_memcpy_lt16(uint8_t *dst, const uint8_t *src, size_t n)
+{
+	if (n & 0x08) {
+		/* copy 8 ~ 15 bytes */
+		*(uint64_t *)dst = *(const uint64_t *)src;
+		*(uint64_t *)(dst - 8 + n) = *(const uint64_t *)(src - 8 + n);
+	} else if (n & 0x04) {
+		/* copy 4 ~ 7 bytes */
+		*(uint32_t *)dst = *(const uint32_t *)src;
+		*(uint32_t *)(dst - 4 + n) = *(const uint32_t *)(src - 4 + n);
+	} else if (n & 0x02) {
+		/* copy 2 ~ 3 bytes */
+		*(uint16_t *)dst = *(const uint16_t *)src;
+		*(uint16_t *)(dst - 2 + n) = *(const uint16_t *)(src - 2 + n);
+	} else if (n & 0x01) {
+		/* copy 1 byte */
+		*dst = *src;
+	}
+}
+
+static __rte_always_inline void
+rte_memcpy_ge16_lt64(uint8_t *dst, const uint8_t *src, size_t n)
+{
+	if (n == 16) {
+		rte_mov16(dst, src);
+	} else if (n <= 32) {
+		rte_mov16(dst, src);
+		rte_mov16(dst - 16 + n, src - 16 + n);
+	} else if (n <= 48) {
+		rte_mov32(dst, src);
+		rte_mov16(dst - 16 + n, src - 16 + n);
+	} else {
+		rte_mov48(dst, src);
+		rte_mov16(dst - 16 + n, src - 16 + n);
+	}
+}
+
+static __rte_always_inline void *
+rte_memcpy(void *dst, const void *src, size_t n)
+{
+	if (n >= 64)
+		return memcpy(dst, src, n);
+	if (n < 16) {
+		rte_memcpy_lt16((uint8_t *)dst, (const uint8_t *)src, n);
+		return dst;
+	}
+	rte_memcpy_ge16_lt64((uint8_t *)dst, (const uint8_t *)src, n);
+	return dst;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#else /* RTE_ARCH_RISCV_MEMCPY */
+
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -60,4 +180,6 @@ rte_mov256(uint8_t *dst, const uint8_t *src)
 }
 #endif
 
+#endif /* RTE_ARCH_RISCV_MEMCPY */
+
 #endif /* RTE_MEMCPY_RISCV_H */
-- 
2.51.0

