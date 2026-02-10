Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AC0EA3F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:14:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C3E640BA4;
	Tue, 10 Feb 2026 17:14:18 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 4798B400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740053; x=1802276053;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o5rBcxLnkdoGn86YmiecJgJTaHQm/7eIsZiUKQaI9kI=;
 b=BlfOxsi3RZK7VsdXUnDnaXIjOpRVXM856GdYmg+zZtWTejEhtGE75cwc
 K/5snG9FWHB+L/1PMpXVViQqVWgVDfhn+NL7sNtbR2HjD9/LZtkF2kpak
 NSMjmfwbaOHLRbl/1nR00SBicpQ+/LXwuYCsY1bT8ydft+pZe8A+Zbr24
 PC8wV+ZaLqgyr/Q3p70BvZwnI1+/dEybOWMpTvscBL3Xwi+qZVhxwSHeG
 kI6qYxGXze2hPrSaqyJ9OUclQggAfn4sGkBlZ69GJOttwxtoyx8g2z5zg
 IBZSVOrtmJSjBYKU1r0ti4hkzzbIjwMARX1Nzy7rT5oPDsF3EF8oNp8RO A==;
X-CSE-ConnectionGUID: nnzAQH1SQlapI+fQhUKwLg==
X-CSE-MsgGUID: SMlmC5/USemuOED0buliHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286192"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286192"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:12 -0800
X-CSE-ConnectionGUID: MSnKsi8ZQkyGAil2FCRMOA==
X-CSE-MsgGUID: gsM62r6dRUaArSYHTluAFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127740"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:11 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 07/26] net/i40e: use proper flex len define
Date: Tue, 10 Feb 2026 16:13:36 +0000
Message-ID: <b2d61a7ff8a7697cac172c140caf9b0fe405ff4b.1770739925.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770739924.git.anatoly.burakov@intel.com>
 <cover.1770739924.git.anatoly.burakov@intel.com>
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
index d144297360..025901edb6 100644
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

