Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14748C55184
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Aug 2026 14:33:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED125402D1;
	Tue,  4 Aug 2026 16:33:07 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 6680340285
 for <dev@dpdk.org>; Tue,  4 Aug 2026 16:33:07 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 24DA12051A;
 Tue,  4 Aug 2026 16:33:07 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 4 Aug 2026 16:33:06 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] eal/x86: optimize memcpy of small 64-byte blocks
Date: Tue,  4 Aug 2026 14:33:04 +0000
Message-ID: <20260804143305.1344327-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Aug 2026 14:33:06.0822 (UTC)
 FILETIME=[2A4BEA60:01DD241E]
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

The implementation for copying 64-byte blocks up to 512 (or 256) bytes
does not depend on address alignment with the size of the CPU's vector
registers, but is implemented in both unaligned and aligned copy
functions.
The main rte_memcpy() function was updated, so
if the copy size is known at compile time and the other criteria match,
the copy is performed without checking alignment requirements.
This provides two benefits when the optimization comes into play:
1. A performance gain, because the address alignment check is avoided.
3. Reduced instruction memory footprint, because the compiler only
generates one instance of the function for copying, instead of two
instances (one in the unaligned copy function, and one in the aligned
copy function).

Furthermore, the temporary alignment mask definition (ALIGNMENT_MASK)
was prefixed by RTE_MEMCPY_ to prevent potential namespace collision.

And finally, the superfluous function declaration at the top of the
file was removed, and its description was moved to the function
definition.
This improves search results with source code browsers.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/x86/include/rte_memcpy.h | 64 ++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
index 8ed8c55010..ce5a55c36f 100644
--- a/lib/eal/x86/include/rte_memcpy.h
+++ b/lib/eal/x86/include/rte_memcpy.h
@@ -32,21 +32,6 @@ extern "C" {
 #define RTE_MEMCPY_AVX
 #endif
 
-/**
- * Copy bytes from one location to another. The locations must not overlap.
- *
- * @param dst
- *   Pointer to the destination of the data.
- * @param src
- *   Pointer to the source data.
- * @param n
- *   Number of bytes to copy.
- * @return
- *   Pointer to the destination data.
- */
-static __rte_always_inline void *
-rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n);
-
 /**
  * Copy bytes from one location to another,
  * locations must not overlap.
@@ -187,7 +172,8 @@ rte_mov256(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
  * AVX512 implementation below
  */
 
-#define ALIGNMENT_MASK 0x3F
+#define RTE_MEMCPY_ALIGNMENT_MASK 0x3F
+#define RTE_MEMCPY_BLOCK_64_MAX 512
 
 /**
  * Copy 128-byte blocks from one location to another,
@@ -333,7 +319,8 @@ rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_rest
  * AVX implementation below
  */
 
-#define ALIGNMENT_MASK 0x1F
+#define RTE_MEMCPY_ALIGNMENT_MASK 0x1F
+#define RTE_MEMCPY_BLOCK_64_MAX 256
 
 /**
  * Copy 128-byte blocks from one location to another,
@@ -444,7 +431,8 @@ rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_rest
  * SSE implementation below
  */
 
-#define ALIGNMENT_MASK 0x0F
+#define RTE_MEMCPY_ALIGNMENT_MASK 0x0F
+#define RTE_MEMCPY_BLOCK_64_MAX 512
 
 /**
  * Macro for copying unaligned block from one location to another with constant load offset,
@@ -673,6 +661,18 @@ rte_memcpy_aligned_more_than_64(void *__rte_restrict dst, const void *__rte_rest
 	return ret;
 }
 
+/**
+ * Copy bytes from one location to another. The locations must not overlap.
+ *
+ * @param dst
+ *   Pointer to the destination of the data.
+ * @param src
+ *   Pointer to the source data.
+ * @param n
+ *   Number of bytes to copy.
+ * @return
+ *   Pointer to the destination data.
+ */
 static __rte_always_inline void *
 rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
 {
@@ -707,15 +707,39 @@ rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
 #endif
 		return dst;
 	}
+	/* Common way for small copy size of 64-byte blocks. Unlikely, so constant size only */
+	if (__rte_constant(n) && (n & 63) == 0 && n <= RTE_MEMCPY_BLOCK_64_MAX) {
+		void *ret = dst;
+
+		if (n & 512) {
+			rte_mov256((uint8_t *)dst + 0 * 256, (const uint8_t *)src + 0 * 256);
+			rte_mov256((uint8_t *)dst + 1 * 256, (const uint8_t *)src + 1 * 256);
+		}
+		if (n & 256) {
+			rte_mov256((uint8_t *)dst, (const uint8_t *)src);
+			src = (const uint8_t *)src + 256;
+			dst = (uint8_t *)dst + 256;
+		}
+		if (n & 128) {
+			rte_mov128((uint8_t *)dst, (const uint8_t *)src);
+			src = (const uint8_t *)src + 128;
+			dst = (uint8_t *)dst + 128;
+		}
+		if (n & 64)
+			rte_mov64((uint8_t *)dst, (const uint8_t *)src);
+
+		return ret;
+	}
 
 	/* Implementation for size > 64 bytes depends on alignment with vector register size. */
-	if (!(((uintptr_t)dst | (uintptr_t)src) & ALIGNMENT_MASK))
+	if (!(((uintptr_t)dst | (uintptr_t)src) & RTE_MEMCPY_ALIGNMENT_MASK))
 		return rte_memcpy_aligned_more_than_64(dst, src, n);
 	else
 		return rte_memcpy_generic_more_than_64(dst, src, n);
 }
 
-#undef ALIGNMENT_MASK
+#undef RTE_MEMCPY_ALIGNMENT_MASK
+#undef RTE_MEMCPY_BLOCK_64_MAX
 
 #ifdef __cplusplus
 }
-- 
2.43.0

