Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBA7109024D
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 16:07:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 184CC40430;
	Thu, 19 Mar 2026 17:07:27 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3C8E4402EE
 for <dev@dpdk.org>; Thu, 19 Mar 2026 17:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773936445; x=1805472445;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0bHq7rJ18wxOFSvzW8GUlHWsbVFGLwzFKOEzN0GPrBY=;
 b=BgbFpdzGZaZn4AQkZ+xytS/toENdAXHIpedCDjvZ+6N4FxaIIeKWCfXE
 9bhjl9xmnhMoHqjj5G1VM8pbmq7mlj+w3Mrhq3YUXV9YlVNiytKbXYLW3
 SPvTJDezcZkqOcDwhDHzpEv9GvxUq6bxr6Ja2XwaPU2b34PTfGN04lWmF
 mscycYlCxGBeoKcaVGbg2i6IegsLOA8zLIzocjy6hI53GiPsIvuhZhLjF
 7En0TBzsOenZSXB/cRIHXtJLhji/fhuIRQeOJ+GSpVqt2ZPYep30ofIjL
 93ydaAg06/wr3zAh6e7sjSsa4SZvyKglg70g93+06ClHQfvTVtXgTIWb8 w==;
X-CSE-ConnectionGUID: yb2RuSLESQmz9a2PAvT+uQ==
X-CSE-MsgGUID: 4jZtE6MKSg6taTOMvbOQDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74900632"
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="74900632"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2026 09:07:23 -0700
X-CSE-ConnectionGUID: WB5t7919QeC2yFa5xDhf8w==
X-CSE-MsgGUID: MXVb+9xnS2+zUo1xk9fA3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,129,1770624000"; d="scan'208";a="222987054"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 19 Mar 2026 09:07:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Jianfeng Tan <jianfeng.tan@intel.com>
Subject: [PATCH v1 3/5] eal: fix memory leak in async IPC secondary path
Date: Thu, 19 Mar 2026 16:07:15 +0000
Message-ID: <f3e2d56c35d1a8b9fda4e540c6c18a61dd4eef59.1773936429.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <740b39c5098b4d40cafb9881ad70865a3c889012.1773936429.git.anatoly.burakov@intel.com>
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

