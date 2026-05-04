Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AC3FF885A
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 07:15:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5102D40608;
	Mon,  4 May 2026 09:15:50 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DFABC40270
 for <dev@dpdk.org>; Mon,  4 May 2026 09:15:48 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9117220628
 for <dev@dpdk.org>; Mon,  4 May 2026 09:15:48 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 4 May 2026 09:15:46 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] stack: rightsize cache guard
Date: Mon,  4 May 2026 07:15:39 +0000
Message-ID: <20260504071539.252926-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 May 2026 07:15:46.0559 (UTC)
 FILETIME=[D3E088F0:01DCDB95]
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

Using 2 cache lines as cache guard after the table holding the stack
elements may be too many or too few. Instead, use the number of cache
lines specified in the build configuration.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/stack/rte_stack_lf.c  | 2 +-
 lib/stack/rte_stack_std.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/stack/rte_stack_lf.c b/lib/stack/rte_stack_lf.c
index 0adcc263e4..db951f6d1b 100644
--- a/lib/stack/rte_stack_lf.c
+++ b/lib/stack/rte_stack_lf.c
@@ -25,7 +25,7 @@ rte_stack_lf_get_memsize(unsigned int count)
 	/* Add padding to avoid false sharing conflicts caused by
 	 * next-line hardware prefetchers.
 	 */
-	sz += 2 * RTE_CACHE_LINE_SIZE;
+	sz += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
 
 	return sz;
 }
diff --git a/lib/stack/rte_stack_std.c b/lib/stack/rte_stack_std.c
index 0a310d7c63..d5d6e767f1 100644
--- a/lib/stack/rte_stack_std.c
+++ b/lib/stack/rte_stack_std.c
@@ -20,7 +20,7 @@ rte_stack_std_get_memsize(unsigned int count)
 	/* Add padding to avoid false sharing conflicts caused by
 	 * next-line hardware prefetchers.
 	 */
-	sz += 2 * RTE_CACHE_LINE_SIZE;
+	sz += RTE_CACHE_GUARD_LINES * RTE_CACHE_LINE_SIZE;
 
 	return sz;
 }
-- 
2.43.0

