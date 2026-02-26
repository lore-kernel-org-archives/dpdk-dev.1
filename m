Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590D7FC591F
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 10:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C66840677;
	Thu, 26 Feb 2026 11:16:48 +0100 (CET)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [207.46.229.174])
 by mails.dpdk.org (Postfix) with ESMTP id 08A05400D6
 for <dev@dpdk.org>; Thu, 26 Feb 2026 07:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=whu.edu.cn; s=dkim; h=Received:Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=R/FoF
 v8B/tY6bt/b9Vc480WmonRdyvEcQnckbhQDXck=; b=gSsZyUGxhkVxv1ISreKTu
 5+mF5RcUwtZy5yPMy0QhJPFxNIgAKkHxCbvibR1SjnJ4fLylVJ0/nGVklw7fADr7
 Lq1ncLMcoao02KRuisrgBfKbAPABsyPAUhzShsx83lFzEbxhVHOiTgst1bWp91P0
 WY54vRM092y5La5OUv+19g=
Received: from whu.edu.cn (unknown [10.1.14.9])
 by app1 (Coremail) with SMTP id Bg4BCgDH1jAN7Z9p9Y34AQ--.49274S2;
 Thu, 26 Feb 2026 14:49:49 +0800 (CST)
Received: from localhost.localdomain (unknown [210.73.43.101])
 by mtasvr (Coremail) with SMTP id _____wCnNdEH7Z9pC_wGAA--.8447S2;
 Thu, 26 Feb 2026 14:49:48 +0800 (CST)
From: P1erreCashon <2022302111412@whu.edu.cn>
To: Stanislaw Kardach <stanislaw.kardach@gmail.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, P1erreCashon <2022302111412@whu.edu.cn>,
 gong-flying <gongxiaofei24@iscas.ac.cn>
Subject: [PATCH] hash: add riscv vector support for 16-byte key comparison
Date: Thu, 26 Feb 2026 14:49:38 +0800
Message-ID: <20260226064939.2362323-1-2022302111412@whu.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Bg4BCgDH1jAN7Z9p9Y34AQ--.49274S2
Authentication-Results: app1; spf=neutral smtp.mail=2022302111412@whu. edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw13uF47Wr17tw4rCw1Utrb_yoWxGr1UpF
 WDWr15Xa1DXF1ak39Ikr1qkwn8Ca1fCF1qy3y3K39rAanxury7AF48Ka4ruFWaq34UZr17
 CFs7Was3Gr15XFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
 cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
 v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
 x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8x
 CEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0U
 Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GF4lOx8S6xCaFVCjc4AY6r
 1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE
 74AGY7Cv6cx26r4xMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
 4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
 rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8Jw
 CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
 z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUjnYwUUUUU
X-CM-SenderInfo: qsqsjjyqsriiqursq4lkxovvfxof0/
X-Mailman-Approved-At: Thu, 26 Feb 2026 11:16:38 +0100
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

Add RISC-V Vector (RVV) optimized implementation for
rte_hash_k16_cmp_eq() to accelerate 16-byte key comparison
in hash lookup fast path.

The implementation uses RVV vector load and compare
instructions to detect mismatched bytes and reduces
comparison latency on RVV-capable systems.

This patch is co-developed with gong-flying.

Signed-off-by: gong-flying <gongxiaofei24@iscas.ac.cn>
Signed-off-by: P1erreCashon <2022302111412@whu.edu.cn>
---
 config/riscv/meson.build   | 18 +++++++-
 lib/hash/rte_cmp_riscv.h   | 93 ++++++++++++++++++++++++++++++++++++++
 lib/hash/rte_cuckoo_hash.c |  2 +-
 lib/hash/rte_cuckoo_hash.h |  6 ++-
 4 files changed, 116 insertions(+), 3 deletions(-)
 create mode 100644 lib/hash/rte_cmp_riscv.h

