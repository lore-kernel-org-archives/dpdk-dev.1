Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B85C9830E
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Sep 2026 08:58:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFA3B40BA6;
	Fri, 25 Sep 2026 10:58:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C33CD40B9F
 for <dev@dpdk.org>; Fri, 25 Sep 2026 10:58:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790326735; x=1821862735;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=VhZuKtiNF6kI55grFvts+jiPUZXGqyBRIIIxaOJm2qQ=;
 b=iiT8usQZk3rmGXDyHFgM+1YXmgBcZtITENjQ7jmmAIDWJ0sM6YmSwkgb
 JAPoLeUHu7iYw1N/J+9V02Z0O0MyrwTd0v/mGIe2S66nvN/daNAiOLSzo
 5yxMXQ1tIgsGFggSYQSvuc/kHuqDBCIhnQBipo4bUtAw7Ainm2thwHV1z
 9EGrinR/pM2aylAWnPgNJ7eeAzFtYOlA2alp+OM/tJHWvwC0muu8lw6bA
 9GzSm+wPt7cPyoOdGZ3WKPyB8ThnQwe1Edmbq4gHiRZPVNoBM7Yn7Ht0s
 evtOBFSuDmJk5BNMmoaeM3pClM3vXW09Cp2jo0bRkzSvxV3nrmcj2Yij7 g==;
X-CSE-ConnectionGUID: bkLZ3HqqTn21C2HsuugbTw==
X-CSE-MsgGUID: 57tpIoeCQjuje0pMIzGrhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90329908"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="90329908"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2026 01:58:54 -0700
X-CSE-ConnectionGUID: SXhoAoKrRMOmLCjnlVLbvg==
X-CSE-MsgGUID: Wtw4WMdDRhy6wHJQhupQXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; d="scan'208";a="272408364"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 25 Sep 2026 01:58:53 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: anurag.mandal@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/iavf: fix dead store on reset path
Date: Fri, 25 Sep 2026 08:58:32 +0000
Message-ID: <20260925085832.6780-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

When dev_start fails during reset recovery, the code defers the start
to the next link-up event and resets ret to 0 to avoid treating this
as an error. This is redundant since ret is unconditionally
overwritten by the return value of iavf_post_reset_reconfig()
immediately after. Remove the dead assignment.

Fixes: 9aac2219dc2a ("net/iavf: defer device start when PF VSI not ready")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a8daa507bb..7915aef348 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3513,7 +3513,6 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 				    ret);
 			vf->start_pending = true;
 			dev->data->dev_started = 0;
-			ret = 0;
 		}
 	}
 
-- 
2.43.0

