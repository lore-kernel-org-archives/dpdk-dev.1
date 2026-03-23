Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08471EC01A0
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 08:12:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 46FC740268;
	Mon, 23 Mar 2026 09:12:14 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 17C3B4025F
 for <dev@dpdk.org>; Mon, 23 Mar 2026 09:12:12 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 06AB62045F;
 Mon, 23 Mar 2026 09:12:11 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 23 Mar 2026 09:12:10 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 David Marchand <david.marchand@redhat.com>,
 Robin Jarry <rjarry@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] eal: fix cache guard for pedantic compilation
Date: Mon, 23 Mar 2026 08:12:04 +0000
Message-ID: <20260323081204.748909-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Mar 2026 08:12:10.0887 (UTC)
 FILETIME=[BFBE8170:01DCBA9C]
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

The cache guard macro uses __COUNTER__ to generate unique names.
However, although most C compilers support __COUNTER__, it is not yet
part of the C standard, so compilation fails when building in pedantic
mode.
The macro was changed to use __LINE__ instead.

Fixes: 65f600c0f000 ("eal: add empty cache line macro")

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/include/rte_common.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/eal/include/rte_common.h b/lib/eal/include/rte_common.h
index 573bf4f2ce..97865aaa39 100644
--- a/lib/eal/include/rte_common.h
+++ b/lib/eal/include/rte_common.h
@@ -751,8 +751,12 @@ rte_is_aligned(const void * const __rte_restrict ptr, const unsigned int align)
  *
  * Use as spacing between data accessed by different lcores,
  * to prevent cache thrashing on hardware with speculative prefetching.
+ *
+ * Note: Although __COUNTER__ would be better for uniqueness, it is not yet
+ * (March 2026) part of the C standard, so compilation would fail when building
+ * in pedantic mode.
  */
-#define RTE_CACHE_GUARD _RTE_CACHE_GUARD_HELPER1(__COUNTER__)
+#define RTE_CACHE_GUARD _RTE_CACHE_GUARD_HELPER1(__LINE__)
 
 /*********** PA/IOVA type definitions ********/
 
-- 
2.43.0

