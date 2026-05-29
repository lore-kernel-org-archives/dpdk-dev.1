Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669D6CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:26:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FD2D40654;
	Fri, 29 May 2026 17:26:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 6916D400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 17:26:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780068396; x=1811604396;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0bHq7rJ18wxOFSvzW8GUlHWsbVFGLwzFKOEzN0GPrBY=;
 b=Fd1OAdOaxl5qEwvfcsGLaJGVPuCqYGwm/czESC20nuQI8ESAXjSHhw2r
 +12ybti0fZuw/qkoArKSxdZbybRzWWtkWRL53Rj9AHes+hSv2FFZowfon
 7n1Naalwm06JkPham6U/CxHPNGbWApAWineMixSWG1QMerJFCBrcDZsoM
 B39Np4pLuUiNsLtVTliQc9ucX7822/k5tw1miknRMA1tuibk6jzyjZ59i
 h06TzO3v7MKx/5zKUASzPLIEr37dX6cPLdRVJaYfJqYMHzNxW0NGll8nN
 9TiEnOpG6xEEPOdSD6qL96ZPep1cMuci9EomcX3VQoqoZ7jhBxoHs/Ufb Q==;
X-CSE-ConnectionGUID: 4Btx2tLwRHKQCQ2fNe3tfQ==
X-CSE-MsgGUID: bIbvplUrRMGgyPHiGpLS9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="91231662"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="91231662"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:26:36 -0700
X-CSE-ConnectionGUID: XtujbRBqTMeDZbV/kX99rA==
X-CSE-MsgGUID: XIAzh+/iTWa5rPDVNNj+xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="236520613"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa009.fm.intel.com with ESMTP; 29 May 2026 08:26:35 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v2 3/5] eal: fix memory leak in async IPC secondary path
Date: Fri, 29 May 2026 16:26:29 +0100
Message-ID: <e82cc7c00a843ae59f642a79ef0749ba1b2af509.1780068382.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <d7204c81e2494027fe467b8e3f5744888059fcbd.1780068382.git.anatoly.burakov@intel.com>
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
index 0ec79336a5..24d3557859 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1203,6 +1203,8 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		/* if we couldn't send anything, clean up */
 		if (ret != 0)
 			goto fail;
+		if (!dummy_used)
+			free(dummy);
 		return 0;
 	}
 
-- 
2.47.3

