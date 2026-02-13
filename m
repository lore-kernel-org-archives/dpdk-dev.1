Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCA4EDF14F
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:27:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 32FAB4067C;
	Fri, 13 Feb 2026 11:27:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 899DB40666
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978420; x=1802514420;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=o5rBcxLnkdoGn86YmiecJgJTaHQm/7eIsZiUKQaI9kI=;
 b=TiixcV/YvUdKIlCtiKCsPHapa6TggoLNWzZNaDIXCS9ReQ71gegUpMG/
 SS/qIOrPsKINOzPHwr8kOiH1cHmsXum1clTNsumu5i04Ko/71b/VB2D3/
 hZ6eklYueMRxoZtjMzOBeJW+mMB2QFyr51Zm0YR42QNglYo7TboHxsh71
 zJGNEhAOpzSewIoqvcbHTaXWnPFeelK+bBwJBORtq+13lJ6+2oxBl1HtQ
 Z1+3PJEqyvTtxszHX9710T5ZPkWpQf6Sn/2ue56gj6SvGybY4bZJcZZmB
 a6w7E7W+tzdq8baWWwVgA51Z2BtOCUPn8Kmjeq6DxoM93ffxbltEiGTkX A==;
X-CSE-ConnectionGUID: Sdzt0SnVQ3aNJlq6V4ccaw==
X-CSE-MsgGUID: OoAm8Q3HToeGoZFOoZ5Brg==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603080"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603080"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:00 -0800
X-CSE-ConnectionGUID: X1+FyTZAQVKysYz9on6rIA==
X-CSE-MsgGUID: J+d/EjOLQCm79puUcqcZdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028059"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 07/27] net/i40e: use proper flex len define
Date: Fri, 13 Feb 2026 10:26:18 +0000
Message-ID: <c92f247578adb34397d5d7a8ac35d764318dfca1.1770978324.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770978324.git.anatoly.burakov@intel.com>
 <cover.1770978324.git.anatoly.burakov@intel.com>
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

