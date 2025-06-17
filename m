Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C803AC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 18:27:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8515142795;
	Tue, 17 Jun 2025 20:26:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1CAD24279B;
 Tue, 17 Jun 2025 20:26:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750184807; x=1781720807;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FjUwjEZ9tvdY1+6N9G2HG0swHh9Za5X0Zv3o2KJn3GA=;
 b=CKCzZZi6eeeAeNt3DFU0DFa1pyNELV8NQjv+RoYTZL1c20o74Hj79NgW
 bmB8RsNWvJmo94BKEmXa0gnbuYEVJGU1uWHAKYljO2+v4wfnNtZQ413by
 zUzbt1NBCAQ1BqM8PMAkpbuMg0Ujr0l5EqRGDMbJ3AKUjUQTRVfhZu5I9
 9wTX+xV5bC93XghodAclra5F1Ys51exONYs63zs3MO+2689HH5hFUD7X/
 EzDfA7mkm5v2l1T1sbkDVyIV3+E4nOo3qNgHjKRwz+c44od3ZlUovVigx
 LTJpMWCGStMl/C56yAu31PzJ51kVlLy5HZXi+SM6VFJG45hdnVZEqF4Js Q==;
X-CSE-ConnectionGUID: A25DAUCJQ3OEazUsIqo9Ow==
X-CSE-MsgGUID: /gO9yiTDQW6F+SOHaGYoZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="63737742"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="63737742"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2025 11:26:47 -0700
X-CSE-ConnectionGUID: ybHWggktT2SKUQN/byLpvw==
X-CSE-MsgGUID: Afz0XDw3Qgapam5E3jbueg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; d="scan'208";a="153622671"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by orviesa003.jf.intel.com with ESMTP; 17 Jun 2025 11:26:46 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v3 5/7] event/dlb2: fix to avoid credit release race condition
Date: Tue, 17 Jun 2025 13:26:28 -0500
Message-Id: <20250617182631.257612-6-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250617182631.257612-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250617182631.257612-1-pravin.pathak@intel.com>
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
index 28c9054f63..6734e93eac 100644
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

