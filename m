Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0EFCD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B62E440672;
	Thu,  4 Jun 2026 18:32:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0CAE940269
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:32:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780590745; x=1812126745;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=cnIJdwAMNMRGHjCm9vcr2UBwzQp1/9igKZOYQJ3A8EI=;
 b=PXSp10x7hogxwr5Qx1mvrKmk7t3TSesNbOQh9+/Jef3BuCdHc+f8gdyO
 5I7CPPryCg6ufc5oxYJC4nLYkAvWc4vJ5tjjK+K8jg9UJR28bWeDqXzcH
 /cQZ9r0CfvQlSA9Mi1LWvvCW4dywOm28uS8ZpZhIqdBoTutuPStU9JjDC
 +scnsgbjD8ZraNXFykt4iizkEcqunn6KuYLDnNHqq0V8sVwn8ImiDTv3Q
 rrA7kLQPSz97KMHvi7QXAO5wWeYD4dm1Ko4S8lxBuNsTEc0E5tNfqtVhQ
 Wgrvfr/iTVbH7aDKbBZlkVd1TDLGrZ8YKIOliwyPqMyjK/fV2RIbxfkw2 g==;
X-CSE-ConnectionGUID: sW8J1S3+TNqattX2i5hCqA==
X-CSE-MsgGUID: psC7K19SSZWHGvIntig9Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85275777"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85275777"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:32:25 -0700
X-CSE-ConnectionGUID: qHqpFQocS4CPczDJq18CnA==
X-CSE-MsgGUID: oY7ilByMS8qnix5dGOACug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="244701689"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 09:32:24 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v3 3/5] eal: fix memory leak in async IPC secondary path
Date: Thu,  4 Jun 2026 17:32:17 +0100
Message-ID: <6b8e8249668106ce452f3845fa2d48c7e2311397.1780590727.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780590727.git.anatoly.burakov@intel.com>
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

When rte_mp_request_async() succeeds on the secondary process path, the
dummy request is freed only if it was inserted into the queue. However,
when the actual request was sent successfully (nb_sent > 0), the dummy is
not used and the function returns without freeing it.

Free dummy before returning on the success path when it was not inserted
into the queue.

Fixes: f05e26051c15 ("eal: add IPC asynchronous request")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 5cc15a0f78..02adcb9ba8 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1209,6 +1209,8 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		/* if we couldn't send anything, clean up */
 		if (ret != 0)
 			goto fail;
+		if (!dummy_used)
+			free(dummy);
 		return 0;
 	}
 
-- 
2.47.3

