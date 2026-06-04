Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED62CD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:32:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6381402CC;
	Thu,  4 Jun 2026 18:32:25 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8A83640269
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:32:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780590744; x=1812126744;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KH8QxhTdJpecW9KfaJUv/TDqDxroqnexmAEhRI8OApk=;
 b=J1P+JDAHMYL0h8qr9aUce0AkPIG0gE7sotW0eTPMUHdW5ZmmWH59NHET
 ibhxQPmbpW9+tCIBdEZvrQ6SAl2qP4B36NO4Thwr0bT2piI/54lX0eg60
 vh1KdBOxSr1Q/v6P3DmDzKiGfNuGK8AU2SAwayTwqmZhLLB1UAZdFgAO8
 /2pDEaxwzBfNRtcTliVkKup6CmZR03Tjb8MbVQQvlX8qryaNe0k+H8+Ca
 UfGuCtds2Jdd37AlLDN9JrbZxMwNxIopFo8zgr0Wg+/1XttCDaz7bNlHk
 jlu+13tgLEunNsjHowbfk5nrpqlSW4jZqdsFoggu2oCGtQoq+NlPvUnlY g==;
X-CSE-ConnectionGUID: aefABbddRfuBw4uhTnrBHA==
X-CSE-MsgGUID: jEVhXgVpQdmTNX5l3uFjaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85275774"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85275774"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:32:23 -0700
X-CSE-ConnectionGUID: LxKXcTcTSH+pH3QUPZOlDA==
X-CSE-MsgGUID: 0obpjOW0S6ixux6Nqc9CnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="244701676"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 04 Jun 2026 09:32:22 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v3 1/5] eal: fix wrong log message in async IPC request
Date: Thu,  4 Jun 2026 17:32:15 +0100
Message-ID: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780590727.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
References: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
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

