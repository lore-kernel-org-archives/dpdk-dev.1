Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9466ECDE00C
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 10:34:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A1FA40649;
	Fri, 26 Jun 2026 12:34:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 20E574025F
 for <dev@dpdk.org>; Fri, 26 Jun 2026 12:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782470046; x=1814006046;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KH8QxhTdJpecW9KfaJUv/TDqDxroqnexmAEhRI8OApk=;
 b=FKqQPKNhYpkkZtlaFNBlZXIrdlOumL3OUUcwxemFLj4kQAjsLVpjoW24
 fWRISfzmh4EsxTMcKG7OT0LTbso/bOANWcBpRM1ifToMCI1UuPsfw1d9D
 k2l6sQeGgRdZetQuQtlg694RnQKAFFJYUjbX5751ro2LtfZjNHmmBtmzA
 Rc6zi/l7tHHjtGaQdEtlSTiVC3jlnNlEsOHjtNA5ko60SptU3RUv+80cU
 w5ymFlud2VhgBHg5Su5HMy/CRwqx5nOtX8BDRNZ2i/aUEAliDhRxWv2Jl
 NCoDl2Ci+RS+lNuafjAI+UOXZ3WH6H5L6dYRAZa0wFDKxHLXcc/8ninS+ Q==;
X-CSE-ConnectionGUID: 1QEdLw3VSa+iI3/yI6EDNQ==
X-CSE-MsgGUID: 6gK2/iFCR5az4yQWUf8X0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="86941965"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="86941965"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2026 03:34:05 -0700
X-CSE-ConnectionGUID: ork6UJicQ+qiOoEcIp/tbQ==
X-CSE-MsgGUID: lmpIpF5PRaC0CtbFyNMSWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; d="scan'208";a="281383955"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 26 Jun 2026 03:34:05 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v7 1/6] eal: fix wrong log message in async IPC request
Date: Fri, 26 Jun 2026 11:33:56 +0100
Message-ID: <de2fe2bff93d45973ead1cbf5eda74de4e18dbe1.1782469943.git.anatoly.burakov@intel.com>
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

