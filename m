Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A639AC624D3
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Sep 2026 11:34:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D771942F5F;
	Fri,  4 Sep 2026 13:34:36 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 49FD042F4D
 for <dev@dpdk.org>; Fri,  4 Sep 2026 13:34:35 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 104B620910;
 Fri,  4 Sep 2026 13:34:35 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Fri, 4 Sep 2026 13:34:34 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Vipin Varghese <vipin.varghese@amd.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v4] eal/x86: fix memcpy alignment mask definition
Date: Fri,  4 Sep 2026 11:34:33 +0000
Message-ID: <20260904113433.857609-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904092028.856816-1-mb@smartsharesystems.com>
References: <20260904092028.856816-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Sep 2026 11:34:34.0715 (UTC)
 FILETIME=[5C305AB0:01DD3C61]
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

An alignment mask (ALIGNMENT_MASK) is temporarily defined for internal
purposes, but it is publicly exposed when including the header file,
potentially colliding with existing definitions with the same name.
Fixed this potential issue by adding the RTE_MEMCPY_ prefix to the
definition.

Furthermore, the superfluous function declaration at the top of the file
was removed, and its description was moved to the function definition,
to improve search results with source code browsers.

Also, changed "!(addrs & MASK)" to "(addrs & MASK) == 0" to follow DPDK
coding style.

None of these changes should have any practical effect.

Fixes: f5472703c0bd ("eal: optimize aligned memcpy on x86")

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
v4:
* Really, really changed it this time.
  When editing patch files, remember to edit the code too.
v3:
* Actually changed "!(addrs & MASK)" to "(addrs & MASK) == 0".
  In v2, it was changed in my editor, but not saved to disk.
v2:
* Changed "!(addrs & MASK)" to "(addrs & MASK) == 0". (AI)
---
 lib/eal/x86/include/rte_memcpy.h | 37 +++++++++++++++-----------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/lib/eal/x86/include/rte_memcpy.h b/lib/eal/x86/include/rte_memcpy.h
index 8ed8c55010..41fb08ab95 100644
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
@@ -187,7 +172,7 @@ rte_mov256(uint8_t *__rte_restrict dst, const uint8_t *__rte_restrict src)
  * AVX512 implementation below
  */
 
-#define ALIGNMENT_MASK 0x3F
+#define RTE_MEMCPY_ALIGNMENT_MASK 0x3F
 
 /**
  * Copy 128-byte blocks from one location to another,
@@ -333,7 +318,7 @@ rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_rest
  * AVX implementation below
  */
 
-#define ALIGNMENT_MASK 0x1F
+#define RTE_MEMCPY_ALIGNMENT_MASK 0x1F
 
 /**
  * Copy 128-byte blocks from one location to another,
@@ -444,7 +429,7 @@ rte_memcpy_generic_more_than_64(void *__rte_restrict dst, const void *__rte_rest
  * SSE implementation below
  */
 
-#define ALIGNMENT_MASK 0x0F
+#define RTE_MEMCPY_ALIGNMENT_MASK 0x0F
 
 /**
  * Macro for copying unaligned block from one location to another with constant load offset,
@@ -673,6 +658,18 @@ rte_memcpy_aligned_more_than_64(void *__rte_restrict dst, const void *__rte_rest
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
@@ -709,13 +706,13 @@ rte_memcpy(void *__rte_restrict dst, const void *__rte_restrict src, size_t n)
 	}
 
 	/* Implementation for size > 64 bytes depends on alignment with vector register size. */
-	if (!(((uintptr_t)dst | (uintptr_t)src) & ALIGNMENT_MASK))
+	if ((((uintptr_t)dst | (uintptr_t)src) & RTE_MEMCPY_ALIGNMENT_MASK) == 0)
 		return rte_memcpy_aligned_more_than_64(dst, src, n);
 	else
 		return rte_memcpy_generic_more_than_64(dst, src, n);
 }
 
-#undef ALIGNMENT_MASK
+#undef RTE_MEMCPY_ALIGNMENT_MASK
 
 #ifdef __cplusplus
 }
-- 
2.43.0

