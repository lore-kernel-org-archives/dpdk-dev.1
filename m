Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC97C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:16:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9BAE842E1D;
	Tue,  4 Feb 2025 16:12:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id A3B5C42D45
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681937; x=1770217937;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lpblJrQlU7uGadTU63MAAhS1WOdPjZXReGJjc7+CCT8=;
 b=JBcIPaUFBC1NuNNDXd+RposgbVxjpN8CQ5Tpw7/LL1GGg+3dwqynivu4
 iwbNT654R5oPz1sNSPmpROwtwanBv752Zlg4ON4SAd+4Bh8/3B0QnVGCH
 M6kh5i0LG3sGBnFyRPneWvpTYOTnWDTcPFzvZwO/abYmfomzUlNhwBGab
 dKCgcKJ5vu7QT5tO3duDzLT/WYRAe7R9hj/TFwcL1Q/t9omH+r3sh7c44
 y24FTJJW56XkuiUIJ2QHcWEgFcd/v3fou2/0gZoDoBBOe16HLWpBKxLXZ
 zCgjnJ8HLWqZCyPuMkL+Quioe9UbwN1cVLMcs9W2FqD54J+fXwYK9EMJs A==;
X-CSE-ConnectionGUID: v0SIEM5lSoagNQbJtHeMdg==
X-CSE-MsgGUID: Shr720FCRTSgcNTWkPH85w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097166"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097166"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:17 -0800
X-CSE-ConnectionGUID: Y/13KUo7Sx+V2mVkFb6ElQ==
X-CSE-MsgGUID: eSe3Af93SmqbWQlxcokwog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792749"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:15 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 39/54] net/e1000/base: add WoL definitions
Date: Tue,  4 Feb 2025 15:10:45 +0000
Message-ID: <d0f32132d050798b1b2c34d7d74aec5615b31d93.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>

Define constants for WoL control on i210 NICs.

Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i210.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/e1000/base/e1000_i210.h b/drivers/net/intel/e1000/base/e1000_i210.h
index b5cc84766e..950ff4ba7b 100644
--- a/drivers/net/intel/e1000/base/e1000_i210.h
+++ b/drivers/net/intel/e1000/base/e1000_i210.h
@@ -66,6 +66,7 @@ enum E1000_INVM_STRUCTURE_TYPE {
 /* PLL Defines */
 #define E1000_PCI_PMCSR			0x44
 #define E1000_PCI_PMCSR_D3		0x03
+#define E1000_PCI_PMCSR_PME_EN		0x100
 #define E1000_MAX_PLL_TRIES		5
 #define E1000_PHY_PLL_UNCONF		0xFF
 #define E1000_PHY_PLL_FREQ_PAGE		0xFC0000
@@ -74,4 +75,7 @@ enum E1000_INVM_STRUCTURE_TYPE {
 #define E1000_INVM_AUTOLOAD		0x0A
 #define E1000_INVM_PLL_WO_VAL		0x0010
 
+#define E1000_NVM_CTRL_WORD_2		0x0F
+#define E1000_NVM_APMPME_ENABLE		0x8000
+
 #endif
-- 
2.43.5

