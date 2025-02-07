Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67425C0219C
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:49:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1A0E42EB0;
	Fri,  7 Feb 2025 13:46:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 373B642E5C
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:46:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932388; x=1770468388;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lpblJrQlU7uGadTU63MAAhS1WOdPjZXReGJjc7+CCT8=;
 b=jbg0SEW6MisB7rrFO2eyV0V9ZnLhnGthYAU9d71+5cRISnUeXYAQX6Ok
 aVALh+yCbxWyg+8qkoSqYxhaWTtEPwxctPC68WXT9yMy456M7+owajuXb
 jTAxDLYj0RP+dNDDo1p9UdMTlrz/ZXSFOZenZbfqDOJPZUMwml8yOawji
 TcWdiZpdnFunUL8+lbF5YB+05i5f7MjrMNEPIHUT1HcCnScP6pJwVd2Qr
 63BDg0MZvDItVlEBpc+SM0r31Qt0EmP8P9ZSTTBO6a0ipLyz5iOTAd8cY
 ZIbwbw11rYGk/9H+68TDQQGEAQa6PKc6FP0II17TKvQHGQ8n1y/YnZGTA Q==;
X-CSE-ConnectionGUID: GIY/GDNGQoywnd5r6NT+3g==
X-CSE-MsgGUID: BFm/KJmEQkuAf/ffN8ooDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331873"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331873"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:46:27 -0800
X-CSE-ConnectionGUID: HFlhVhaUTGSGaLMb7BQ4dw==
X-CSE-MsgGUID: omo77ZG5RDmvIAkHX0rpdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953788"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:46:26 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 28/36] net/e1000/base: add WoL definitions
Date: Fri,  7 Feb 2025 12:45:20 +0000
Message-ID: <a7fdac0e53908b09d2ece339321fe66e487159e8.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

