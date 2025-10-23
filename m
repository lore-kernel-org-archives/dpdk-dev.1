Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F2ECCD1BE
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Oct 2025 16:19:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B016402D6;
	Thu, 23 Oct 2025 18:19:00 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id BA7DE40144
 for <dev@dpdk.org>; Thu, 23 Oct 2025 18:18:58 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 978012041E;
 Thu, 23 Oct 2025 18:18:58 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 23 Oct 2025 18:18:57 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v7] mbuf: optimize segment prefree
Date: Thu, 23 Oct 2025 16:18:50 +0000
Message-ID: <20251023161851.328258-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827213535.21602-1-mb@smartsharesystems.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Oct 2025 16:18:57.0946 (UTC)
 FILETIME=[BC21C7A0:01DC4438]
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

Refactored rte_pktmbuf_prefree_seg() for both performance and readability.

With the optimized RTE_MBUF_DIRECT() macro, the common likely code path
now fits within one instruction cache line on x86-64 when built with GCC.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Reviewed-by: Bruce Richardson <bruce.richardson@intel.com>
---
v7:
* Go back to long names instead of numerical value in RTE_MBUF_DIRECT()
  macro.
  (Konstantin Ananyev)
* Updated static_assert() accordingly.
v6:
* Fixed Doxygen error in RTE_MBUF_DIRECT() macro description.
  (Thomas Monjalon)
* Added specific RTE_MBUF_DIRECT() macro implementation for API
  documentation purposes, using flag names instead of numerical value.
v5:
* Removed the plain RTE_MBUF_DIRECT() macro, and only use the optimized
  variant. (Bruce Richardson)
  Further testing on Godbolt confirmed that other compilers benefit from
  the optimized macro too.
* Shortened the description of the RTE_MBUF_DIRECT() macro, and only
  provide one example of code emitted by a compiler. (Bruce Richardson)
* Consolidated the static_assert() into one, covering both little and big
  endian.
  This also reduces the amount of endian-conditional source code and
  improves readability.
  (Bruce Richardson)
* Added comment about MSB meaning "most significant byte".
v4:
* Enabled the optimized RTE_MBUF_DIRECT() macro for GCC on all
  architectures.
v3:
* Rewrote the optimized RTE_MBUF_DIRECT() macro for readability; use
  numerical value instead of long names. (Bruce Richardson)
* Enabled the optimized RTE_MBUF_DIRECT() macro for Loongarch too.
v2:
* Fixed typo in commit description.
* Fixed indentation.
* Added detailed description to the optimized RTE_MBUF_DIRECT() macro.
  (Stephen Hemminger)
* Added static_assert() to verify that the optimized RTE_MBUF_DIRECT()
  macro is valid, specifically that the tested bits are in the MSB of the
  64-bit field.
---
 lib/mbuf/rte_mbuf.h      | 51 +++++++++++++++-------------------------
 lib/mbuf/rte_mbuf_core.h | 48 +++++++++++++++++++++++++++++++++++--
 2 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 3df22125de..2004391f57 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -31,6 +31,7 @@
  * http://www.kohala.com/start/tcpipiv2.html
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 
 #include <rte_common.h>
