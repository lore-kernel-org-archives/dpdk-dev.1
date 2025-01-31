Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4577C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:01:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A10F142E4D;
	Fri, 31 Jan 2025 13:59:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 026B042DD6
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328383; x=1769864383;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=flCewB9SUkQZV0I9VbVKlRUO86/EDvYuWWv+6GBqoS8=;
 b=ZsnvXL0Q31TvoxAWni6wHq5G+Bzpj8SA9/ZDXlSzwWPxfP7R2bA/CSRm
 jcVNzeWTFwLSjXHE9p4FM1ALHS4sLxhfxTYs7UezfQldVo+q93swdRKU6
 H9S8ofLMkpoTZQh0z6GS0DhSNC2qaaSn4DjsyIqGD1Z7uHYmm+MCWFB1b
 jCMBk5ffQZdMKfj1s76nEjSrGu5x03odccPuSdNDNHd8ra1Mia2uoczzu
 HSj83ngTZYYeIHjSijRurbN/meEpLWNpi9zYQCJmyPVcdYY4H3XaFceab
 igDh2UCqd25L4dgFPtQXgJDCxhkAUaSbNqFl1bGkT8476beXKeB4lZvZv A==;
X-CSE-ConnectionGUID: 9PYc49BjQCaHixduHV0DZw==
X-CSE-MsgGUID: PEr9XwfCSomEoCqJhmWUHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315637"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315637"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:43 -0800
X-CSE-ConnectionGUID: /ovvvnpTThyQSK7e3feRvg==
X-CSE-MsgGUID: dSk8Ej+MRR2Z5+LLMq3vMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503395"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:42 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 17/42] net/e1000/base: workaround for packet loss
Date: Fri, 31 Jan 2025 12:58:30 +0000
Message-ID: <cb2d4f2d63901f2fb98c51a6183297f0c31da667.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

From: Nir Efrati <nir.efrati@intel.com>

On some MAC types, packet loss is observed due to wake DMA clock gating.
Disable wake DMA clock for some MAC types to avoid packet loss.

Signed-off-by: Nir Efrati <nir.efrati@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_ich8lan.c | 7 +++++++
 drivers/net/intel/e1000/base/e1000_ich8lan.h | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.c b/drivers/net/intel/e1000/base/e1000_ich8lan.c
index b346b95d2f..7cbbeae91c 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.c
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.c
@@ -5048,6 +5048,7 @@ STATIC s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 {
 	struct e1000_mac_info *mac = &hw->mac;
 	u32 ctrl_ext, txdctl, snoop;
+	u32 mac_reg;
 	s32 ret_val;
 	u16 i;
 
@@ -5108,6 +5109,12 @@ STATIC s32 e1000_init_hw_ich8lan(struct e1000_hw *hw)
 		snoop = (u32) ~(PCIE_NO_SNOOP_ALL);
 	e1000_set_pcie_no_snoop_generic(hw, snoop);
 
+	/* Enable workaround for packet loss issue on TGL/ADL platforms */
+	if (mac->type == e1000_pch_tgp || mac->type == e1000_pch_adp) {
+		mac_reg = E1000_READ_REG(hw, E1000_FFLT_DBG);
+		mac_reg |= E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK;
+		E1000_WRITE_REG(hw, E1000_FFLT_DBG, mac_reg);
+	}
 	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 	ctrl_ext |= E1000_CTRL_EXT_RO_DIS;
 	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext);
diff --git a/drivers/net/intel/e1000/base/e1000_ich8lan.h b/drivers/net/intel/e1000/base/e1000_ich8lan.h
index e456e5132e..4780417bae 100644
--- a/drivers/net/intel/e1000/base/e1000_ich8lan.h
+++ b/drivers/net/intel/e1000/base/e1000_ich8lan.h
@@ -277,7 +277,7 @@
 #define E1000_PCH_RAICC(_n)	(0x05F50 + ((_n) * 4))
 
 #define E1000_PCI_VENDOR_ID_REGISTER	0x00
-
+#define E1000_FFLT_DBG_DONT_GATE_WAKE_DMA_CLK 0x1000
 #define E1000_PCI_REVISION_ID_REG	0x08
 void e1000_set_kmrn_lock_loss_workaround_ich8lan(struct e1000_hw *hw,
 						 bool state);
-- 
2.43.5

