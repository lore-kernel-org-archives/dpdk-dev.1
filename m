Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B2C71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 04:04:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 284FC42E4A;
	Thu, 19 Jun 2025 06:03:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 33DDD42E37;
 Thu, 19 Jun 2025 06:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750305813; x=1781841813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2roi7Vv16g62yAfyhMwU0qp+NTTUtaaHkFqWPLt0vRA=;
 b=hflt02oYDonW+ZsQ6wKfObRhwSytcxPZ5120yR6sxOm3whOkIfRMHm8G
 valZVtDCvrbmk3I+rKXl6QhcRBkZDPmiMt9Ar/mh+5gnGbSSKAkd/if+Y
 54UV6VGD64KO0UqxeQdcSUPct5bpEqDPFF27+aKZoDSersPlvzxuBiiwM
 Zrh2MqT0LAKtM9X145hAgoTnJ2pO40Nka7cbZF8B0ANLqdoAg6Xyb+iBo
 w8DuEnE3gAIw6lyg8z4jyMd3uAlnZ4ljwD7P+1XWMAd7EbXFgT5BIGYGR
 lvR0W0hW4MPqgLSSZqnc/hDpMZ7b5RuvpU4wyxsxFAHd59IxTachb4yvP w==;
X-CSE-ConnectionGUID: YfuUjuFfSwO4a8AYSlLotQ==
X-CSE-MsgGUID: SUz3gmcmTBKmNaxv7VE2jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="63592767"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="63592767"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2025 21:03:32 -0700
X-CSE-ConnectionGUID: hZgMkD/QQ2mdCe29Y9mhpw==
X-CSE-MsgGUID: bBjC87o0Q4u0nLERsv7ElQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; d="scan'208";a="150665540"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa007.jf.intel.com with ESMTP; 18 Jun 2025 21:03:31 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v4 5/7] event/dlb2: fix to avoid credit release race condition
Date: Wed, 18 Jun 2025 23:03:14 -0500
Message-Id: <20250619040316.317733-6-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250619040316.317733-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250619040316.317733-1-pravin.pathak@intel.com>
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

While unlinking ports, all associated credits should be released.
This commit avoids race condition when main thread is unlinking
while workers are running.

Fixes: a29248b57b31 ("event/dlb2: add port unlink and unlinks in progress")
Cc: stable@dpdk.org

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 drivers/event/dlb2/dlb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index 52edb75fa0..f9bdfb3503 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -2664,7 +2664,7 @@ dlb2_eventdev_port_unlink(struct rte_eventdev *dev, void *event_port,
 		DLB2_LOG_LINE_DBG("dlb2: ignore unlink from dir port %d",
 			     ev_port->id);
 		rte_errno = 0;
-		return nb_unlinks; /* as if success */
+		goto ret_credits;
 	}
 
 	dlb2 = ev_port->dlb2;
-- 
2.39.1

