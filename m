Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB10C5DF85
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Aug 2026 15:45:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFD1B4060B;
	Thu, 20 Aug 2026 17:45:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 71C774026D
 for <dev@dpdk.org>; Thu, 20 Aug 2026 17:45:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787240740; x=1818776740;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/LfQ2VY9lijhWb+/56F59PJB0cdO9x3A8GMW9XM+onY=;
 b=dg71hqePajPrLyjHB/iounSEMB5Z5p1PJsRGebT+GJ2iAygcCpQZOzpf
 fSLNGGHEV62/jFz3saDCelkHsTxfRFkXSy9eXQuHz5rqqxRqV7ESXir94
 QO/4xROKL+du9kGj948P7hy7XhN2uiXQz123/h3EkpljcdV2D0TMxyVwA
 cYyXYYtsvXHVIO9hIfEy4BMF4NDYZlnVsYFosbcZO53lrLfYBHDXYMW2R
 jhNzxiJt2kZ0PTcti5V0HO4DfONF7ctnvnTtU+5L6sNpp1W7Tyyj2jk18
 4Y7GPEG1xXvK5Mk+6YbQccGIWBUdoJq4v90s1yyOHHBNrLqOl9aRcJ08f w==;
X-CSE-ConnectionGUID: 8YSCdjP3SSGUIaTtgW4a6g==
X-CSE-MsgGUID: cGo8wCn8RQC3yClGrc9I7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="98448779"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="98448779"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 08:45:38 -0700
X-CSE-ConnectionGUID: uXFWMFnWRSGPyg6lgUt5CQ==
X-CSE-MsgGUID: GrwFY2SwTnWRnfv1PaPvrw==
X-ExtLoop1: 1
Received: from silpixa00400465.ir.intel.com ([10.20.224.190])
 by fmviesa003.fm.intel.com with ESMTP; 20 Aug 2026 08:45:37 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [dpdk-dev v1] mempool: double cache max size using ABI-neutral struct
 compaction
Date: Thu, 20 Aug 2026 15:45:26 +0000
Message-ID: <20260820154527.1989178-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

commit f5e1310f16e0 ("mempool: improve cache behaviour and performance")
changed the flush/refill algorithm:

  - flush threshold dropped from 1.5 * size (flushthresh) to size
  - refill batch reduced from size + remaining to size / 2
  - effective warm-cache depth after a refill: size / 2

The release notes for that commit explicitly warned:

  "Applications where each lcore only puts or gets to a mempool,
  e.g. pipelined applications where ethdev Rx and Tx run on
  separate lcores, should adapt to the new algorithm by doubling
  their configured mempool cache size, to avoid doubling their
  mempool cache miss rate."

Simultaneously, the same commit noted that the objs[] array no longer
needs to be sized at 2 * RTE_MEMPOOL_CACHE_MAX_SIZE since the new
algorithm never overflows cache->size, leaving half the allocated
array unused.

Perform the advised doubling as a zero-cost ABI-neutral operation:
  - Shrink objs[] from [MAX_SIZE * 2] to [MAX_SIZE] in the struct
  - Double RTE_MEMPOOL_CACHE_MAX_SIZE from 512 to 1024

Result: sizeof(rte_mempool_cache) is unchanged (1024 pointer slots),
but the maximum usable cache depth doubles from 512 to 1024.
Existing callers passing cache_size <= 512 are unaffected.

Fixes: f5e1310f16e0 ("mempool: improve cache behaviour and performance")

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 config/rte_config.h       | 2 +-
 lib/mempool/rte_mempool.h | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/config/rte_config.h b/config/rte_config.h
index 0447cdf2ad..afb26c5218 100644
--- a/config/rte_config.h
+++ b/config/rte_config.h
@@ -56,7 +56,7 @@
 #define RTE_CONTIGMEM_DEFAULT_BUF_SIZE (512*1024*1024)
 
 /* mempool defines */
-#define RTE_MEMPOOL_CACHE_MAX_SIZE 512
+#define RTE_MEMPOOL_CACHE_MAX_SIZE 1024
 /* RTE_LIBRTE_MEMPOOL_STATS is not set */
 /* RTE_LIBRTE_MEMPOOL_DEBUG is not set */
 
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 50d958c7c6..61dfe386c0 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -106,13 +106,8 @@ struct __rte_cache_aligned rte_mempool_cache {
 #endif
 	/**
 	 * Cache objects
-	 *
-	 * Note:
-	 * Cache is allocated at double size for API/ABI compatibility purposes only.
-	 * When reducing its size at an API/ABI breaking release,
-	 * remember to add a cache guard after it.
 	 */
-	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE * 2];
+	alignas(RTE_CACHE_LINE_SIZE) void *objs[RTE_MEMPOOL_CACHE_MAX_SIZE];
 };
 
 /**
-- 
2.43.0

