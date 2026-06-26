Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1D8CDE008
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC5A840674;
	Fri, 26 Jun 2026 12:34:13 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 47BC840659
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:34:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782470050; x=1814006050;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=HWihNWjKpbvqemRn2BI9FeygnZM21vlszM37dAeNk6Q=;
 b=XxG5IXb++Iiyc95fo8UM/tRt+PmOtmfJin7hTMuq7RllUsmt6by+WMfo
 IozEKCgepb9GWn5O2rOoUjmYYqLp3Z+PZI/d7NwS3gTEbE3O6a0JtRvUU
 q0H70uDBq/sX/x0PH1aOwWSY6dqrWM9sWQ9NmuQ+2C3TbL5WMgGtq5km6
 ENtbnnaWgl65KJefuVxnGD8S5poafxjN2eWtX4pxaTdX1zVc4C8RDsVe+
 t0Z2CXLTfEGbe7T/LEXFI6r2lsc6czaKpxecsVR2W6vtb/ptC3rQHDZaa
 X/YeuYkthEAAt7VqwLw+/vilPHDflqQSr4vuKHzCtVbGl+JUHBzYaKnph g==;
X-CSE-ConnectionGUID: Crzi4LY7QS6HRJ0OKQvKRA==
X-CSE-MsgGUID: B7W2Wq5GSNq/eCm+CX2TyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86941974"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86941974"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 03:34:10 -0700
X-CSE-ConnectionGUID: fSZ9Y7T8Rl67Nq9rXGIh6A==
X-CSE-MsgGUID: nD7olJ3TS+eUgdGZVZ86GA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281383974"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Jun 2026 03:34:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v7 5/6] eal: fix memory leak in async IPC secondary path
Date: Fri, 26 Jun 2026 11:34:00 +0100
Message-ID: <2494911b927426249517652643ddaad9d213d62b.1782469943.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782469943.git.anatoly.burakov@intel.com>
 <cover.1782469943.git.anatoly.burakov@intel.com>
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
index 0cffc7a127..8902159386 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1212,6 +1212,8 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		/* if we couldn't send anything, clean up */
 		if (ret != 0)
 			goto fail;
+		if (!dummy_used)
+			free(dummy);
 		return 0;
 	}
 
-- 
2.47.3