diff --git a/config/riscv/meson.build b/config/riscv/meson.build
index 07d7d9da23..a844faaa7b 100644
--- a/config/riscv/meson.build
+++ b/config/riscv/meson.build
@@ -113,12 +113,28 @@ dpdk_flags = flags_common + vendor_config['flags'] + arch_config.get('flags', []
 
 # apply supported machine args
 machine_args = [] # Clear previous machine args
-foreach flag: arch_config['machine_args']
+
+# detect best ISA
+if cc.has_argument('-march=rv64gc_zve64x')
+    machine_args += ['-march=rv64gc_zve64x']
+    dpdk_conf.set('RTE_ARCH_RISCV_VEC', 1)
+    message('Using rv64gc_zve64x')
+else
+    machine_args += ['-march=rv64gc']
+    message('Using rv64gc (fallback)')
+endif
+
+# apply extra tuning flags (like -mtune)
+foreach flag: arch_config.get('machine_args', [])
+    if flag.startswith('-march')
+        continue
+    endif
     if cc.has_argument(flag)
         machine_args += flag
     endif
 endforeach
 
+
 # apply flags
 foreach flag: dpdk_flags
     if flag.length() > 0
diff --git a/lib/hash/rte_cmp_riscv.h b/lib/hash/rte_cmp_riscv.h
new file mode 100644
index 0000000000..7881d17e05
--- /dev/null
+++ b/lib/hash/rte_cmp_riscv.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2015 Intel Corporation
+ */
+
+#include <riscv_vector.h>
+
+/* Functions to compare multiple of 16 byte keys (up to 128 bytes) */
+static inline int
+rte_hash_k16_cmp_eq(const void *key1, const void *key2, size_t key_len __rte_unused)
+{
+	const uint8_t *p1 = (const uint8_t *)key1;
+	const uint8_t *p2 = (const uint8_t *)key2;
+	size_t offset = 0;
+
+	while (offset < 16) {
+		size_t vl = __riscv_vsetvl_e8m1(16 - offset);
+
+		vuint8m1_t v1 = __riscv_vle8_v_u8m1(p1 + offset, vl);
+		vuint8m1_t v2 = __riscv_vle8_v_u8m1(p2 + offset, vl);
+
+		/* find != bytes */
+		vbool8_t neq = __riscv_vmsne_vv_u8m1_b8(v1, v2, vl);
+
+		/* if any byte mismatches, return not equal */
+		if (__riscv_vfirst_m_b8(neq, vl) >= 0)
+			return 1;
+
+		offset += vl;
+	}
+
+	/* all bytes equal */
+	return 0;
+}
+
+static inline int
+rte_hash_k32_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k16_cmp_eq((const char *) key1 + 16,
+				(const char *) key2 + 16, key_len);
+}
+
+static inline int
+rte_hash_k48_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k16_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k16_cmp_eq((const char *) key1 + 16,
+				(const char *) key2 + 16, key_len) ||
+		rte_hash_k16_cmp_eq((const char *) key1 + 32,
+				(const char *) key2 + 32, key_len);
+}
+
+static inline int
+rte_hash_k64_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k32_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k32_cmp_eq((const char *) key1 + 32,
+				(const char *) key2 + 32, key_len);
+}
+
+static inline int
+rte_hash_k80_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k16_cmp_eq((const char *) key1 + 64,
+				(const char *) key2 + 64, key_len);
+}
+
+static inline int
+rte_hash_k96_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k32_cmp_eq((const char *) key1 + 64,
+				(const char *) key2 + 64, key_len);
+}
+
+static inline int
+rte_hash_k112_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k32_cmp_eq((const char *) key1 + 64,
+				(const char *) key2 + 64, key_len) ||
+		rte_hash_k16_cmp_eq((const char *) key1 + 96,
+				(const char *) key2 + 96, key_len);
+}
+
+static inline int
+rte_hash_k128_cmp_eq(const void *key1, const void *key2, size_t key_len)
+{
+	return rte_hash_k64_cmp_eq(key1, key2, key_len) ||
+		rte_hash_k64_cmp_eq((const char *) key1 + 64,
+				(const char *) key2 + 64, key_len);
+}
diff --git a/lib/hash/rte_cuckoo_hash.c b/lib/hash/rte_cuckoo_hash.c
index 9cf94645f6..159001f2fa 100644
--- a/lib/hash/rte_cuckoo_hash.c
+++ b/lib/hash/rte_cuckoo_hash.c
@@ -357,7 +357,7 @@ rte_hash_create(const struct rte_hash_parameters *params)
  * If x86 architecture is used, select appropriate compare function,
  * which may use x86 intrinsics, otherwise use memcmp
  */
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64) || defined(RTE_ARCH_RISCV_VEC)
 	/* Select function to compare keys */
 	switch (params->key_len) {
 	case 16:
diff --git a/lib/hash/rte_cuckoo_hash.h b/lib/hash/rte_cuckoo_hash.h
index a528f1d1a0..b693abcb89 100644
--- a/lib/hash/rte_cuckoo_hash.h
+++ b/lib/hash/rte_cuckoo_hash.h
@@ -21,6 +21,10 @@
 #include "rte_cmp_arm64.h"
 #endif
 
+#if defined(RTE_ARCH_RISCV_VEC)
+#include "rte_cmp_riscv.h"
+#endif
+
 /* Macro to enable/disable run-time checking of function parameters */
 #if defined(RTE_LIBRTE_HASH_DEBUG)
 #define RETURN_IF_TRUE(cond, retval) do { \
@@ -34,7 +38,7 @@
 #include <rte_hash_crc.h>
 #include <rte_jhash.h>
 
-#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64)
+#if defined(RTE_ARCH_X86) || defined(RTE_ARCH_ARM64) || defined(RTE_ARCH_RISCV_VEC)
 /*
  * All different options to select a key compare function,
  * based on the key size and custom function.
-- 
2.43.0

