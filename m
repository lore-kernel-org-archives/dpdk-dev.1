Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902ECCDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 14:02:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94AA040698;
	Thu, 25 Jun 2026 16:01:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 15A45402B0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 16:01:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782396113; x=1813932113;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KH8QxhTdJpecW9KfaJUv/TDqDxroqnexmAEhRI8OApk=;
 b=dmkuch2VExCkiuHHeOf5z5YJoIZIfty3MA1bqL7iV1yfSQcLxoNoxxNA
 UVDubt0mU5DzTJAOMgVbGwaKAmqB5l172fJcsDYk1QiXBlcnrBew/XPjU
 kXTDCBdl1yh+agn/15wnc/9I9JAcNUDlCqIMmHFF5YnJ86CG5Hv1H0X/5
 2B+/wuEQUTjtnUNtnKrNcQNxsJMIBO9RBa+SOQDhRZq+pMr0TrXRtRHvj
 hYSNLbWaLo8kM3Zz54de9pI8Sn/ScKKtoFozUkT11XES50U+Lw0lqhMXT
 o3p+OuC/zYnRAJOJpYra0rOHTk7yXJ3rF806kbAFnbUiw0/Hs91p/QG1F Q==;
X-CSE-ConnectionGUID: UZ1fRORqTRu15DtDsJpnvQ==
X-CSE-MsgGUID: WPUimwP0ShevgWU8HL7yYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83225256"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83225256"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 07:01:53 -0700
X-CSE-ConnectionGUID: 6xCGuNOQRb+JEFR9woBc4w==
X-CSE-MsgGUID: qJIJkFRXQLStACwGHwQJ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280908042"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 07:01:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v6 1/6] eal: fix wrong log message in async IPC request
Date: Thu, 25 Jun 2026 15:01:43 +0100
Message-ID: <8ea92e5bb4d1e18627c44083bd176464f50dcf34.1782395581.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1782395581.git.anatoly.burakov@intel.com>
 <cover.1782395581.git.anatoly.burakov@intel.com>
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

