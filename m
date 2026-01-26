Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1288CCF65CF
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 10:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1332A402D1;
	Mon, 26 Jan 2026 11:14:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id BEC1F402B6;
 Mon, 26 Jan 2026 11:14:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769422444; x=1800958444;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=nuWgwRikEMN5/DPomHq/IOz6WmPuua5nruZ0CSyD4ME=;
 b=bUOoV/cYvkWHjaHRbJChKLlVWqqwazc68BPyaNHG0yNm3mJdpLs+Lxjq
 V39G+fNZptA+je5BzZKGpdzHvGPtL7gnL8Ckzyr/teYfiomj7N9a9sLD0
 YF+UpwjHyrYKtKbv0zFtrd+YeUoPD8VyS5n6v9ZCHH+AmCi1YnV8G2uQB
 NCXcXJrtUChnlrDRfl1XTj9WmqTMMr49xkrs18ezGHcxSq4saXA5bcwQ8
 k8MKvqT3PeFteJYCMjJAWDVcc+RDulVFiC0Q1VnrIq3E6HqTIEuAfP7Cr
 CtoBEyT+JQmROfDi+VfAqVveQSxzfuFu26mTzjkI9HiUkDeE4zXo78ZKG A==;
X-CSE-ConnectionGUID: moZ+VkW1TSWD5e69cIWjow==
X-CSE-MsgGUID: 7+OaWk2GTpGcrvgNfiaisQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="74439652"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; d="scan'208";a="74439652"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2026 02:14:02 -0800
X-CSE-ConnectionGUID: fX8NUpcHRyK3TqpYlYcsqA==
X-CSE-MsgGUID: 7oI2vC7JTL+ZsOGTZFe7RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; d="scan'208";a="207893047"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 26 Jan 2026 02:14:01 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: scott.k.mitch1@gmail.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org, Kevin Laatz <kevin.laatz@intel.com>,
 Conor Walsh <conor.walsh@intel.com>
Subject: [PATCH] dma/idxd: mark portal pointer as volatile
Date: Mon, 26 Jan 2026 10:13:56 +0000
Message-ID: <20260126101357.2770431-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <bug-1871-3@http.bugs.dpdk.org>
References: <bug-1871-3@http.bugs.dpdk.org>
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

The portal pointer for writing descriptors to the idxd device should be
volatile for consistency with how it is used. Only time we need to cast
away the volatility is when unmapping it.

Bugzilla ID: 1871
Fixes: e888bb1278c6 ("dma/idxd: add bus device probing")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/dma/idxd/idxd_bus.c      | 2 +-
 drivers/dma/idxd/idxd_internal.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/idxd_bus.c b/drivers/dma/idxd/idxd_bus.c
index 5ae42151e6..9a8213bbbe 100644
--- a/drivers/dma/idxd/idxd_bus.c
+++ b/drivers/dma/idxd/idxd_bus.c
@@ -93,7 +93,7 @@ static int
 idxd_dev_close(struct rte_dma_dev *dev)
 {
 	struct idxd_dmadev *idxd = dev->data->dev_private;
-	munmap(idxd->portal, 0x1000);
+	munmap(RTE_CAST_PTR(void *, idxd->portal), 0x1000);
 	return 0;
 }
 
diff --git a/drivers/dma/idxd/idxd_internal.h b/drivers/dma/idxd/idxd_internal.h
index b80a113455..d409213148 100644
--- a/drivers/dma/idxd/idxd_internal.h
+++ b/drivers/dma/idxd/idxd_internal.h
@@ -56,7 +56,7 @@ struct idxd_dmadev {
 	unsigned short batch_start; /* start+size == write pointer for hdls/desc */
 	unsigned short batch_size;
 
-	void *portal; /* address to write the batch descriptor */
+	volatile void *portal; /* address to write the batch descriptor */
 
 	struct idxd_completion *batch_comp_ring;
 	unsigned short *batch_idx_ring; /* store where each batch ends */
-- 
2.51.0

