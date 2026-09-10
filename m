Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA0C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:36:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C74DE410DC;
	Thu, 10 Sep 2026 12:36:23 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A99FE4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:36:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6529620422;
 Thu, 10 Sep 2026 12:36:21 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 10 Sep 2026 12:36:20 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 1/6] mempool: fix private data area size alignment
Date: Thu, 10 Sep 2026 10:36:08 +0000
Message-ID: <20260910103613.808038-2-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910103613.808038-1-mb@smartsharesystems.com>
References: <20260910103613.808038-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Sep 2026 10:36:20.0786 (UTC)
 FILETIME=[381F9920:01DD4110]
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

Object size alignment should not affect alignment of mempool header size
or private data size, which are both cache aligned.
Reverted the parts of the patch that incorrectly changed this.

Fixes: 9f34c5a7abbd ("mempool: allow config override on element alignment")

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mempool/rte_mempool.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 817e2b8dc1..925d21570a 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -873,9 +873,7 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 	 * reserve a memory zone for this mempool: private data is
 	 * cache-aligned
 	 */
-	private_data_size = (private_data_size +
-			     RTE_MEMPOOL_ALIGN_MASK) & (~RTE_MEMPOOL_ALIGN_MASK);
-
+	private_data_size = RTE_CACHE_LINE_ROUNDUP(private_data_size);
 
 	/* try to allocate tailq entry */
 	te = rte_zmalloc("MEMPOOL_TAILQ_ENTRY", sizeof(*te), 0);
@@ -886,7 +884,6 @@ rte_mempool_create_empty(const char *name, unsigned n, unsigned elt_size,
 
 	mempool_size = RTE_MEMPOOL_HEADER_SIZE(mp, cache_size);
 	mempool_size += private_data_size;
-	mempool_size = RTE_ALIGN_CEIL(mempool_size, RTE_MEMPOOL_ALIGN);
 
 	ret = snprintf(mz_name, sizeof(mz_name), RTE_MEMPOOL_MZ_FORMAT, name);
 	if (ret < 0 || ret >= (int)sizeof(mz_name)) {
-- 
2.43.0

