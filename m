Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C376DC02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:02:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F25FA42E7E;
	Fri, 31 Jan 2025 14:00:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A853A427B8
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328394; x=1769864394;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lpblJrQlU7uGadTU63MAAhS1WOdPjZXReGJjc7+CCT8=;
 b=A3gLRvh0znnf6GOv+v8VJo0Grsvizz0u6drViJyoAlRDMKrRswT6M0kf
 TGVrgeb33n4bzySSYZD7H5ZzN/r4SG3WccEILQLGCLua+q+dHm40Ol3qd
 ysDIUiwK99dG/uDeM+fQ4lzH0/yPUlfBiRYMh0wzJBwDpp8nuSusT7TxN
 WtiBXtsjpirQcK7ainMz//EaimnPjk4LoQor/1yd3idOKLhMKw/ugiciF
 9QpW4/VV8QJrPuZmqVJWMmCyNiIVYq/aCbZK1RQDTGOhzU1kpw7qQ+EC/
 zwybbC1cUfRElJQPM2OYzquXlXnV0RoOvNo14HcR4jTW/+QVdGjHld+OX Q==;
X-CSE-ConnectionGUID: kzmgK4GrRj+7N7OgthPkVg==
X-CSE-MsgGUID: RGOF1hnHQi6aESCnyLiLrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315652"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315652"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:53 -0800
X-CSE-ConnectionGUID: upE6t38SRuqu1lMeHJzoNQ==
X-CSE-MsgGUID: fkrxI5eATa+ojGSAgWlriQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503410"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:52 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 27/42] net/e1000/base: add WoL definitions
Date: Fri, 31 Jan 2025 12:58:40 +0000
Message-ID: <5feb4f91e379aa3721cba6f6cf4c904a41f6f1f7.1738328107.git.anatoly.burakov@intel.com>
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

