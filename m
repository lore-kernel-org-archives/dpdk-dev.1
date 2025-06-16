Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D65C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 09:55:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A86A340616;
	Mon, 16 Jun 2025 11:55:53 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id AE53440292
 for <dev@dpdk.org>; Mon, 16 Jun 2025 11:55:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750067752; x=1781603752;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bIcB6CLMcDgunzamFQo3ApcV2mX7NsbJizOmVHjC8bY=;
 b=N1OeUmGZahq4QO/3UosY5HorYb4Vd98yUk070CKyijES6zuxwtSivvJo
 MpUWkp1fCyMctw0KpEs+KYfEfW+RmiHyTm8VWlWYlCy7/gtZBPHAwoC72
 92AGwIjHdkWeHQhiy1zkaRDKtD7tY+EkfjdbM1JDgOUEEcgVhbrFBoy4F
 VKw4XDfjpexk3sVbPorQZNwJYH2eDl4/AeD99J9xbaafxuZNxO8e1nqQP
 9lKKazK/K+VJkMD7cQa8jMH4LFP/mtfCeoNFd+b+4GkfV2KdPN+goyqmc
 c3G2r2z8LVOveo3QglPt9BpkZGzoAW4h6iGMl/JFo6DWwHzny9KAsx5Op A==;
X-CSE-ConnectionGUID: PJt795NzROW8GzN/uN4iuA==
X-CSE-MsgGUID: hh5kpSmWReazIpotSUv5Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="63238160"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="63238160"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 02:55:51 -0700
X-CSE-ConnectionGUID: lfMS1y+9TvGLr/uiD9yUyw==
X-CSE-MsgGUID: D+q2fFR2RqKOpdRkyRz/Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="149306767"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa008.jf.intel.com with ESMTP; 16 Jun 2025 02:55:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: [PATCH v1 1/1] malloc: handle invalid socket ID's when allocating
Date: Mon, 16 Jun 2025 10:55:48 +0100
Message-ID: <02ee77dec888cd2ece830f63c5163c4ad7d3d3a5.1750067739.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
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

This issue was reported by static analysis. It is a false positive,
because both `rte_socket_count` and `rte_socket_id_by_idx` only report
information about physical sockets (so return value of -1 cannot happen,
as we only get into this function when socket ID parameter is -1, which
excludes external memory from consideration), but to avoid future false
positives, we can fix it here.

Coverity issue: 470137

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/malloc_heap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/eal/common/malloc_heap.c b/lib/eal/common/malloc_heap.c
index f87a947a42..13a56e490e 100644
--- a/lib/eal/common/malloc_heap.c
+++ b/lib/eal/common/malloc_heap.c
@@ -710,8 +710,9 @@ malloc_get_numa_socket(void)
 
 	/* for control threads, return first socket where memory is available */
 	for (idx = 0; idx < rte_socket_count(); idx++) {
-		socket_id = rte_socket_id_by_idx(idx);
-		if (conf->numa_mem[socket_id] != 0)
+		int ret = rte_socket_id_by_idx(idx);
+		socket_id = (unsigned int)ret;
+		if (ret != -1 && conf->numa_mem[socket_id] != 0)
 			return socket_id;
 	}
 	/* We couldn't quickly find a NUMA node where memory was available,
-- 
2.47.1

