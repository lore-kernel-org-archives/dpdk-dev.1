Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC4ACA0EFF
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 21:35:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B634A4029E;
	Wed, 27 Aug 2025 23:35:38 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 1092A40298
 for <dev@dpdk.org>; Wed, 27 Aug 2025 23:35:38 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id C800B20A24
 for <dev@dpdk.org>; Wed, 27 Aug 2025 23:35:37 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 27 Aug 2025 23:35:37 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] mbuf: optimize segment prefree
Date: Wed, 27 Aug 2025 21:35:34 +0000
Message-ID: <20250827213535.21602-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 Aug 2025 21:35:37.0445 (UTC)
 FILETIME=[872B8150:01DC179A]
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

Eefactored rte_pktmbuf_prefree_seg() for both performance and readability.

With the optimized RTE_MBUF_DIRECT() macro, the common likely code path
now fits within one instruction cache line on x86-64 when built with GCC.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf.h      | 52 ++++++++++++++++------------------------
 lib/mbuf/rte_mbuf_core.h |  8 +++++++
 2 files changed, 28 insertions(+), 32 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 06ab7502a5..f4a348597f 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -31,6 +31,7 @@
  * http://www.kohala.com/start/tcpipiv2.html
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 
 #include <rte_common.h>
@@ -1423,44 +1424,31 @@ static inline int __rte_pktmbuf_pinned_extbuf_decref(struct rte_mbuf *m)
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
+	if (refcnt_not_one &&
+		__rte_mbuf_refcnt_update(m, -1) != 0)
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
+			RTE_MBUF_HAS_PINNED_EXTBUF(m) &&
+			__rte_pktmbuf_pinned_extbuf_decref(m))
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
index a0df265b5d..a5242274d7 100644
--- a/lib/mbuf/rte_mbuf_core.h
+++ b/lib/mbuf/rte_mbuf_core.h
@@ -715,6 +715,14 @@ struct rte_mbuf_ext_shared_info {
 #define RTE_MBUF_DIRECT(mb) \
 	(!((mb)->ol_flags & (RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL)))
 
+/* GCC only optimizes single-bit MSB tests this way, so do it by hand with multi-bit. */
+#if defined(RTE_TOOLCHAIN_GCC) && defined(RTE_ARCH_X86)
+#undef RTE_MBUF_DIRECT
+#define RTE_MBUF_DIRECT(mb) \
+	(!(((const uint8_t *)(mb))[offsetof(struct rte_mbuf, ol_flags) + 7] & \
+	(uint8_t)((RTE_MBUF_F_INDIRECT | RTE_MBUF_F_EXTERNAL) >> 56)))
+#endif
+
 /** Uninitialized or unspecified port. */
 #define RTE_MBUF_PORT_INVALID UINT16_MAX
 /** For backwards compatibility. */
-- 
2.43.0