@@ -1458,44 +1459,30 @@ static inline int __rte_pktmbuf_pinned_extbuf_decref(struct rte_mbuf *m)
 static __rte_always_inline struct rte_mbuf *
 rte_pktmbuf_prefree_seg(struct rte_mbuf *m)
 {
-	__rte_mbuf_sanity_check(m, 0);
-
-	if (likely(rte_mbuf_refcnt_read(m) == 1)) {
-
-		if (!RTE_MBUF_DIRECT(m)) {
-			rte_pktmbuf_detach(m);
-			if (RTE_MBUF_HAS_EXTBUF(m) &&
-			    RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
-			    __rte_pktmbuf_pinned_extbuf_decref(m))
-				return NULL;
-		}
-
-		if (m->next != NULL)
-			m->next = NULL;
-		if (m->nb_segs != 1)
-			m->nb_segs = 1;
+	bool refcnt_not_one;
 
-		return m;
+	__rte_mbuf_sanity_check(m, 0);
 
-	} else if (__rte_mbuf_refcnt_update(m, -1) == 0) {
+	refcnt_not_one = unlikely(rte_mbuf_refcnt_read(m) != 1);
+	if (refcnt_not_one && __rte_mbuf_refcnt_update(m, -1) != 0)
+		return NULL;
 
-		if (!RTE_MBUF_DIRECT(m)) {
-			rte_pktmbuf_detach(m);
-			if (RTE_MBUF_HAS_EXTBUF(m) &&
-			    RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
-			    __rte_pktmbuf_pinned_extbuf_decref(m))
-				return NULL;
-		}
+	if (unlikely(!RTE_MBUF_DIRECT(m))) {
+		rte_pktmbuf_detach(m);
+		if (RTE_MBUF_HAS_EXTBUF(m) &&
+				RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
+				__rte_pktmbuf_pinned_extbuf_decref(m))
+			return NULL;
+	}
 
-		if (m->next != NULL)
-			m->next = NULL;
-		if (m->nb_segs != 1)
-			m->nb_segs = 1;
+	if (refcnt_not_one)
 		rte_mbuf_refcnt_set(m, 1);
+	if (m->nb_segs != 1)
+		m->nb_segs = 1;
+	if (m->next != NULL)
+		m->next = NULL;
 
-		return m;
-	}
-	return NULL;
+	return m;
 }
 
 /**
diff --git a/lib/mbuf/rte_mbuf_core.h b/lib/mbuf/rte_mbuf_core.h
index a0df265b5d..506f7146f1 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -711,9 +711,53 @@ struct rte_mbuf_ext_shared_info {
  *
  * If a mbuf embeds its own data after the rte_mbuf structure, this mbuf
  * can be defined as a direct mbuf.
- */
+ *
+ * Note: Macro optimized for code size.
+ *
+ * The plain macro would be:
+ * \code{.c}
+ *      #define RTE_MBUF_DIRECT(mb) \
+ *          (!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
+ * \endcode
+ *
+ * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are both in the MSB (most significant
+ * byte) of the 64-bit ol_flags field, so we only compare this one byte instead of all 64 bits.
+ *
+ * E.g., GCC version 16.0.0 20251019 (experimental) generates the following code for x86-64.
+ *
+ * With the plain macro, 17 bytes of instructions:
+ * \code
+ *      movabs rax,0x6000000000000000       // 10 bytes
+ *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
+ *      sete   al                           // 3 bytes
+ * \endcode
+ * With this optimized macro, only 7 bytes of instructions:
+ * \code
+ *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
+ *      sete   al                           // 3 bytes
+ * \endcode
+ */
+#ifdef __DOXYGEN__
+#define RTE_MBUF_DIRECT(mb) \
+	!(((const char *)(&(mb)->ol_flags))[MSB_OFFSET /* 7 or 0, depending on endianness */] & \
+	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 * CHAR_BIT)))
+#else /* !__DOXYGEN__ */
+#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+/* On little endian architecture, the MSB of a 64-bit integer is at byte offset 7. */
+#define RTE_MBUF_DIRECT(mb) \
+	!(((const char *)(&(mb)->ol_flags))[7] & \
+	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 * CHAR_BIT)))
+#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+/* On big endian architecture, the MSB of a 64-bit integer is at byte offset 0. */
 #define RTE_MBUF_DIRECT(mb) \
-	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
+	!(((const char *)(&(mb)->ol_flags))[0] & \
+	(char)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 * CHAR_BIT)))
+#endif /* RTE_BYTE_ORDER */
+#endif /* !__DOXYGEN__ */
+/* Verify the optimization above. */
+static_assert(((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) & (UINT64_C(0xFF) << (7 * CHAR_BIT))) ==
+	(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL),
+	"(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) is not at MSB");
 
 /** Uninitialized or unspecified port. */
 #define RTE_MBUF_PORT_INVALID UINT16_MAX
-- 
2.43.0

