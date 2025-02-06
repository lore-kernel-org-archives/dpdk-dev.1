Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C3BC02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64790410D4;
	Thu,  6 Feb 2025 17:09:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 7946140FB5
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858156; x=1770394156;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=/eXq3nBwZHgDAR+4l0uCTxC3ito6aXO3ibqbl/kr+8w=;
 b=ilh2rXbfvRr4p0kIUIF0wrtV2l7Ti7oQBpTf5K9bY8QHdLHCIjP+2bRU
 2vu5sPaW97vAV43VjAAhjBFP7cykJo/7yyLEgMPKJNwqFSZVbkDAs83Qv
 OXJlNvn/U3E7ZaEKOlazFWCjs5gUSd/KY8fAN+Br8ekhzFJaXSsbiPAcY
 etmGsoMc+5Ub84AyVVeb8hYW4h8SakYqMgIw+p9TbIQEMWavF3yHenAlG
 l4CU4fiSBxx6E4+QdAdlqyp561Pg7pPAACerRgmrdrmZJsGF8dr88DI6S
 17A8wlquJfEiaBKM4x5vjU85yOX6Lui0C6hfW39p4Cyw4oR7eHW+IkDhV A==;
X-CSE-ConnectionGUID: sdKkv6FsT2CTsPiMIfUTnw==
X-CSE-MsgGUID: k9nuhndeTQO/NS9fRTQMWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860727"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860727"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:15 -0800
X-CSE-ConnectionGUID: GMrW/QihTdiQeiakdDJNKA==
X-CSE-MsgGUID: Bn7ieBq1R3ih1H0tB34emg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166742"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:13 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Alvin Zhang <alvinx.zhang@intel.com>, Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 10/24] net/igc/base: fix iterator type
Date: Thu,  6 Feb 2025 16:08:33 +0000
Message-ID: <a363061e183bcee5dc27cac684647b70be529fc5.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

From: Amir Avivi <amir.avivi@intel.com>

Fix static analysis warning about comparison between types of
incompatible width, which might lead to an infinite loop due to overflow.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Amir Avivi <amir.avivi@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 .mailmap                             | 1 +
 drivers/net/intel/igc/base/igc_phy.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 3faff80f0e..23ec118ebc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -84,6 +84,7 @@ Amaranath Somalapuram <asomalap@amd.com>
 Amine Kherbouche <amine.kherbouche@6wind.com>
 Amin Tootoonchian <amint@icsi.berkeley.edu>
 Ami Sabo <amis@radware.com>
+Amir Avivi <amir.avivi@intel.com>
 Amit Bernstein <amitbern@amazon.com>
 Amit Gupta <agupta3@marvell.com>
 Amit Prakash Shukla <amitprakashs@marvell.com>
diff --git a/drivers/net/intel/igc/base/igc_phy.c b/drivers/net/intel/igc/base/igc_phy.c
index 706f037f0e..dd56b994af 100644
--- a/drivers/net/intel/igc/base/igc_phy.c
+++ b/drivers/net/intel/igc/base/igc_phy.c
@@ -2366,7 +2366,8 @@ s32 igc_phy_has_link_generic(struct igc_hw *hw, u32 iterations,
 			       u32 usec_interval, bool *success)
 {
 	s32 ret_val = IGC_SUCCESS;
-	u16 i, phy_status;
+	u16 phy_status;
+	u32 i;
 
 	DEBUGFUNC("igc_phy_has_link_generic");
 
-- 
2.43.5

