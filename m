Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86443CF8845
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 11:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 622724026F;
	Thu, 20 Nov 2025 12:46:02 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5492F40262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 12:46:01 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 24989214DB;
 Thu, 20 Nov 2025 12:46:01 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 20 Nov 2025 12:46:00 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>, dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] eal/x86: reduce memcpy code duplication
Date: Thu, 20 Nov 2025 11:45:54 +0000
Message-ID: <20251120114554.950287-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Nov 2025 11:46:00.0815 (UTC)
 FILETIME=[3E2AE7F0:01DC5A13]
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

The implementation for copying up to 64 bytes does not depend on address
alignment with the size of the CPU's vector registers, so the code
handling this was moved from the various implementations to the common
function.

This consolidation also has two minor benefits for the compiled output:
1. The memory footprint of the copy function is reduced.
Previously there were two instances of the compiled code to copy up to 64
bytes, one in the "aligned" code path, and one in the "generic" code path.
Now there is only one instance, in the "common" code path.
2. The performance cost of the alignment test and associated branching is
avoided when copying less than 65 bytes.

Furthermore, the missing implementation of rte_mov48() was added.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/x86/include/rte_memcpy.h | 214 +++++++++++++++----------------
 1 file changed, 100 insertions(+), 114 deletions(-)

diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
index 46d34b8081..88820f50a9 100644
--- a/lib/eal/x86/include/rte_memcpy.h
+++ b/lib/eal/x86/include/rte_memcpy.h
@@ -132,6 +132,23 @@ rte_mov32(uint8_t *dst, const uint8_t *src)
 #endif
 }
 
+/**
+ * Copy 48 bytes from one location to another,
+ * locations should not overlap.
+ */
+static __rte_always_inline void
+rte_mov48(uint8_t *dst, const uint8_t *src)
+{
+#if defined RTE_MEMCPY_AVX
+	rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+	rte_mov32((uint8_t *)dst - 32 + 48, (const uint8_t *)src - 32 + 48);
+#else /* SSE implementation */
+	rte_mov16((uint8_t *)dst + 0 * 16, (const uint8_t *)src + 0 * 16);
+	rte_mov16((uint8_t *)dst + 1 * 16, (const uint8_t *)src + 1 * 16);
+	rte_mov16((uint8_t *)dst + 2 * 16, (const uint8_t *)src + 2 * 16);
+#endif
+}
+
 /**
  * Copy 64 bytes from one location to another,
  * locations should not overlap.
@@ -172,6 +189,38 @@ rte_mov256(uint8_t *dst, const uint8_t *src)
 	rte_mov128(dst + 1 * 128, src + 1 * 128);
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations should not overlap.
+ * Use with 16 <= n <= 32, preferably 16 < n <= 32.
+ */
+static __rte_always_inline void *
+rte_mov16_to_32(void *dst, const void *src, size_t n)
+{
+	rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+	rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
+	return dst;
+}
+
+/**
+ * Copy bytes from one location to another,
+ * locations should not overlap.
+ * Use with 32 <= n <= 64, preferably 32 < n <= 64.
+ */
+static __rte_always_inline void *
+rte_mov32_to_64(void *dst, const void *src, size_t n)
+{
+	rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+#if (defined __AVX512F__ && defined RTE_MEMCPY_AVX512) || defined RTE_MEMCPY_AVX
+	rte_mov32((uint8_t *)dst - 32 + n, (const uint8_t *)src - 32 + n);
+#else /* SSE implementation */
+	if (n > 48)
+		rte_mov16((uint8_t *)dst + 32, (const uint8_t *)src + 32);
+	rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
+#endif
+	return dst;
+}
+
 #if defined __AVX512F__ && defined RTE_MEMCPY_AVX512
 
 /**
@@ -232,45 +281,21 @@ rte_mov512blocks(uint8_t *dst, const uint8_t *src, size_t n)
 	}
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations should not overlap.
+ * Use with n > 64.
+ */
 static __rte_always_inline void *
