Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6438C9EC7C
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 12:03:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7279440A6C;
	Mon, 12 Jan 2026 13:03:43 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 55FC440288
 for <dev@dpdk.org>; Mon, 12 Jan 2026 13:03:42 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C1C2F206E5;
 Mon, 12 Jan 2026 13:03:41 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 12 Jan 2026 13:03:39 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v6] eal/x86: optimize memcpy of small sizes
Date: Mon, 12 Jan 2026 12:03:37 +0000
Message-ID: <20260112120337.277331-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120114554.950287-1-mb@smartsharesystems.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Jan 2026 12:03:39.0344 (UTC)
 FILETIME=[7CFE5D00:01DC83BB]
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
now only takes 2 cycles (5 cycles for 64 bytes) versus ca. 6.5 cycles
before this patch.

And finally, the missing implementation of rte_mov48() was added.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v6:
* Went back to using rte_uintN_alias structures for copying instead of
  using memcpy(). They were there for a reason.
  (Inspired by the discussion about optimizing the checksum function.)
* Removed note about copying uninitialized data.
* Added __rte_restrict to source and destination addresses.
  Updated function descriptions from "should" to "must" not overlap.
* Changed rte_mov48() AVX implementation to copy 32+16 bytes instead of
  copying 32 + 32 overlapping bytes. (Konstantin)
* Ignoring "-Wstringop-overflow" is not needed, so it was removed.
v5:
* Reverted v4: Replace SSE2 _mm_loadu_si128() with SSE3 _mm_lddqu_si128().
  It was slower.
* Improved some comments. (Konstantin Ananyev)
* Moved the size range 17..32 inside the size <= 64 branch, so when
  building for SSE, the generated code can start copying the first
  16 bytes before comparing if the size is greater than 32 or not.
* Just require RTE_MEMCPY_AVX for using rte_mov32() in rte_mov33_to_64().
v4:
* Replace SSE2 _mm_loadu_si128() with SSE3 _mm_lddqu_si128().
v3:
* Fixed typo in comment.
v2:
* Updated patch title to reflect that the performance is improved.
* Use the design pattern of two overlapping stores for small copies too.
* Expanded first branch from size < 16 to size <= 16.
* Handle more build time constant copy sizes.
---
 lib/eal/x86/include/rte_memcpy.h | 527 ++++++++++++++++++++-----------
 1 file changed, 349 insertions(+), 178 deletions(-)

diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
index 46d34b8081..e429865d21 100644
--- a/lib/eal/x86/include/rte_memcpy.h
+++ b/lib/eal/x86/include/rte_memcpy.h
@@ -22,11 +22,6 @@
 extern "C" {
 #endif
 
-#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wstringop-overflow"
-#endif
-
 /*
  * GCC older than version 11 doesn't compile AVX properly, so use SSE instead.
  * There are no problems with AVX2.
@@ -40,9 +35,6 @@ extern "C" {
 /**
  * Copy bytes from one location to another. The locations must not overlap.
  *
- * @note This is implemented as a macro, so it's address should not be taken
- * and care is needed as parameter expressions may be evaluated multiple times.
- *
  * @param dst
  *   Pointer to the destination of the data.
  * @param src
@@ -53,60 +45,78 @@ extern "C" {
  *   Pointer to the destination data.
  */
 static __rte_always_inline void *
-rte_memcpy(void *dst, const void *src, size_t n);
+rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n);
 
 /**
- * Copy bytes from one location to another,
- * locations should not overlap.
- * Use with n <= 15.
+ * Copy 1 byte from one location to another,
+ * locations must not overlap.
  */
