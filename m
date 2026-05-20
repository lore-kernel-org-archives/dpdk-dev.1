Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE0FCD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:53:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0492540672;
	Wed, 20 May 2026 14:53:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1C08140695
 for <dev@dpdk.org>; Wed, 20 May 2026 14:53:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779281600; x=1810817600;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SyflXX7YbO1oagsYsSOMSlc4l8PlJxCL7W3RlXipfSI=;
 b=FCbcHFsBhO0PFzQnG6GxFK/UfpkDFe4tAd7dIYLUoLazhV++qDyeEZmX
 jLxV+Rj1YDrYfRsLOYX9/enYGnwA9mCbTOQ83m9LZKc4xIYtPyrYQvjWd
 XDuJjDn3o76nXJwb7FLHpvtvIx6JZZmhiO4DlXVYq7RW4EKRWuaMYJwV7
 qX+X+lY/q8YDbklXtmq+kpNASnQViNfbRJ8AAv9l9wTTUBc83R1OcImL7
 8lo5vQ9CTfBB1YHWZGTFaSI/vN8InaVKVCPcmowafKZB3bbgixyw2NFVM
 SojzMOXlDV3rxZRsoPaSEhywY8KKmz7dF2sCwhYqs7QWGOiIoungx+Qtt w==;
X-CSE-ConnectionGUID: ABq1hLX9SIS1XSLR5z1v9g==
X-CSE-MsgGUID: 5DKrocmMToaQKLgRZ6lCCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="91570276"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="91570276"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 05:53:19 -0700
X-CSE-ConnectionGUID: 7CC1cg2oTnyqU7DdDim+rw==
X-CSE-MsgGUID: 527I7AgiT16b60wm4+BxBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="235908287"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa010.fm.intel.com with ESMTP; 20 May 2026 05:53:19 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
 Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 05/10] net/e1000/base: clear DPG enable bit post MAC reset
Date: Wed, 20 May 2026 12:52:42 +0000
Message-ID: <20260520125256.354336-6-ciara.loftus@intel.com>
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

The GbE autonomous power gating feature was added to support G3 to S5
flow. However, this changed the reset value of DPG_EN bit to 1, causing
a possible autonomous transition to power gating state during D0. This
might result in undefined errors such as: packet loss, packet corruption
and Tx/Rx hangs. Therefore, clear DPG_EN bit after hardware reset flow.

Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h | 1 +
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index eb93675823..6c710300a6 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -36,6 +36,7 @@
 
 /* Extended Device Control */
 #define E1000_CTRL_EXT_LPCD		0x00000004 /* LCD Power Cycle Done */
+#define E1000_CTRL_EXT_DPG_EN		0x00000008 /* Dynamic Power Gating Enable */
 #define E1000_CTRL_EXT_SDP4_DATA	0x00000010 /* SW Definable Pin 4 data */
 #define E1000_CTRL_EXT_SDP6_DATA	0x00000040 /* SW Definable Pin 6 data */
 #define E1000_CTRL_EXT_SDP3_DATA	0x00000080 /* SW Definable Pin 3 data */
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index 6190052368..96b9ad6a70 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -5107,6 +5107,13 @@ STATIC s32 e1000_reset_hw_ich8lan(struct e1000_hw *hw)
 	reg |= E1000_KABGTXD_BGSQLBIAS;
 	E1000_WRITE_REG(hw, E1000_KABGTXD, reg);
 
+	if (hw->mac.type >= e1000_pch_ptp) {
+		DEBUGOUT("Clearing DPG EN bit post reset\n");
+		reg = E1000_READ_REG(hw, E1000_CTRL_EXT);
+		reg &= ~E1000_CTRL_EXT_DPG_EN;
+		E1000_WRITE_REG(hw, E1000_CTRL_EXT, reg);
+	}
+
 	return E1000_SUCCESS;
 }
 
-- 
2.43.0

