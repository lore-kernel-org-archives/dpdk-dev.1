Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92E2C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 10:36:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BADC74278B;
	Thu, 10 Sep 2026 12:36:24 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id AF060410DC
 for <dev@dpdk.org>; Thu, 10 Sep 2026 12:36:21 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 5775B2041E;
 Thu, 10 Sep 2026 12:36:21 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 10 Sep 2026 12:36:20 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH 0/6] mempool: cleanup, fixes, improvements and optimizations
Date: Thu, 10 Sep 2026 10:36:07 +0000
Message-ID: <20260910103613.808038-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Sep 2026 10:36:20.0551 (UTC)
 FILETIME=[37FBBD70:01DD4110]
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

Consolidated mempool patches previously submitted individually into one
series, and added a couple more.

Patch 1
Fixed a minor bug regarding the private data size alignment.

Patch 2 and 3
Removed the deprecated cache flush threshold field.
Supersedes: patch-167311
("[v3] mempool: remove cache flush threshold field")

Patch 4
Annotated private cache alloc/free functions as such,
improved the ops registration and lookup functions, and
improved the audit functions, and
updated some comments.

Patch 5
Swapped the location of the private data and local cache.
Supersedes: patch-169235
("[v2] mempool: no cache size limit")

Patch 6
Rightsized the memory allocated for cache, and
eliminated the cache size max limit.
Supersedes: patch-169235
("[v2] mempool: no cache size limit")

Morten Brørup (6):
  mempool: fix private data area size alignment
  net/sxe2: do not use deprecated mempool cache field
  mempool: remove deprecated cache flush threshold field
  mempool: various cleanups
  mempool: optimize access to private data
  mempool: no cache size limit

 app/test/test_mempool.c                 |  17 ++-
 doc/guides/rel_notes/release_26_11.rst  |  16 +++
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c |   2 +-
 lib/mempool/mempool_trace.h             |   1 -
 lib/mempool/rte_mempool.c               | 151 +++++++++++++-----------
 lib/mempool/rte_mempool.h               |  91 +++++++-------
 lib/mempool/rte_mempool_ops.c           |  30 +++--
 7 files changed, 178 insertions(+), 130 deletions(-)

-- 
2.43.0

