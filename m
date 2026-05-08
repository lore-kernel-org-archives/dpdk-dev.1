Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96414CD3436
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 May 2026 09:58:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 74E9540268;
	Fri,  8 May 2026 11:58:37 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 0A4F34013F
 for <dev@dpdk.org>; Fri,  8 May 2026 11:58:36 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id CC176208C9;
 Fri,  8 May 2026 11:58:35 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 8 May 2026 11:58:34 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Liangxing Wang <wangliangxing@hygon.cn>
Cc: Thiyagarajan P <Thiyagarajan.P@amd.com>,
 Bala Murali Krishna <Bala.MuraliKrishna@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v10] eal/x86: optimize memcpy of small sizes
Date: Fri,  8 May 2026 09:58:27 +0000
Message-ID: <20260508095827.53587-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251120114554.950287-1-mb@smartsharesystems.com>
References: <20251120114554.950287-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 May 2026 09:58:34.0654 (UTC)
 FILETIME=[3BC48BE0:01DCDED1]
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
alignment with the size of the CPU's vector registers. Nonetheless, the
exact same code for copying up to 64 bytes was present in both the aligned
copy function and all the CPU vector register size specific variants of
the unaligned copy functions.
With this patch, the implementation for copying up to 64 bytes was
consolidated into one instance, located in the common copy function,
before checking alignment requirements.
This provides three benefits:
1. No copy-paste in the source code.
2. A performance gain for copying up to 64 bytes, because the
address alignment check is avoided in this case.
3. Reduced instruction memory footprint, because the compiler only
generates one instance of the function for copying up to 64 bytes, instead
of two instances (one in the unaligned copy function, and one in the
aligned copy function).

Furthermore, __rte_restrict was added to source and destination addresses.

And finally, the missing implementation of rte_mov48() was added.

Regarding performance...
The memcpy performance test (cache-to-cache copy) shows:
Copying up to 15 bytes takes ca. 4.5 cycles, versus ca. 6.5 cycles before.
Copying 8 bytes takes 4 cycles, versus 7 cycles before.
Copying 16 bytes takes 2 cycles, versus 4 cycles before.
Copying 64 bytes takes 4 cycles, versus 7 cycles before.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
v10:
* Reverted removal of ignoring stringop-overflow warnings.
  Instead, added a comment about the reason for ignoring them.
  Some drivers still use elems[1] instead of elems[] for structures with
  flexible arrays.
  IMO, the drivers should be fixed, or the warnings should be igmored
  there; but I'm picking the easy solution, and not changing this.
  If they were using standard memcpy(), warnings would also be emitted.
v9:
* Removed new functions rte_mov16_to_32() and rte_mov32_to_64(), and moved
  their implementations into rte_memcpy() instead.
  There is no need for such public functions, and having them separate did
  not improve source code readability.
* Kept acks from Bruce and Konstantin (both given to v7).
v8:
* Reverted the first branch from size <= 16 back to size < 16, restored
  the original rte_mov15_or_less() function, and removed the new
  rte_mov16_or_less() function.
  When rte_memcpy() is used for copying an array of pointers, and the
  number of pointers to copy is low (size <= 64 bytes), it is more likely
  that the number of pointers to copy is 1 than 2.
  The rte_mov15_or_less() implementation handles copying 8 bytes more
  efficiently than the rte_mov16_or_less() implementation, which copied
  the 8-byte pointer twice.
  Also note that with rte_mov15_or_less(), the compiler can optimize away
  the branches handling n & 1, n & 2 and n & 4 when it is known at compile
  time that (8-byte) pointers are being copied. (For 32-bit architecture,
  the n & 4 will not be optimized away when copying pointers.)
  This reversion also makes the patch less revolutionary and more
  incremental.
* Removed a lot of code for handling compile time known sizes. (Bruce)
  The rte_memcpy() function should not be used for small copies with
  compile time known sizes, so handling it is considered superfluous.
  Removing it improves source code readability. And reduces the size of
  the patch.
* Kept acks from Bruce and Konstantin (both given to v7).
v7:
* Updated patch description. Mainly to clarify that the changes related to
  copying up to 64 bytes simply replaces multiple instances of copy-pasted
  code with one common instance.
* Fixed copy of compile time known 16 bytes in rte_mov17_to_32(). (Vipin)
* Rebased.
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
* Handle more compile time constant copy sizes.
---
 lib/eal/x86/include/rte_memcpy.h | 242 +++++++++++++------------------
 1 file changed, 103 insertions(+), 139 deletions(-)

diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
index 46d34b8081..d6dfac19aa 100644
--- a/lib/eal/x86/include/rte_memcpy.h
+++ b/lib/eal/x86/include/rte_memcpy.h
@@ -22,6 +22,7 @@
 extern "C" {
 #endif
 
+/* Workaround for drivers using elems[1] instead of elems[] for flexible arrays. */
 #if defined(RTE_TOOLCHAIN_GCC) && (GCC_VERSION >= 100000)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wstringop-overflow"
@@ -40,9 +41,6 @@ extern "C" {
 /**
  * Copy bytes from one location to another. The locations must not overlap.
  *
- * @note This is implemented as a macro, so it's address should not be taken
- * and care is needed as parameter expressions may be evaluated multiple times.
- *
  * @param dst
  *   Pointer to the destination of the data.
  * @param src
@@ -53,15 +51,15 @@ extern "C" {
  *   Pointer to the destination data.
  */
 static __rte_always_inline void *
-rte_memcpy(void *dst, const void *src, size_t n);
+rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n);
 
 /**
  * Copy bytes from one location to another,
- * locations should not overlap.
+ * locations must not overlap.
  * Use with n <= 15.
  */
 static __rte_always_inline void *
-rte_mov15_or_less(void *dst, const void *src, size_t n)
+rte_mov15_or_less(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
 {
 	/**
 	 * Use the following structs to avoid violating C standard
@@ -103,10 +101,10 @@ rte_mov15_or_less(void *dst, const void *src, size_t n)
 
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
 
@@ -116,10 +114,10 @@ rte_mov16(uint8_t *dst, const uint8_t *src)
 
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
@@ -132,12 +130,29 @@ rte_mov32(uint8_t *dst, const uint8_t *src)
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
@@ -152,10 +167,10 @@ rte_mov64(uint8_t *dst, const uint8_t *src)
 
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
@@ -163,10 +178,10 @@ rte_mov128(uint8_t *dst, const uint8_t *src)
 
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
@@ -182,10 +197,10 @@ rte_mov256(uint8_t *dst, const uint8_t *src)
 
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
 
@@ -202,10 +217,10 @@ rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
 
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
 
@@ -232,45 +247,22 @@ rte_mov512blocks(uint8_t *dst, const uint8_t *src, size_t n)
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
@@ -351,10 +343,10 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 
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
 
@@ -381,41 +373,22 @@ rte_mov128blocks(uint8_t *dst, const uint8_t *src, size_t n)
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
@@ -482,7 +455,7 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 /**
  * Macro for copying unaligned block from one location to another with constant load offset,
  * 47 bytes leftover maximum,
- * locations should not overlap.
+ * locations must not overlap.
  * Requirements:
  * - Store is aligned
  * - Load offset is <offset>, which must be immediate value within [1, 15]
@@ -542,7 +515,7 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 /**
  * Macro for copying unaligned block from one location to another,
  * 47 bytes leftover maximum,
- * locations should not overlap.
+ * locations must not overlap.
  * Use switch here because the aligning instruction requires immediate value for shift count.
  * Requirements:
  * - Store is aligned
@@ -573,38 +546,23 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
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
@@ -696,44 +654,17 @@ rte_memcpy_generic(void *dst, const void *src, size_t n)
 
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
@@ -749,12 +680,45 @@ rte_memcpy_aligned(void *dst, const void *src, size_t n)
 }
 
 static __rte_always_inline void *
-rte_memcpy(void *dst, const void *src, size_t n)
+rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
 {
+	/* Fast way when copy size doesn't exceed 64 bytes. */
+	if (n < 16)
+		return rte_mov15_or_less(dst, src, n);
+	if (n <= 32) {
+		if (__rte_constant(n) && n == 32) {
+			rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+		rte_mov16((uint8_t *)dst, (const uint8_t *)src);
+		if (__rte_constant(n) && n == 16)
+			return dst; /* avoid (harmless) duplicate copy */
+		rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
+		return dst;
+	}
+	if (n <= 64) {
+		if (__rte_constant(n) && n == 64) {
+			rte_mov64((uint8_t *)dst, (const uint8_t *)src);
+			return dst;
+		}
+#if defined RTE_MEMCPY_AVX
+		rte_mov32((uint8_t *)dst, (const uint8_t *)src);
+		rte_mov32((uint8_t *)dst - 32 + n, (const uint8_t *)src - 32 + n);
+#else /* SSE implementation */
+		rte_mov16((uint8_t *)dst + 0 * 16, (const uint8_t *)src + 0 * 16);
+		rte_mov16((uint8_t *)dst + 1 * 16, (const uint8_t *)src + 1 * 16);
+		if (n > 48)
+			rte_mov16((uint8_t *)dst + 2 * 16, (const uint8_t *)src + 2 * 16);
+		rte_mov16((uint8_t *)dst - 16 + n, (const uint8_t *)src - 16 + n);
+#endif
+		return dst;
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
-- 
2.43.0

