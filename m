Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E06CCD1BB
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Oct 2025 13:23:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A58B54025E;
	Wed, 22 Oct 2025 15:23:14 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9CA684025D
 for <dev@dpdk.org>; Wed, 22 Oct 2025 15:23:13 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 3D8482041E;
 Wed, 22 Oct 2025 15:23:12 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 22 Oct 2025 15:23:10 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3] mbuf: optimize segment prefree
Date: Wed, 22 Oct 2025 13:23:02 +0000
Message-ID: <20251022132303.146300-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827213535.21602-1-mb@smartsharesystems.com>
References: <20250827213535.21602-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Oct 2025 13:23:10.0333 (UTC)
 FILETIME=[02DA02D0:01DC4357]
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
 lib/mbuf/rte_mbuf_core.h | 40 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 32 deletions(-)

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
index a0df265b5d..7c0bddc362 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -715,6 +715,46 @@ struct rte_mbuf_ext_shared_info {
 #define RTE_MBUF_DIRECT(mb) \
 	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
 
+#if defined(RTE_TOOLCHAIN_GCC) && (defined(RTE_ARCH_X86) || defined(RTE_ARCH_LOONGARCH))
+/* Optimization for code size.
+ * GCC only optimizes single-bit MSB tests this way, so we do it by hand with multi-bit.
+ *
+ * The flags RTE_MBUF_F_INDIRECT and RTE_MBUF_F_EXTERNAL are both in the MSB of the
+ * 64-bit ol_flags field, so we only compare this one byte instead of all 64 bits.
+ * On little endian architecture, the MSB of a 64-bit integer is at byte offset 7.
+ *
+ * Note: Tested on x86-64 using GCC version 16.0.0 20251019 (experimental).
+ *
+ * Without this optimization, GCC generates 17 bytes of instructions:
+ *      movabs rax,0x6000000000000000       // 10 bytes
+ *      and    rax,QWORD PTR [rdi+0x18]     // 4 bytes
+ *      sete   al                           // 3 bytes
+ * With this optimization, GCC generates only 7 bytes of instructions:
+ *      test   BYTE PTR [rdi+0x1f],0x60     // 4 bytes
+ *      sete   al                           // 3 bytes
+ *
+ * Note: Tested on loongarch using GCC version 15.2.0.
+ *
+ * Without this optimization, GCC generates 5 instructions:
+ *      ld.d        $a0, $a0, 24
+ *      move        $t0, $zero
+ *      lu52i.d     $t0, $t0, 1536
+ *      and         $a0, $a0, $t0
+ *      sltui       $a0, $a0, 1
+ * With this optimization, GCC generates only 3 instructions:
+ *      ld.bu       $a0, $a0, 31
+ *      andi        $a0, $a0, 0x60
+ *      sltui       $a0, $a0, 1
+ *
+ * Note: Tested on ARM64, GCC generates 3 instructions both without and with the optimization,
+ * so no need for the optimization here.
+ */
+static_assert((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) == UINT64_C(0x60) << (7 * CHAR_BIT),
+	"(RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) is not 0x60 at byte offset 7");
+#undef RTE_MBUF_DIRECT
+#define RTE_MBUF_DIRECT(mb)     !(((const char *)(&(mb)->ol_flags))[7] & 0x60)
+#endif
+
 /** Uninitialized or unspecified port. */
 #define RTE_MBUF_PORT_INVALID UINT16_MAX
 /** For backwards compatibility. */
-- 
2.43.0

