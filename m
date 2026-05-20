Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B1FCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B07EF40679;
	Wed, 20 May 2026 14:53:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7090F40662;
 Wed, 20 May 2026 14:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281596; x=1810817596;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=oUxPCnd6jxd9Xi1yz1USXqf8JMc4bVbN6VYqUSQorc8=;
 b=esrdxrkU7giOK1zRMjQYfe53RZzZ9HUDpbBU075uxn/Q7XRFSLSfc0sU
 F7i8Hr/x/uDfc5QmOQFRWGXpypc9PolowV6Ylti5oiM2twh8cDH0G/PVD
 EmZw/x2OyorueayCOKReX9ObeAPrEkVPKtvUVhTWzW9ObFkUO22ianC+D
 zjXF+qATdvRwXVx2yyrh40NPOcBYO+xh4sh6iB52gaUeneWiCuBCSD2AV
 vv7S+2o9L1Uopn4Z2TAGuD1V+xzA0VdgnwKIv6okK0dKmB6PwQ6WM/pj2
 u2rahBGuN5s84TLx+oXM91ouNepjdT7OKOJtCpifuN05jbpfahdW9Ye5Q w==;
X-CSE-ConnectionGUID: 350wcIfkTASGv7QQ6IjOPA==
X-CSE-MsgGUID: P9qn18K3RYG46EU+Yf517Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570267"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570267"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:16 -0700
X-CSE-ConnectionGUID: CxshAQcVT6uV/P+KMdQkfA==
X-CSE-MsgGUID: qzoHYQ2eQmSxqEE+YEo9bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908271"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:14 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>, stable@dpdk.org,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 01/10] net/e1000/base: refactor K1 exit timeout configuration
Date: Wed, 20 May 2026 12:52:38 +0000
Message-ID: <20260520125256.354336-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520125256.354336-1-ciara.loftus@intel.com>
References: <20260520125256.354336-1-ciara.loftus@intel.com>
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

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Replace magic numbers in the FEXTNVM12 register access with named bit
definitions to improve readability. Add a missing error path to ensure
ME activity blocking a PHY reset is correctly propagated to the caller.
Also improve some code formatting.

Fixes: 38db3f7f50bd ("e1000: update base driver")
Cc: stable@dpdk.org

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 11 ++++++++---
 drivers/net/intel/e1000/base/e1000_ich8lan.h |  3 +++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index ece61650f7..58597cce8a 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -305,8 +305,8 @@ STATIC s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
 		return E1000_SUCCESS;
 
 	fextnvm12 = E1000_READ_REG(hw, E1000_FEXTNVM12);
-	fextnvm12 |= (1 << 23);
-	fextnvm12 &= ~((1 << 22));
+	fextnvm12 &= ~E1000_FEXTNVM12_PHYPD_CTRL_MASK;
+	fextnvm12 |= E1000_FEXTNVM12_PHYPD_CTRL_P1;
 	E1000_WRITE_REG(hw, E1000_FEXTNVM12, fextnvm12);
 
 	msec_delay_irq(1);
@@ -318,6 +318,9 @@ STATIC s32 e1000_reconfigure_k1_exit_timeout(struct e1000_hw *hw)
 	ret_val = hw->phy.ops.write_reg_locked(hw, E1000_PHY_TIMEOUTS_REG,
 					       phy_timeout);
 
+	DEBUGOUT1("e1000_reconfigure_k1_exit_timeout returns %d\n",
+		  ret_val);
+
 	return ret_val;
 }
 
@@ -460,8 +463,10 @@ STATIC s32 e1000_init_phy_workarounds_pchlan(struct e1000_hw *hw)
 		 *  the PHY is in.
 		 */
 		ret_val = hw->phy.ops.check_reset_block(hw);
-		if (ret_val)
+		if (ret_val) {
 			ERROR_REPORT("ME blocked access to PHY after reset\n");
+			goto out;
+		}
 
 		if (hw->mac.type >= e1000_pch_mtp) {
 			ret_val = hw->phy.ops.acquire(hw);
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.h b/drivers/net/intel/e1000/base/e1000_ich8lan.h
index f2ba910ea6..43360400bc 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.h
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.h
@@ -89,6 +89,9 @@
 #define E1000_FEXTNVM11_DISABLE_PB_READ		0x00000200
 #define E1000_FEXTNVM11_DISABLE_MULR_FIX	0x00002000
 #define E1000_FEXTNVM12_DONT_WAK_DPG_CLKREQ	0x00001000
+#define E1000_FEXTNVM12_PHYPD_CTRL_MASK		0x00C00000
+#define E1000_FEXTNVM12_PHYPD_CTRL_P1		0x00800000
+
 /* bit24: RXDCTL thresholds granularity: 0 - cache lines, 1 - descriptors */
 #define E1000_RXDCTL_THRESH_UNIT_DESC	0x01000000
 
-- 
2.43.0

