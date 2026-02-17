Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B2AE6817A
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Feb 2026 12:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E19DB4068E;
	Tue, 17 Feb 2026 13:14:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 94BE240661
 for <dev@dpdk.org>; Tue, 17 Feb 2026 13:14:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771330487; x=1802866487;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Tcsb9dlzGf9N0C/Lc6PrY28/pwkTR8mdui0NuvARgtM=;
 b=ZOAg2n6QuGCq8+TKI/negD2F6YjY2W0cFSVKCj2v3MQ0uCjU25trgspp
 qKvQsiEHlSuqqrR1MU4JNfnfYIfReofZQdAI6wX13V4OK69+ykCh1ECEX
 xKyHao+JG5WDFZtKemjeQDIl1+nqlA05/cjvjI26qwRUYXr/LxZmRXWkY
 8NrZDrbuUQJz64bRCMFUVvyoex1+Kjq/c7qYemKtpMUz2a3UtdZRNz3gU
 +NrsL88M2jZwSB72ZtHEZh+0qmH7ZWG1ldnXea5wBevLz4T7m/VbS/+gE
 RAzw13dLeDF7hVL/kru/IYDxz5d/gMKV140hSEVImdgV1tbJ3ogHiebFt A==;
X-CSE-ConnectionGUID: 2Uihr5IiSUiZnqbV0AlTPA==
X-CSE-MsgGUID: A0g5rVJMRHidI7H0b/fvxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="74996022"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="74996022"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Feb 2026 04:14:46 -0800
X-CSE-ConnectionGUID: OQyMLBc0TZW/QMF6wIDk4Q==
X-CSE-MsgGUID: Fn/0JhT1QuW3ZG2+HIGmcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; d="scan'208";a="218396786"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 17 Feb 2026 04:14:46 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v5 07/27] net/i40e: use proper flex len define
Date: Tue, 17 Feb 2026 12:13:56 +0000
Message-ID: <e27d196ae4d375482ee0b7d7b8f8a32d940c4eaf.1771330391.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771330390.git.anatoly.burakov@intel.com>
 <cover.1771330390.git.anatoly.burakov@intel.com>
References: 
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

For FDIR, we have byte arrays that are supposed to be limited to whatever
the HW supports in terms of flex descriptor matching. However, in the
structure definition, spec and mask bytes are using different array length
defines, and the only reason why this works is because they evaluate to the
same value.

Use the i40e-specific definition instead.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index ca6638b32c..d57c53f661 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -631,7 +631,7 @@ struct i40e_fdir_flex_pit {
 /* A structure used to contain extend input of flow */
 struct i40e_fdir_flow_ext {
 	uint16_t vlan_tci;
-	uint8_t flexbytes[RTE_ETH_FDIR_MAX_FLEXLEN];
+	uint8_t flexbytes[I40E_FDIR_MAX_FLEX_LEN];
 	/* It is filled by the flexible payload to match. */
 	uint8_t flex_mask[I40E_FDIR_MAX_FLEX_LEN];
 	uint8_t raw_id;
-- 
2.47.3

