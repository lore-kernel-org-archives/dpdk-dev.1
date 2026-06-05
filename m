Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32000CD6E79
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 14:29:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57465402BA;
	Fri,  5 Jun 2026 16:29:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 953564026A
 for <dev@dpdk.org>; Fri,  5 Jun 2026 16:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780669769; x=1812205769;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KH8QxhTdJpecW9KfaJUv/TDqDxroqnexmAEhRI8OApk=;
 b=Sg5x+c/NxCfBwKogcOyIhzhlzWhG9iYFlKP/xvfQMPXoOznPI6JRf/FT
 TZ1Vknuc0GTN7JQdlLXkUTOX8dxo6Z6Z7aBhoteQeGKy/6wSDnE5eZ92Y
 TUHCmVak1seBmhDmZGfbJtN+EZwjK1Vg+l8OrNIsJrLnZI2UGH93dqOgU
 TFERxLyDIJDoqtQpt/NdQkfCfrsCTC+O3BeYlFOuYnu9F22VCxtuInhjU
 3aKvYeml1oMzK6KmdRIdLfHR1eSZbzMpBJq/CAYPxeTcOh+seOXYiZqHV
 Gb8nH8NCDa+d4MWRAaTqyogBEFom2zLBTsAHV31qWs9d0HePTfVcggUmz A==;
X-CSE-ConnectionGUID: iJW8kGVMSg+laZfabf1q7A==
X-CSE-MsgGUID: nCmu+L82SWexlYEwz0D5xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81482614"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81482614"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 07:29:27 -0700
X-CSE-ConnectionGUID: MPE0iNawSIq2DbQ04+z8JQ==
X-CSE-MsgGUID: 1RtyDAJTS46ikkwKT45m+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="242383073"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 05 Jun 2026 07:29:27 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v4 1/5] eal: fix wrong log message in async IPC request
Date: Fri,  5 Jun 2026 15:29:20 +0100
Message-ID: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780669755.git.anatoly.burakov@intel.com>
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

