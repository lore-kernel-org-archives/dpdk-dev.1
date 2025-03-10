Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668ACC282DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Mar 2025 13:25:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D83D4021F;
	Mon, 10 Mar 2025 14:25:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id AFEB040151
 for <dev@dpdk.org>; Mon, 10 Mar 2025 14:25:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741613156; x=1773149156;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=waJUtlBTb5raNSXJjMNgOD5QpjuNrNJRq6bbRvOe+wE=;
 b=BVhJRFSqqBB8x6PyYsb9ZsCHzMPnAXdZQe2KNWJdD4EJz0V5CXmNzdHQ
 5qsWR08/lIwhUUtM9F9EIlVtf5sKGIVp+wDvXYK5WmEtDdcGaEOdefGIZ
 gyA/Q0/NbOPtdg3gdQPL9bScgU2R7dhN6vXqyDkdm4Q1+Vnq0gY7336zy
 8bA/RZUiQ26vg7feNMi9w/vNmq8ZIMR8Pe3JqUP8CPnxmy2vmNOKAStp4
 kxoKIawZ5x5l/VkRgHp8JS0/3RQ4XvaRhlqG96Zy5yaN4O12IqQSd4AKH
 Q76SYVgFiJTkm0HvzEr7I/OkdN5TCk6i3iGFijYYtLeYXEjphRs8iP3d4 Q==;
X-CSE-ConnectionGUID: alry1ipzToqNdUCm+r3BtA==
X-CSE-MsgGUID: XQ16UntFQFGoxhbb0gnq/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53597354"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="53597354"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2025 06:25:55 -0700
X-CSE-ConnectionGUID: vNLM8MVNQ1eh6zH7ufXOUA==
X-CSE-MsgGUID: drfXizB1QZ2qHqe8ntGjLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; d="scan'208";a="119829935"
Received: from silpixa00401217.ir.intel.com ([10.55.128.45])
 by fmviesa006.fm.intel.com with ESMTP; 10 Mar 2025 06:25:53 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, mb@smartsharesystems.com,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] net/intel: allow fast-free to empty cache
Date: Mon, 10 Mar 2025 13:25:40 +0000
Message-ID: <20250310132540.1341258-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
References: <98CBD80474FA8B44BF855DF32C47DC35E9FA63@smartserver.smartshare.dk>
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

When freeing transmitted mbufs, there is no reason to send the freed
mbufs directly to the ring if the cache is empty - only if it is zero
size (in which case the cache pointer is NULL). Therefore, remove the
empty check and only check for a null cache pointer.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index d9cf4474fc..d361fe64ab 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -143,7 +143,7 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
 		void **cache_objs;
 		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp, rte_lcore_id());
 
-		if (!cache || cache->len == 0)
+		if (cache == NULL)
 			goto normal;
 
 		cache_objs = &cache->objs[cache->len];
-- 
2.43.0