-rte_memcpy_generic(void *dst, const void *src, size_t n)
+rte_memcpy_generic_more_than_64(void *dst, const void *src, size_t n)
 {
 	void *ret = dst;
 	size_t dstofss;
 	size_t bits;
 
-	/**
-	 * Copy less than 16 bytes
-	 */
-	if (n < 16) {
-		return rte_mov15_or_less(dst, src, n);
-	}
-
 	/**
 	 * Fast way when copy size doesn't exceed 512 bytes
 	 */
-	if (__rte_constant(n) && n == 32) {
-		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
-		return ret;
-	}
-	if (n <= 32) {
-		rte_mov16((uint8_t *)dst, (const uint8_t *)src);
-		if (__rte_constant(n) && n == 16)
-			return ret; /* avoid (harmless) duplicate copy */
-		rte_mov16((uint8_t *)dst - 16 + n,
-				  (const uint8_t *)src - 16 + n);
-		return ret;
-	}
-	if (__rte_constant(n) && n == 64) {
-		rte_mov64((uint8_t *)dst, (const uint8_t *)src);
-		return ret;
-	}
-	if (n <= 64) {
-		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
-		rte_mov32((uint8_t *)dst - 32 + n,
-				  (const uint8_t *)src - 32 + n);
-		return ret;
-	}
 	if (n <= 512) {
 		if (n >= 256) {
 			n -= 256;
@@ -381,41 +406,21 @@ rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
 	}
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations should not overlap.
+ * Use with n > 64.
+ */
 static __rte_always_inline void *
-rte_memcpy_generic(void *dst, const void *src, size_t n)
+rte_memcpy_generic_more_than_64(void *dst, const void *src, size_t n)
 {
 	void *ret = dst;
 	size_t dstofss;
 	size_t bits;
 
-	/**
-	 * Copy less than 16 bytes
-	 */
-	if (n < 16) {
-		return rte_mov15_or_less(dst, src, n);
-	}
-
 	/**
 	 * Fast way when copy size doesn't exceed 256 bytes
 	 */
-	if (__rte_constant(n) && n == 32) {
-		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
-		return ret;
-	}
-	if (n <= 32) {
-		rte_mov16((uint8_t *)dst, (const uint8_t *)src);
-		if (__rte_constant(n) && n == 16)
-			return ret; /* avoid (harmless) duplicate copy */
-		rte_mov16((uint8_t *)dst - 16 + n,
-				(const uint8_t *)src - 16 + n);
-		return ret;
-	}
-	if (n <= 64) {
-		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
-		rte_mov32((uint8_t *)dst - 32 + n,
-				(const uint8_t *)src - 32 + n);
-		return ret;
-	}
 	if (n <= 256) {
 		if (n >= 128) {
 			n -= 128;
@@ -573,38 +578,22 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
     }                                                                 \
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations should not overlap.
+ * Use with n > 64.
+ */
 static __rte_always_inline void *
-rte_memcpy_generic(void *dst, const void *src, size_t n)
+rte_memcpy_generic_more_than_64(void *dst, const void *src, size_t n)
 {
 	__m128i xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8;
 	void *ret = dst;
 	size_t dstofss;
 	size_t srcofs;
 
-	/**
-	 * Copy less than 16 bytes
-	 */
-	if (n < 16) {
-		return rte_mov15_or_less(dst, src, n);
-	}
-
 	/**
 	 * Fast way when copy size doesn't exceed 512 bytes
 	 */
-	if (n <= 32) {
-		rte_mov16((uint8_t *)dst, (const uint8_t *)src);
-		if (__rte_constant(n) && n == 16)
-			return ret; /* avoid (harmless) duplicate copy */
-		rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
-		return ret;
-	}
-	if (n <= 64) {
-		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
-		if (n > 48)
-			rte_mov16((uint8_t *)dst + 32, (const uint8_t *)src + 32);
-		rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
-		return ret;
-	}
 	if (n <= 128) {
 		goto COPY_BLOCK_128_BACK15;
 	}
@@ -696,44 +685,16 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 
 #endif /* __AVX512F__ */
 
+/**
+ * Copy bytes from one vector register size aligned location to another,
+ * locations should not overlap.
+ * Use with n > 64.
+ */
 static __rte_always_inline void *
-rte_memcpy_aligned(void *dst, const void *src, size_t n)
+rte_memcpy_aligned_more_than_64(void *dst, const void *src, size_t n)
 {
 	void *ret = dst;
 
-	/* Copy size < 16 bytes */
-	if (n < 16) {
-		return rte_mov15_or_less(dst, src, n);
-	}
-
-	/* Copy 16 <= size <= 32 bytes */
-	if (__rte_constant(n) && n == 32) {
-		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
-		return ret;
-	}
-	if (n <= 32) {
-		rte_mov16((uint8_t *)dst, (const uint8_t *)src);
-		if (__rte_constant(n) && n == 16)
-			return ret; /* avoid (harmless) duplicate copy */
-		rte_mov16((uint8_t *)dst - 16 + n,
-				(const uint8_t *)src - 16 + n);
-
-		return ret;
-	}
-
-	/* Copy 32 < size <= 64 bytes */
-	if (__rte_constant(n) && n == 64) {
-		rte_mov64((uint8_t *)dst, (const uint8_t *)src);
-		return ret;
-	}
-	if (n <= 64) {
-		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
-		rte_mov32((uint8_t *)dst - 32 + n,
-				(const uint8_t *)src - 32 + n);
-
-		return ret;
-	}
-
 	/* Copy 64 bytes blocks */
 	for (; n > 64; n -= 64) {
 		rte_mov64((uint8_t *)dst, (const uint8_t *)src);
@@ -751,10 +712,35 @@ rte_memcpy_aligned(void *dst, const void *src, size_t n)
 static __rte_always_inline void *
 rte_memcpy(void *dst, const void *src, size_t n)
 {
+	if (__rte_constant(n) && n == 16) {
+		rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+		return dst;
+	}
+	if (__rte_constant(n) && n == 32) {
+		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+		return dst;
+	}
+	if (__rte_constant(n) && n == 48) {
+		rte_mov48((uint8_t *)dst, (const uint8_t *)src);
+		return dst;
+	}
+	if (__rte_constant(n) && n == 64) {
+		rte_mov64((uint8_t *)dst, (const uint8_t *)src);
+		return dst;
+	}
+
+	if (n < 16)
+		return rte_mov15_or_less(dst, src, n);
+	if (n <= 32)
+		return rte_mov16_to_32(dst, src, n);
+	if (n <= 64)
+		return rte_mov32_to_64(dst, src, n);
+
+	/* Implementation for size > 64 bytes depends on alignment with vector register size. */
 	if (!(((uintptr_t)dst | (uintptr_t)src) & ALIGNMENT_MASK))
-		return rte_memcpy_aligned(dst, src, n);
+		return rte_memcpy_aligned_more_than_64(dst, src, n);
 	else
-		return rte_memcpy_generic(dst, src, n);
+		return rte_memcpy_generic_more_than_64(dst, src, n);
 }
 
 #undef ALIGNMENT_MASK
-- 
2.43.0