-static __rte_always_inline void *
-rte_mov15_or_less(void *dst, const void *src, size_t n)
+static __rte_always_inline void
+rte_mov1(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
+{
+	*dst = *src;
+}
+
+/**
+ * Copy 2 bytes from one location to another,
+ * locations must not overlap.
+ */
+static __rte_always_inline void
+rte_mov2(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
 {
 	/**
-	 * Use the following structs to avoid violating C standard
+	 * Use the following struct to avoid violating C standard
 	 * alignment requirements and to avoid strict aliasing bugs
 	 */
-	struct __rte_packed_begin rte_uint64_alias {
-		uint64_t val;
+	struct __rte_packed_begin rte_uint16_alias {
+		uint16_t val;
 	} __rte_packed_end __rte_may_alias;
+
+	((struct rte_uint16_alias *)dst)->val = ((const struct rte_uint16_alias *)src)->val;
+}
+
+/**
+ * Copy 4 bytes from one location to another,
+ * locations must not overlap.
+ */
+static __rte_always_inline void
+rte_mov4(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
+{
+	/**
+	 * Use the following struct to avoid violating C standard
+	 * alignment requirements and to avoid strict aliasing bugs
+	 */
 	struct __rte_packed_begin rte_uint32_alias {
 		uint32_t val;
 	} __rte_packed_end __rte_may_alias;
-	struct __rte_packed_begin rte_uint16_alias {
-		uint16_t val;
+
+	((struct rte_uint32_alias *)dst)->val = ((const struct rte_uint32_alias *)src)->val;
+}
+
+/**
+ * Copy 8 bytes from one location to another,
+ * locations must not overlap.
+ */
+static __rte_always_inline void
+rte_mov8(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
+{
+	/**
+	 * Use the following struct to avoid violating C standard
+	 * alignment requirements and to avoid strict aliasing bugs
+	 */
+	struct __rte_packed_begin rte_uint64_alias {
+		uint64_t val;
 	} __rte_packed_end __rte_may_alias;
 
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
+	((struct rte_uint64_alias *)dst)->val = ((const struct rte_uint64_alias *)src)->val;
 }
 
 /**
  * Copy 16 bytes from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  */
 static __rte_always_inline void
-rte_mov16(uint8_t *dst, const uint8_t *src)
+rte_mov16(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
 {
 	__m128i xmm0;
 
@@ -116,10 +126,10 @@ rte_mov16(uint8_t *dst, const uint8_t *src)
 
 /**
  * Copy 32 bytes from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  */
 static __rte_always_inline void
-rte_mov32(uint8_t *dst, const uint8_t *src)
+rte_mov32(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
 {
 #if defined RTE_MEMCPY_AVX
 	__m256i ymm0;
@@ -132,12 +142,29 @@ rte_mov32(uint8_t *dst, const uint8_t *src)
 #endif
 }
 
+/**
+ * Copy 48 bytes from one location to another,
+ * locations must not overlap.
+ */
+static __rte_always_inline void
+rte_mov48(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
+{
+#if defined RTE_MEMCPY_AVX
+	rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+	rte_mov16((uint8_t *)dst + 32, (const uint8_t *)src + 32);
+#else /* SSE implementation */
+	rte_mov16((uint8_t *)dst + 0 * 16, (const uint8_t *)src + 0 * 16);
+	rte_mov16((uint8_t *)dst + 1 * 16, (const uint8_t *)src + 1 * 16);
+	rte_mov16((uint8_t *)dst + 2 * 16, (const uint8_t *)src + 2 * 16);
+#endif
+}
+
 /**
  * Copy 64 bytes from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  */
 static __rte_always_inline void
-rte_mov64(uint8_t *dst, const uint8_t *src)
+rte_mov64(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
 {
 #if defined __AVX512F__ && defined RTE_MEMCPY_AVX512
 	__m512i zmm0;
@@ -152,10 +179,10 @@ rte_mov64(uint8_t *dst, const uint8_t *src)
 
 /**
  * Copy 128 bytes from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  */
 static __rte_always_inline void
-rte_mov128(uint8_t *dst, const uint8_t *src)
+rte_mov128(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
 {
 	rte_mov64(dst + 0 * 64, src + 0 * 64);
 	rte_mov64(dst + 1 * 64, src + 1 * 64);
@@ -163,15 +190,235 @@ rte_mov128(uint8_t *dst, const uint8_t *src)
 
 /**
  * Copy 256 bytes from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  */
 static __rte_always_inline void
-rte_mov256(uint8_t *dst, const uint8_t *src)
+rte_mov256(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
 {
 	rte_mov128(dst + 0 * 128, src + 0 * 128);
 	rte_mov128(dst + 1 * 128, src + 1 * 128);
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations must not overlap.
+ * Use with n <= 16.
+ */
+static __rte_always_inline void *
+rte_mov16_or_less(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
+{
+	/*
+	 * Faster way when size is known at build time.
+	 * Sizes requiring three copy operations are not handled here,
+	 * but proceed to the method using two overlapping copy operations.
+	 */
+	if (__rte_constant(n)) {
+		if (n == 2) {
+			rte_mov2((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+		if (n == 3) {
+			rte_mov2((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov1((uint8_t *)dst + 2, (const uint8_t *)src + 2);
+			return dst;
+		}
+		if (n == 4) {
+			rte_mov4((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+		if (n == 5) {
+			rte_mov4((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov1((uint8_t *)dst + 4, (const uint8_t *)src + 4);
+			return dst;
+		}
+		if (n == 6) {
+			rte_mov4((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov2((uint8_t *)dst + 4, (const uint8_t *)src + 4);
+			return dst;
+		}
+		if (n == 8) {
+			rte_mov8((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+		if (n == 9) {
+			rte_mov8((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov1((uint8_t *)dst + 8, (const uint8_t *)src + 8);
+			return dst;
+		}
+		if (n == 10) {
+			rte_mov8((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov2((uint8_t *)dst + 8, (const uint8_t *)src + 8);
+			return dst;
+		}
+		if (n == 12) {
+			rte_mov8((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov4((uint8_t *)dst + 8, (const uint8_t *)src + 8);
+			return dst;
+		}
+		if (n == 16) {
+			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+	}
+
+	/*
+	 * Note: Using "n & X" generates 3-byte "test" instructions,
+	 * instead of "n >= X", which would generate 4-byte "cmp" instructions.
+	 */
+	if (n & 0x18) { /* n >= 8, including n == 0x10, hence n & 0x18. */
+		/* Copy 8 ~ 16 bytes. */
+		rte_mov8((uint8_t *)dst, (const uint8_t *)src);
+		rte_mov8((uint8_t *)dst - 8 + n, (const uint8_t *)src - 8 + n);
+	} else if (n & 0x4) {
+		/* Copy 4 ~ 7 bytes. */
+		rte_mov4((uint8_t *)dst, (const uint8_t *)src);
+		rte_mov4((uint8_t *)dst - 4 + n, (const uint8_t *)src - 4 + n);
+	} else if (n & 0x2) {
+		/* Copy 2 ~ 3 bytes. */
+		rte_mov2((uint8_t *)dst, (const uint8_t *)src);
+		rte_mov2((uint8_t *)dst - 2 + n, (const uint8_t *)src - 2 + n);
+	} else if (n & 0x1) {
+		/* Copy 1 byte. */
+		rte_mov1((uint8_t *)dst, (const uint8_t *)src);
+	}
+	return dst;
+}
+
+/**
+ * Copy bytes from one location to another,
+ * locations must not overlap.
+ * Use with 17 (or 16) < n <= 32.
+ */
+static __rte_always_inline void *
+rte_mov17_to_32(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
+{
+	/*
+	 * Faster way when size is known at build time.
+	 * Sizes requiring three copy operations are not handled here,
+	 * but proceed to the method using two overlapping copy operations.
+	 */
+	if (__rte_constant(n)) {
+		if (n == 16) {
+			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov1((uint8_t *)dst + 16, (const uint8_t *)src + 16);
+			return dst;
+		}
+		if (n == 17) {
+			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov1((uint8_t *)dst + 16, (const uint8_t *)src + 16);
+			return dst;
+		}
+		if (n == 18) {
+			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov2((uint8_t *)dst + 16, (const uint8_t *)src + 16);
+			return dst;
+		}
+		if (n == 20) {
+			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov4((uint8_t *)dst + 16, (const uint8_t *)src + 16);
+			return dst;
+		}
+		if (n == 24) {
+			rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov8((uint8_t *)dst + 16, (const uint8_t *)src + 16);
+			return dst;
+		}
+		if (n == 32) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+	}
+
+	/* Copy 17 (or 16) ~ 32 bytes. */
+	rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+	rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
+	return dst;
+}
+
+/**
+ * Copy bytes from one location to another,
+ * locations must not overlap.
+ * Use with 33 (or 32) < n <= 64.
+ */
+static __rte_always_inline void *
+rte_mov33_to_64(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
+{
+	/*
+	 * Faster way when size is known at build time.
+	 * Sizes requiring more copy operations are not handled here,
+	 * but proceed to the method using overlapping copy operations.
+	 */
+	if (__rte_constant(n)) {
+		if (n == 32) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+		if (n == 33) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov1((uint8_t *)dst + 32, (const uint8_t *)src + 32);
+			return dst;
+		}
+		if (n == 34) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov2((uint8_t *)dst + 32, (const uint8_t *)src + 32);
+			return dst;
+		}
+		if (n == 36) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov4((uint8_t *)dst + 32, (const uint8_t *)src + 32);
+			return dst;
+		}
+		if (n == 40) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov8((uint8_t *)dst + 32, (const uint8_t *)src + 32);
+			return dst;
+		}
+		if (n == 48) {
+			rte_mov48((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+#if !defined RTE_MEMCPY_AVX /* SSE specific implementation */
+		if (n == 49) {
+			rte_mov48((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov1((uint8_t *)dst + 48, (const uint8_t *)src + 48);
+			return dst;
+		}
+		if (n == 50) {
+			rte_mov48((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov2((uint8_t *)dst + 48, (const uint8_t *)src + 48);
+			return dst;
+		}
+		if (n == 52) {
+			rte_mov48((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov4((uint8_t *)dst + 48, (const uint8_t *)src + 48);
+			return dst;
+		}
+		if (n == 56) {
+			rte_mov48((uint8_t *)dst, (const uint8_t *)src);
+			rte_mov8((uint8_t *)dst + 48, (const uint8_t *)src + 48);
+			return dst;
+		}
+#endif
+		if (n == 64) {
+			rte_mov64((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+	}
+
+	/* Copy 33 (or 32) ~ 64 bytes. */
+#if defined RTE_MEMCPY_AVX
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
@@ -182,10 +429,10 @@ rte_mov256(uint8_t *dst, const uint8_t *src)
 
 /**
  * Copy 128-byte blocks from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  */
 static __rte_always_inline void
-rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
+rte_mov128blocks(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src, size_t n)
 {
 	__m512i zmm0, zmm1;
 
@@ -202,10 +449,10 @@ rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
 
 /**
  * Copy 512-byte blocks from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  */
 static inline void
-rte_mov512blocks(uint8_t *dst, const uint8_t *src, size_t n)
+rte_mov512blocks(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src, size_t n)
 {
 	__m512i zmm0, zmm1, zmm2, zmm3, zmm4, zmm5, zmm6, zmm7;
 
@@ -232,45 +479,22 @@ rte_mov512blocks(uint8_t *dst, const uint8_t *src, size_t n)
 	}
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations must not overlap.
+ * Use with n > 64.
+ */
 static __rte_always_inline void *
-rte_memcpy_generic(void *dst, const void *src, size_t n)
+rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_restrict src,
+		size_t n)
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
@@ -351,10 +575,10 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 
 /**
  * Copy 128-byte blocks from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  */
 static __rte_always_inline void
-rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
+rte_mov128blocks(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src, size_t n)
 {
 	__m256i ymm0, ymm1, ymm2, ymm3;
 
@@ -381,41 +605,22 @@ rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
 	}
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations must not overlap.
+ * Use with n > 64.
+ */
 static __rte_always_inline void *
-rte_memcpy_generic(void *dst, const void *src, size_t n)
+rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_restrict src,
+		size_t n)
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
@@ -482,7 +687,7 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 /**
  * Macro for copying unaligned block from one location to another with constant load offset,
  * 47 bytes leftover maximum,
- * locations should not overlap.
+ * locations must not overlap.
  * Requirements:
  * - Store is aligned
  * - Load offset is <offset>, which must be immediate value within [1, 15]
@@ -542,7 +747,7 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 /**
  * Macro for copying unaligned block from one location to another,
  * 47 bytes leftover maximum,
- * locations should not overlap.
+ * locations must not overlap.
  * Use switch here because the aligning instruction requires immediate value for shift count.
  * Requirements:
  * - Store is aligned
@@ -573,38 +778,23 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
     }                                                                 \
 }
 
+/**
+ * Copy bytes from one location to another,
+ * locations must not overlap.
+ * Use with n > 64.
+ */
 static __rte_always_inline void *
-rte_memcpy_generic(void *dst, const void *src, size_t n)
+rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_restrict src,
+		size_t n)
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
@@ -696,44 +886,17 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 
 #endif /* __AVX512F__ */
 
+/**
+ * Copy bytes from one vector register size aligned location to another,
+ * locations must not overlap.
+ * Use with n > 64.
+ */
 static __rte_always_inline void *
-rte_memcpy_aligned(void *dst, const void *src, size_t n)
+rte_memcpy_aligned_more_than_64(void *__rte_restrict dst, const void *__rte_restrict src,
+		size_t n)
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
@@ -749,20 +912,28 @@ rte_memcpy_aligned(void *dst, const void *src, size_t n)
 }
 
 static __rte_always_inline void *
-rte_memcpy(void *dst, const void *src, size_t n)
+rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
 {
+	/* Common implementation for size <= 64 bytes. */
+	if (n <= 16)
+		return rte_mov16_or_less(dst, src, n);
+	if (n <= 64) {
+		/* Copy 17 ~ 64 bytes using vector instructions. */
+		if (n <= 32)
+			return rte_mov17_to_32(dst, src, n);
+		else
+			return rte_mov33_to_64(dst, src, n);
+	}
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
 
-#if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef __cplusplus
 }
 #endif
-- 
2.43.0

