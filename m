Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E329CCA462
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 14:02:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBBB54065A;
	Fri, 16 Oct 2026 16:02:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 53EFA402DA
 for <dev@dpdk.org>; Fri, 16 Oct 2026 16:02:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792159348; x=1823695348;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HaC7HlJryTKlXeekwjrhz2oLxp++K8s+vGvvoImJBdk=;
 b=IvdsgQn0aeNV9QULrdxMpVosoHIWd2qWg/bdlkUgsbJ6DNMrIX5DZrx+
 KSLF3QhYoKbSKmAV3ZIE52VexcpkyW2SDzu9vNEE4FK1w/gOmgaZwwjrG
 I0ZlFhq/Pfbr+LtH+FsF++/nG72xua8ciI6olFcp+o+Ww2hj45juPbOWE
 f/gPdCIQCUQ1KV4vkL4bw1nakMzLt4i7+2hCwDQ9J1N7YpjoCrgpN/BUj
 cGE//a3IfNR29UwsDaKGnNzqFytniH13AXWcUQyNDP2SbXZd+5OpDkoUw
 4kXmPFTPW57SBNY1EaEdiwnGu54eUJ+lNN/VK13XZdwVUl6ZD9JxmD9cl Q==;
X-CSE-ConnectionGUID: V6LUjzfWSkqIxZGVlRRs2A==
X-CSE-MsgGUID: Z7XHCCKATIKpDWZysK0Hkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="1043668"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1043668"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Oct 2026 07:02:24 -0700
X-CSE-ConnectionGUID: PQFynMXYTSaJr6Zq1ijguA==
X-CSE-MsgGUID: oKsXMCyYTiWMyam02IF71g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1951670"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 16 Oct 2026 07:02:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [27.03 RFC PATCH v1 4/8] vhost: use usage counters for vchan tracking
Date: Fri, 16 Oct 2026 15:02:11 +0100
Message-ID: <d3b9b90ff258d7df86ff30ae825c716904724115.1792159157.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792159157.git.anatoly.burakov@intel.com>
References: 
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

Use EAL usage counters instead of raw integers for vchan tracking.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/vhost/vhost.c | 5 ++---
 lib/vhost/vhost.h | 3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/vhost/vhost.c b/lib/vhost/vhost.c
index 918e50ed43..4535e30d44 100644
--- a/lib/vhost/vhost.c
+++ b/lib/vhost/vhost.c
@@ -2152,7 +2152,7 @@ rte_vhost_async_dma_configure(int16_t dma_id, uint16_t vchan_id)
 	dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr = pkts_cmpl_flag_addr;
 	dma_copy_track[dma_id].vchans[vchan_id].ring_size = max_desc;
 	dma_copy_track[dma_id].vchans[vchan_id].ring_mask = max_desc - 1;
-	dma_copy_track[dma_id].nr_vchans++;
+	rte_usage_count_claim(&dma_copy_track[dma_id].nr_vchans);
 
 	pthread_mutex_unlock(&vhost_dma_lock);
 	return 0;
@@ -2437,9 +2437,8 @@ rte_vhost_async_dma_unconfigure(int16_t dma_id, uint16_t vchan_id)
 
 	rte_free(dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr);
 	dma_copy_track[dma_id].vchans[vchan_id].pkts_cmpl_flag_addr = NULL;
-	dma_copy_track[dma_id].nr_vchans--;
 
-	if (dma_copy_track[dma_id].nr_vchans == 0) {
+	if (rte_usage_count_release(&dma_copy_track[dma_id].nr_vchans)) {
 		rte_free(dma_copy_track[dma_id].vchans);
 		dma_copy_track[dma_id].vchans = NULL;
 	}
diff --git a/lib/vhost/vhost.h b/lib/vhost/vhost.h
index 1f0568dcb5..215a513934 100644
--- a/lib/vhost/vhost.h
+++ b/lib/vhost/vhost.h
@@ -19,6 +19,7 @@
 #include <rte_ether.h>
 #include <rte_malloc.h>
 #include <rte_dmadev.h>
+#include <rte_usage_count.h>
 
 #include "rte_vhost.h"
 #include "vdpa_driver.h"
@@ -202,7 +203,7 @@ struct async_dma_vchan_info {
 struct async_dma_info {
 	struct async_dma_vchan_info *vchans;
 	/* number of registered virtual channels */
-	uint16_t nr_vchans;
+	rte_usage_count_t nr_vchans;
 };
 
 extern struct async_dma_info dma_copy_track[RTE_DMADEV_DEFAULT_MAX];
-- 
2.52.0

