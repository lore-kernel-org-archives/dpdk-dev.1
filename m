Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99716CD8C92
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:13:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04FD640663;
	Mon,  8 Jun 2026 15:13:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 91598402AD
 for <dev@dpdk.org>; Mon,  8 Jun 2026 15:13:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780924411; x=1812460411;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=S8XMe+vOJsrJ+4X5ey1ZFTMCOJn+hQsFBV8qWAjhIDo=;
 b=PqsorKUcubie0CWTfNBF0pllqackY/tR1JN1Gw9zL99xiOyvjZoTvHMM
 obhCjw2YdzNyzIlStAc1e98KfHI54Q9OqnzvtbeCm/BdaEzKVkFxkOYl7
 kXoV7PKnaZkU2tQBqGX4TKNR1lPIFnHy8dpadrD7bL/3GWqjvXX6JLWLU
 kgqPu/Oa/BN0QKboEwuS+aKlhBKEZhXl9Q9oYo2Q5vn6fOBLfxbk84H2O
 x9wbkfEjfH+TgbW797QhiuSWHDwyGBuUozO4kaZYL/tYUYsOuHLjodhAZ
 +ZIY6PZ4o5i/2adrZHMvKR/OwPFA0209qQmKZbxCFeQ4mmevjBW3/9bZG A==;
X-CSE-ConnectionGUID: y1nTJFGTSUS2TfpXooV3eg==
X-CSE-MsgGUID: jL+LPTCmQPedz9BEM3bSrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81656721"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="81656721"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 06:13:26 -0700
X-CSE-ConnectionGUID: Lfbj4wrpRFSIJu1kbJShcg==
X-CSE-MsgGUID: oWMKEWTUSMGskVyRevghgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245635485"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 08 Jun 2026 06:13:26 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v5 3/5] eal: fix memory leak in async IPC secondary path
Date: Mon,  8 Jun 2026 14:13:19 +0100
Message-ID: <6c00a4c8a568eef993559eead0319e99c2d94845.1780924381.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2bc77b94493d94b53a28ea535ed96d92a157a7c7.1780924381.git.anatoly.burakov@intel.com>
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
index 2a99162a21..0dd25bef8b 100644
--- a/lib/eal/common/eal_common_proc.c
+++ b/lib/eal/common/eal_common_proc.c
@@ -1210,6 +1210,8 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
 		/* if we couldn't send anything, clean up */
 		if (ret != 0)
 			goto fail;
+		if (!dummy_used)
+			free(dummy);
 		return 0;
 	}
 
-- 
2.47.3

