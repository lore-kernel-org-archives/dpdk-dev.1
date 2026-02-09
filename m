Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300C3E81BCC
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F11840A4B;
	Mon,  9 Feb 2026 15:14:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id A73A74066D
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:14:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770646452; x=1802182452;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o5rBcxLnkdoGn86YmiecJgJTaHQm/7eIsZiUKQaI9kI=;
 b=T99ZER4TaLNs0FrxL0zUDgYLFOXAwIefkPypsxt8IQ7HjkpDMz26IbyO
 TCzXXiPVqBEFLU5YAPJB/Y81ZpWvoxsL5CbAl/cRy/3iL7/FD4gZPYGeV
 zITOKHC9EttRhb9CwPgp3kOYTpOis7aUJhOu6kMVXqDeFXcVdC6DhJ1hB
 VxhRmBFHtYupBkuIpF1yxLfqXrTDjcyzHNQkLVi8jQW2+MzxENTetd2HR
 ympZclNzzruREvODERXaHo/lZq+XY++X/H/CWRW/ks9VsIAVvrEkEm003
 hiY9Y4/r50MIrAW2LafVfPciM4jPpPOVvscM8tJy0J543UytmLB8n6GCQ Q==;
X-CSE-ConnectionGUID: Q1Yjmfi5ToWM5SSznO44hw==
X-CSE-MsgGUID: /ZwFooo9QwmumlfKtucx/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71658494"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71658494"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:14:11 -0800
X-CSE-ConnectionGUID: DpFFTq9CQCamdEQAuliJwQ==
X-CSE-MsgGUID: bk+UOd96RUKk3oS5m2G+gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="242216032"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 09 Feb 2026 06:14:11 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 08/12] net/i40e: use proper flex len define
Date: Mon,  9 Feb 2026 14:13:44 +0000
Message-ID: <453a7416ca938dbb5828bd5b8d86ceb4163128e3.1770646012.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770646012.git.anatoly.burakov@intel.com>
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

