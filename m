Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D8CFA76B
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 10:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE2F9402D4;
	Fri, 21 Nov 2025 11:35:38 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3743D4026F
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:35:37 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id DBB9320C26;
 Fri, 21 Nov 2025 11:35:36 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 21 Nov 2025 11:35:36 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] eal/x86: optimize memcpy of small sizes
Date: Fri, 21 Nov 2025 10:35:35 +0000
Message-ID: <20251121103535.1273457-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120114554.950287-1-mb@smartsharesystems.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Nov 2025 10:35:36.0602 (UTC)
 FILETIME=[92C0E7A0:01DC5AD2]
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

Furthermore, the function for copying less than 16 bytes was replaced with
a smarter implementation using fewer branches and potentially fewer
load/store operations.
This function was also extended to handle copying of up to 16 bytes,
instead of up to 15 bytes. This small extension reduces the code path for
copying two pointers.

These changes provide two benefits:
1. The memory footprint of the copy function is reduced.
Previously there were two instances of the compiled code to copy up to 64
bytes, one in the "aligned" code path, and one in the "generic" code path.
Now there is only one instance, in the "common" code path.
2. The performance for copying up to 64 bytes is improved.
The memcpy performance test shows cache-to-cache copying of up to 32 bytes
now typically only takes 2 cycles (4 cycles for 64 bytes) versus
ca. 6.5 cycles before this patch.

And finally, the missing implementation of rte_mov48() was added.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Updated patch title to reflect that the performance is improved.
* Use the design pattern of two overlapping stores for small copies too.
* Expanded first branch from size < 16 to size <= 16.
* Handle more build time constant copy sizes.
---
 lib/eal/x86/include/rte_memcpy.h | 341 ++++++++++++++++---------------
 1 file changed, 181 insertions(+), 160 deletions(-)

diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
index 46d34b8081..665902ff62 100644
--- a/lib/eal/x86/include/rte_memcpy.h
+++ b/lib/eal/x86/include/rte_memcpy.h
@@ -55,52 +55,6 @@ extern "C" {
 static __rte_always_inline void *
 rte_memcpy(void *dst, const void *src, size_t n);
 
-/**
- * Copy bytes from one location to another,
- * locations should not overlap.
- * Use with n <= 15.
- */
-static __rte_always_inline void *
-rte_mov15_or_less(void *dst, const void *src, size_t n)
-{
-	/**
-	 * Use the following structs to avoid violating C standard
-	 * alignment requirements and to avoid strict aliasing bugs
-	 */
-	struct __rte_packed_begin rte_uint64_alias {
-		uint64_t val;
-	} __rte_packed_end __rte_may_alias;
-	struct __rte_packed_begin rte_uint32_alias {
-		uint32_t val;
-	} __rte_packed_end __rte_may_alias;
-	struct __rte_packed_begin rte_uint16_alias {
-		uint16_t val;
-	} __rte_packed_end __rte_may_alias;
-
-	void *ret = dst;
-	if (n & 8) {
-		((struct rte_uint64_alias *)dst)->val =
-			((const struct rte_uint64_alias *)src)->val;
-		src = (const uint64_t *)src + 1;
-		dst = (uint64_t *)dst + 1;
-	}
-	if (n & 4) {
-		((struct rte_uint32_alias *)dst)->val =
-			((const struct rte_uint32_alias *)src)->val;
-		src = (const uint32_t *)src + 1;
-		dst = (uint32_t *)dst + 1;
-	}
-	if (n & 2) {
-		((struct rte_uint16_alias *)dst)->val =
-			((const struct rte_uint16_alias *)src)->val;
-		src = (const uint16_t *)src + 1;
-		dst = (uint16_t *)dst + 1;
-	}
-	if (n & 1)
-		*(uint8_t *)dst = *(const uint8_t *)src;
-	return ret;
-}
-
 /**
  * Copy 16 bytes from one location to another,
  * locations should not overlap.
@@ -132,6 +86,23 @@ rte_mov32(uint8_t *dst, const uint8_t *src)
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
@@ -172,6 +143,136 @@ rte_mov256(uint8_t *dst, const uint8_t *src)
 	rte_mov128(dst + 1 * 128, src + 1 * 128);
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations should not overlap.
+ * Use with n <= 16.
+ *
+ * Note: Copying uninitialized memory is perfectly acceptable.
+ * Using e.g. memcpy(dst, src, 8) instead of
+ * *(unaligned_uint64_t*) = *(const unaligned_uint64_t *)src
+ * avoids compiler warnings about source data may be uninitialized
+ * [-Wmaybe-uninitialized].
+ *
+ * Note: Using "n & X" generates 3-byte "test" instructions,
+ * instead of "n >= X", which would generate 4-byte "cmp" intructions.
+ */
+static __rte_always_inline void *
+rte_mov16_or_less(void *dst, const void *src, size_t n)
+{
+	/* Faster way when size is known at build time. */
+	if (__rte_constant(n)) {
+		if (n == 2)
+			return memcpy(dst, src, 2);
+		if (n == 4)
+			return memcpy(dst, src, 4);
+		if (n == 6) /* 4 + 2 */
+			return memcpy(dst, src, 6);
+		if (n == 8)
+			return memcpy(dst, src, 8);
+		if (n == 10) /* 8 + 2 */
+			return memcpy(dst, src, 10);
+		if (n == 12) /* 8 + 4 */
+			return memcpy(dst, src, 12);
+		if (n == 16) {
+			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+	}
+
+	if (n & 0x18) { /* n >= 8 */
+		/* copy 8 ~ 16 bytes */
+		memcpy(dst, src, 8);
+		memcpy((uint8_t *)dst - 8 + n, (const uint8_t *)src - 8 + n, 8);
+	} else if (n & 0x4) {
+		/* copy 4 ~ 7 bytes */
+		memcpy(dst, src, 4);
+		memcpy((uint8_t *)dst - 4 + n, (const uint8_t *)src - 4 + n, 4);
+	} else if (n & 0x2) {
+		/* copy 2 ~ 3 bytes */
+		memcpy(dst, src, 2);
+		memcpy((uint8_t *)dst - 2 + n, (const uint8_t *)src - 2 + n, 2);
+	} else if (n & 0x1) {
+		/* copy 1 byte */
+		memcpy(dst, src, 1);
+	}
+	return dst;
+}
+
+/**
+ * Copy bytes from one location to another,
+ * locations should not overlap.
+ * Use with 17 (or 16) < n <= 32.
+ */
+static __rte_always_inline void *
+rte_mov17_to_32(void *dst, const void *src, size_t n)
+{
+	/* Faster way when size is known at build time. */
+	if (__rte_constant(n)) {
+		if (n == 16) {
+			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+		if (n == 18) /* 16 + 2 */
+			return memcpy(dst, src, 18);
+		if (n == 20) /* 16 + 4 */
+			return memcpy(dst, src, 20);
+		if (n == 24) /* 16 + 8 */
+			return memcpy(dst, src, 24);
+		if (n == 32) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+	}
+
+	/* copy 17 (or 16) ~ 32 bytes */
+	rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+	rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
+	return dst;
+}
+
+/**
+ * Copy bytes from one location to another,
+ * locations should not overlap.
+ * Use with 33 (or 32) < n <= 64.
+ */
+static __rte_always_inline void *
+rte_mov33_to_64(void *dst, const void *src, size_t n)
+{
+	/* Faster way when size is known at build time. */
+	if (__rte_constant(n)) {
+		if (n == 32) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+		if (n == 36) /* 32 + 4 */
+			return memcpy(dst, src, 36);
+		if (n == 40) /* 32 + 8 */
+			return memcpy(dst, src, 40);
+		if (n == 48) {
+			rte_mov48((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+		if (n == 64) {
+			rte_mov64((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+	}
+
+	/* copy 33 (or 32) ~ 64 bytes */
+#if (defined __AVX512F__ && defined RTE_MEMCPY_AVX512) || defined RTE_MEMCPY_AVX
+	rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+	rte_mov32((uint8_t *)dst - 32 + n, (const uint8_t *)src - 32 + n);
+#else /* SSE implementation */
+	rte_mov16((uint8_t *)dst + 0 * 16, (const uint8_t *)src + 0 * 16);
+	rte_mov16((uint8_t *)dst + 1 * 16, (const uint8_t *)src + 1 * 16);
+	if (n > 48)
+		rte_mov16((uint8_t *)dst + 2 * 16, (const uint8_t *)src + 2 * 16);
+	rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
+#endif
+	return dst;
+}
+
 #if defined __AVX512F__ && defined RTE_MEMCPY_AVX512
 
 /**
@@ -232,45 +333,21 @@ rte_mov512blocks(uint8_t *dst, const uint8_t *src, size_t n)
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
@@ -381,41 +458,21 @@ rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
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
@@ -573,38 +630,22 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
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
@@ -696,44 +737,16 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 
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
@@ -751,10 +764,18 @@ rte_memcpy_aligned(void *dst, const void *src, size_t n)
 static __rte_always_inline void *
 rte_memcpy(void *dst, const void *src, size_t n)
 {
+	if (n <= 16)
+		return rte_mov16_or_less(dst, src, n);
+	if (n <= 32)
+		return rte_mov17_to_32(dst, src, n);
+	if (n <= 64)
+		return rte_mov33_to_64(dst, src, n);
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

