Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21F4E9B258
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 12:24:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3930540665;
	Tue, 24 Feb 2026 13:24:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 8933C40608
 for <dev@dpdk.org>; Tue, 24 Feb 2026 13:23:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771935830; x=1803471830;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uwxlNxibRhrTvZAS+s+P641C9cbqH766qWDqEDLFeuY=;
 b=AlzmBnVtcsqaqYu7oCrB+kuCnRiOY2kqeEJ2/3io6SubEYMOBTsghbI1
 1TGnu3RUsqMz8iM9pJkkso0CRTNrQIHmsaxtA9KHx+8WDQG8sY3Q4bc43
 hxZWpxyhh0DvG29n5QfSougGPUZoko0NT3kSgb86boLR0MyKGqkOrkoH/
 fHt3gPtFrT+Hoay7e+GFfotSZRBUkbsP7fGdXeoN3iacr0eA8SYCR1qwH
 VYq8zgPYRDsU31hsgINws4s18ahUQuzg093MXn84mZk1nHzeUm+9umjAV
 qoPKjxtqUSUhwSrszNPOQ15r/VC5ks7hTk8yK3XNG+5A4cXif6eiESfQV w==;
X-CSE-ConnectionGUID: WE7dXeXpRz6gZZlkou4AUQ==
X-CSE-MsgGUID: OJF1rMK1Q4GYW/lkOeUA7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72158114"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="72158114"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 04:23:49 -0800
X-CSE-ConnectionGUID: lSDdJVRvSR+PmLA2tE9rcA==
X-CSE-MsgGUID: LCy+56BEQASm8mYWnbpifQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="243854426"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 24 Feb 2026 04:23:49 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v8 07/26] net/i40e: use proper flex len define
Date: Tue, 24 Feb 2026 12:23:16 +0000
Message-ID: <53477bb77e3a09b0f66f28e2dfe35a1c9ee92136.1771935744.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771935744.git.anatoly.burakov@intel.com>
 <cover.1771935744.git.anatoly.burakov@intel.com>
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
Acked-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
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

