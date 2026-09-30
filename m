Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096E9CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 16:50:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16D0240A89;
	Wed, 30 Sep 2026 18:50:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4277F402D9;
 Wed, 30 Sep 2026 18:50:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790787036; x=1822323036;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=8Q5gzLuqC7drARIyaoBZoT2oK3a5dyRbefSBu0IphJI=;
 b=Rou1DQbMTMXcUtVerUp+/vRFquUHROWwNmphR4qxgu01GN3kHRaRZ80S
 z6tboBFG/z1dqXN4lK60y0eMfLbf1FMlRJdBs201D/SvdE94P1sz8P3CR
 qBHAdwI3i7V+oKZ2lpoRZKlL4BroXHzEH1Qd/zNPmmJi99C5ltL6AZnX5
 +0XomD+75t/eQGfj8F0mp9n4By/nwDVcMzXnLdhO7/6yfwYTtxfG1WaxN
 LTAsG4/1DC5cT8NHocKj40qqE9UhboB+J2QsXNUgQ4IyG/acU+1/sOeFh
 2/43XVB4XUs7Zuwymt7TKvxu8V7CDTUonHXlOhZPwMS/GIoq5VV76ey1R g==;
X-CSE-ConnectionGUID: 6HSxhXLJRgC/QCeWfLz80w==
X-CSE-MsgGUID: qo3hzSskSXyF2giAKNIUbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="107915795"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="107915795"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 09:50:35 -0700
X-CSE-ConnectionGUID: 26JcEnNSSzOrovZGlmUhGw==
X-CSE-MsgGUID: S1VkT69sRwyvn2WUjwupNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; d="scan'208";a="275782374"
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by orviesa009.jf.intel.com with ESMTP; 30 Sep 2026 09:50:34 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>, stable@dpdk.org
Subject: [PATCH] net/ice: fix PHY capabilities buffer leak
Date: Wed, 30 Sep 2026 16:52:30 +0000
Message-Id: <20260930165230.342989-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
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

ice_phy_conf_link() allocates the PHY capabilities buffer and only
then validates hw->port_info.
If hw->port_info is NULL,it returns directly without freeing
PHY capabilities buffer causing the buffer leak.

This patch fixes the issue by moving the hw->port_info NULL check
above the PHY capabilities buffer allocation.

Fixes: 36afbc269081 ("net/ice: support link speed change")
Cc: stable@dpdk.org

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 2c5ffe07f3..dd23a7555c 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -5253,14 +5253,14 @@ ice_phy_conf_link(struct ice_hw *hw,
 	u64 phy_type_low = 0;
 	u64 phy_type_high = 0;
 
+	if (!pi)
+		return -EIO;
+
 	phy_caps = (struct ice_aqc_get_phy_caps_data *)
 		ice_malloc(hw, sizeof(*phy_caps));
 	if (!phy_caps)
 		return ICE_ERR_NO_MEMORY;
 
-	if (!pi)
-		return -EIO;
-
 
 	if (ice_fw_supports_report_dflt_cfg(pi->hw))
 		err = ice_aq_get_phy_caps(pi, false, ICE_AQC_REPORT_DFLT_CFG,
-- 
2.34.1

