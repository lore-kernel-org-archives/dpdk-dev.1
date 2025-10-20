Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA75CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 12:02:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19316402AB;
	Mon, 20 Oct 2025 14:02:11 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 29CCA400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 14:02:10 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id E5948202CC;
 Mon, 20 Oct 2025 14:02:09 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 20 Oct 2025 14:02:09 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] mbuf: optimize segment prefree
Date: Mon, 20 Oct 2025 12:02:01 +0000
Message-ID: <20251020120202.80114-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827213535.21602-1-mb@smartsharesystems.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Oct 2025 12:02:09.0550 (UTC)
 FILETIME=[5CC5E2E0:01DC41B9]
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
---
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
 lib/mbuf/rte_mbuf_core.h | 27 +++++++++++++++++++++
 2 files changed, 46 insertions(+), 32 deletions(-)

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
index a0df265b5d..41f40e1967 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -715,6 +715,33 @@ struct rte_mbuf_ext_shared_info {
 #define RTE_MBUF_DIRECT(mb) \
 	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
 
+#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
+/* Optimization for code size.
+ * GCC only optimizes single-bit MSB tests this way, so we do it by hand with multi-bit.
+ *
+ * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are both in the MSB of the
+ * 64-bit ol_flags field, so we only compare this one byte instead of all 64 bits.
+ * On little endian architecture, the MSB of a 64-bit integer is at byte offest 7.
+ *
+ * Note: Tested using GCC version 16.0.0 20251019 (experimental).
+ *
+ * Without this optimization, GCC generates 17 bytes of instructions:
+ *      movabs rax,0x6000000000000000       // 10 bytes
+ *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
+ *      sete   al                           // 3 bytes
+ * With this optimization, GCC generates only 7 bytes of instructions:
+ *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
+ *      sete   al                           // 3 bytes
+ */
+#undef RTE_MBUF_DIRECT
+#define RTE_MBUF_DIRECT(mb) \
+	(!(((const uint8_t *)(mb))[offsetof(struct rte_mbuf, ol_flags) + 7] & \
+	(uint8_t)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 * 8))))
+static_assert(((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> (7 * 8)) << (7 * 8) ==
+	(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL),
+	"RTE_MBUF_F_INDIRECT and/or RTE_MBUF_F_EXTERNAL are not in MSB.");
+#endif
+
 /** Uninitialized or unspecified port. */
 #define RTE_MBUF_PORT_INVALID UINT16_MAX
 /** For backwards compatibility. */
-- 
2.43.0

