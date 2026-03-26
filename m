Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A2110A88FC
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 18:20:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 256A540297;
	Thu, 26 Mar 2026 19:20:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id CCBFA40274;
 Thu, 26 Mar 2026 19:20:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774549247; x=1806085247;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/3as6nug3T8mzxkKwVo31F8Z7ztF7+EZ3FgwVvJA2ho=;
 b=eRm+01RCyy2CsYwXSvOLZj5SEHyr4/7mMBPRH4STf11lpZBX3tc8rK3w
 fekSZmVvCa5I38WiSVezGEwAjXnzzwbmaBlheXFB6gAnfY7K8xlEwzNyU
 UGo2MTo/BhhtsD8z4AdVe5N+/X3n0XmhsKPpNRceB4yyC5fi5yTpsv83e
 NUeFZeqnDAK2XNmIJrZxGBt2ImhG5e1v2NrjVndqMiLKLjblaVAFIv8Dt
 ofUfyoGdB//tkK2okiR6w3syCbds4PlOY10HgXxBsWntrGQl+iYLP/S5w
 LaNSAB8cVRh+hgGyKV7FAGsUJaeOCnIrFSpZyOHB2U05czDjYAnhjCV79 w==;
X-CSE-ConnectionGUID: ct/vbeQZTnmt6CwaNEnJtA==
X-CSE-MsgGUID: 1kSSCfRZSJmLvBQIKWOTug==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="101076943"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="101076943"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 11:20:46 -0700
X-CSE-ConnectionGUID: RbPOBTwSSCincOsWU1P8KA==
X-CSE-MsgGUID: 9AuZI8hbSPuMBlzSyRw0RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="222169267"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 26 Mar 2026 11:20:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: anatoly.burakov@intel.com, Bruce Richardson <bruce.richardson@intel.com>,
 stable@dpdk.org
Subject: [PATCH] net/ice/base: fix double HW reinitialization
Date: Thu, 26 Mar 2026 18:20:35 +0000
Message-ID: <20260326182035.726123-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

After downloading an alternate scheduler topology, the HW needs to be
reinitialized. Since commit b47c1229d617 ("net/ice/base: improve global
config lock behavior"), a reinitialization is done in the topology
download code itself, so we need to remove the extra initialization from
the calling code.

Fixes: b47c1229d617 ("net/ice/base: improve global config lock behavior")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/base/ice_ddp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_ddp.c b/drivers/net/intel/ice/base/ice_ddp.c
index 68e75be4d2..ae80d93656 100644
--- a/drivers/net/intel/ice/base/ice_ddp.c
+++ b/drivers/net/intel/ice/base/ice_ddp.c
@@ -1359,10 +1359,6 @@ enum ice_ddp_state ice_init_pkg(struct ice_hw *hw, u8 *buf, u32 len, bool load_s
 				  res);
 			return ICE_DDP_PKG_ERR;
 		}
-		ice_debug(hw, ICE_DBG_INIT,
-			  "Topology download successful, reinitializing device\n");
-		ice_deinit_hw(hw);
-		ice_init_hw(hw);
 	}
 
 	/* initialize package info */
-- 
2.51.0

