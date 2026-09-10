Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9DAC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 15:08:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7E6D427BF;
	Thu, 10 Sep 2026 17:08:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7411C4025F;
 Thu, 10 Sep 2026 17:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789052917; x=1820588917;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Jf5xaMnOd7phj5/C+Js8VaZtxDCMCf+TtWFpV9Hmw4w=;
 b=JUUlVjuWyBo84ZNJedUBotY8E9FpG3hUEzAj/fGE9VAhj3ojNwsxunOf
 HZsEq5EERtN5RyIa6tuyIxjhyzzDs0V7Hnv9LeesFCaqwshL9ec/YI+ip
 ftpYgu9oEzmm/gLEDJdJchyDxF+77Everzq2OfvWsJ5xUKLLa+TBJZPL6
 rzxRuK47UIbGY05Asfo702L/tliGvUsoVjJx7/T8FIb957DUBawaPvZAE
 lecR39T2LPqWfKiYd/pv+3bSg6I6fg8NlKy7EHG1Cgpmb/DRClJc21y0O
 ijaMnxkZmAthIKBFUoDVdVU3lg9dodweqV/6DC2cJOA+HHjBXCh7OpvHS g==;
X-CSE-ConnectionGUID: hqOvXkFFSIeEPVL52TQawg==
X-CSE-MsgGUID: gm3+8MoKSYyNEpK9nDbe8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89438673"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89438673"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 08:08:36 -0700
X-CSE-ConnectionGUID: MejvrESsS42r7IugJQpdHQ==
X-CSE-MsgGUID: YgZHjQMTTRCNuWZdsbnR3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="270312446"
Received: from silpixa00401385.ir.intel.com (HELO
 localhost.ger.corp.intel.com) ([10.20.227.210])
 by orviesa010.jf.intel.com with ESMTP; 10 Sep 2026 08:08:34 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Kaiwen Deng <kaiwenx.deng@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH 1/2] net/ice: check for missing fixed speed setting
Date: Thu, 10 Sep 2026 16:08:16 +0100
Message-ID: <20260910150817.1521317-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910150817.1521317-1-bruce.richardson@intel.com>
References: <20260910150817.1521317-1-bruce.richardson@intel.com>
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

When the user requests a fixed speed for a NIC link, the speeds bitmask
passed must have a speed value actually set in it, as well as the
"FIXED" flag. Catch this case and log an error message.

Fixes: 36afbc269081 ("net/ice: support link speed change")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 76b8ff0a72..dc955d130b 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4936,6 +4936,10 @@ ice_apply_link_speed(struct rte_eth_dev *dev)
 					RTE_ETH_LINK_SPEED_100M;
 	}
 	speed = ice_parse_link_speeds(conf->link_speeds);
+	if (speed == ICE_AQ_LINK_SPEED_UNKNOWN) {
+		PMD_DRV_LOG(ERR, "No valid link speed setting specified");
+		return -EINVAL;
+	}
 
 	return ice_phy_conf_link(hw, speed, true);
 }
-- 
2.53.0

