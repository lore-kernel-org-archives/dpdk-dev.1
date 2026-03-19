Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41459109024E
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 16:07:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8067A4025D;
	Thu, 19 Mar 2026 17:07:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 2F1B44013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 17:07:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773936442; x=1805472442;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KH8QxhTdJpecW9KfaJUv/TDqDxroqnexmAEhRI8OApk=;
 b=kL3pKK9a8R546+GuECHXII+a88oLkoiPyobW2crMhxkVZoiK5pYStq3a
 t9Hf7cnXSh+94YHxBgnjEaSYF5OrLLI1ACe9yI+VDt9BGljrDwL4StoFo
 0KkLKQHVH2832+2AVycN17tHWLlhhjtGz5VY5ndC/Yl5rLrPHrpYMCXyd
 z9pnZD9fHmFE5BKyemJKw4JR6NQioFoQp+FMJlF9+b/m4QbwZH9bk63ts
 hFTEYa9tD8EwiRatLLoh5f6BuIuYwZhRKixPGX7+XHMfKIYwsiWIHUXtZ
 1azc0L74e7AUFHF2NvtaAjhQYtMEJVbOf92ddBvTI1hBOyAq3va+XeSOG w==;
X-CSE-ConnectionGUID: R/7Y4pvGQtyHJ1mtpINhZw==
X-CSE-MsgGUID: VDWBg6wtQsypNbe4SYgTPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74900625"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="74900625"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 09:07:21 -0700
X-CSE-ConnectionGUID: eOHL7PNQQ6qXMw0fYsFV7A==
X-CSE-MsgGUID: 9DZKQI/pRva7Ml2X7yE1aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="222987039"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 19 Mar 2026 09:07:21 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v1 1/5] eal: fix wrong log message in async IPC request
Date: Thu, 19 Mar 2026 16:07:13 +0000
Message-ID: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

The allocation failure log message in mp_request_async() says "sync
request" but the function handles asynchronous requests.

Fix the log to say "async request".

Fixes: f05e26051c15 ("eal: add IPC asynchronous request")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 lib/eal/common/eal_common_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/eal/common/eal_common_proc.c b/lib/eal/common/eal_common_proc.c
index 06f151818c..799c6e81b0 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -883,7 +883,7 @@ mp_request_async(const char *dst, struct rte_mp_msg *req,
 	pending_req = calloc(1, sizeof(*pending_req));
 	reply_msg = calloc(1, sizeof(*reply_msg));
 	if (pending_req == NULL || reply_msg == NULL) {
-		EAL_LOG(ERR, "Could not allocate space for sync request");
+		EAL_LOG(ERR, "Could not allocate space for async request");
 		rte_errno = ENOMEM;
 		ret = -1;
 		goto fail;
-- 
2.47.3

