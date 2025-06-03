Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCF3C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 18:05:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CEC44275B;
	Tue,  3 Jun 2025 20:05:28 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BC0E742670
 for <dev@dpdk.org>; Tue,  3 Jun 2025 20:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748973926; x=1780509926;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5KUjaGEb7YPRV58IHUVr7p5yhMC21WnqMB9qA8cSoWA=;
 b=Ff5nNZQhLofPdu9kDmxk3144QGOBkbNBQmeUxxfK7HcMyWCjFM7L49Y8
 NLkHSZltcFGko92nWiOY/RUeKq7Wz5Hu8aZFv5RI2eCyMIMX7rrlJJsV8
 avWSytAmoJzygS7guGdY5KY4HRtdwvORUScjz+jyyhavYj6XQiSiYW226
 aHrLWHrwjVMNKC8KalwFUCuiTqV0i6VFlToID6x7BUZSmaHE16caxfDPA
 plSkpnps6HrQur8Z1X1NtjWS3gnobl2QGebN/Qr+JmuFXB7EUgmLH4KFm
 Dqv0gAw4f2oFYwB2E3LBpeZBc0cYn0WmFpNXZhEFQvuVuyzed8/ICuYs9 Q==;
X-CSE-ConnectionGUID: bepTVuv7TN2qlaub4nC63g==
X-CSE-MsgGUID: MMvqo+00RDKiLZVfZOcuiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="68463599"
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="68463599"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2025 11:05:25 -0700
X-CSE-ConnectionGUID: dUJO+XjWQ5SBRdkIbsYWMA==
X-CSE-MsgGUID: slm59cgpQEKaRvezTABhMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,206,1744095600"; d="scan'208";a="168110490"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa002.fm.intel.com with ESMTP; 03 Jun 2025 11:05:24 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>
Subject: [PATCH v2 5/7] event/dlb2: avoid credit release race condition
Date: Tue,  3 Jun 2025 13:05:12 -0500
Message-Id: <20250603180514.3826917-6-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250603180514.3826917-1-pravin.pathak@intel.com>
References: <20250509042401.2634765-1-pravin.pathak@intel.com>
 <20250603180514.3826917-1-pravin.pathak@intel.com>
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
2.25.1

