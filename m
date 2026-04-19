Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE9EA71AE
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 22:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56FFC402B5;
	Mon, 20 Apr 2026 00:12:24 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DC5114026E;
 Mon, 20 Apr 2026 00:12:23 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id A7A6A20735;
 Mon, 20 Apr 2026 00:12:22 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 20 Apr 2026 00:12:22 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Shani Peretz <shperetz@nvidia.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 stable@dpdk.org
Subject: [PATCH] mbuf: fix mbuf operations history recording
Date: Sun, 19 Apr 2026 22:12:20 +0000
Message-ID: <20260419221220.86455-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Apr 2026 22:12:22.0284 (UTC)
 FILETIME=[986E7CC0:01DCD049]
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

This addresses two bugs in mbuf operations history recording.

1. With mbuf operations history recording enabled, when allocating mbufs
from a mempool failed, the array of fetched mbuf pointers was not set, but
it was dereferenced for mbuf operations history recording anyway, which
would trigger a segmentation fault or cause undefined behavior.

This was fixed by changing how the return value from the mempool
allocation is checked, so the function returns early on failure, and only
proceeds on success.

2. When allocating a bulk of mbufs using rte_pktmbuf_alloc_bulk(), two
mbuf library allocation operations were recorded on the mbuf, because the
function calls rte_mbuf_raw_alloc_bulk() for allocation, and both
functions record a mbuf library allocation operation.

This was fixed by not recording a mbuf library allocation operation in
rte_pktmbuf_alloc_bulk().

Fixes: d265a24a32a4 ("mbuf: record mbuf operations history")
Cc: stable@dpdk.org

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index e7c3bbadd4..60ec8158cd 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -663,14 +663,14 @@ static __rte_always_inline int
 rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned int count)
 {
 	int rc = rte_mempool_get_bulk(mp, (void **)mbufs, count);
-	if (likely(rc == 0)) {
-		for (unsigned int idx = 0; idx < count; idx++)
-			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], mp);
-	}
+	if (unlikely(rc))
+		return rc;
+	for (unsigned int idx = 0; idx < count; idx++)
+		__rte_mbuf_raw_sanity_check_mp(mbufs[idx], mp);
 
 	rte_mbuf_history_mark_bulk(mbufs, count, RTE_MBUF_HISTORY_OP_LIB_ALLOC);
 
-	return rc;
+	return 0;
 }
 
 /**
@@ -1068,8 +1068,6 @@ static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	if (unlikely(rc))
 		return rc;
 
-	rte_mbuf_history_mark_bulk(mbufs, count, RTE_MBUF_HISTORY_OP_LIB_ALLOC);
-
 	rte_mbuf_raw_reset_bulk(pool, mbufs, count);
 
 	return 0;
-- 
2.43.0

