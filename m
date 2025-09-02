Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58253CA1005
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99A6B406A2;
	Tue,  2 Sep 2025 19:27:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id F366E4066F
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834047; x=1788370047;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=kVOW3sF2y3Ep0vMbQwTLrDUMPGIDII5v+5Qr2+J10jE=;
 b=A1GWPVc9vVOfuF1mUYdHR9XozCRryzDYMEP1THv5bYJ6OfktVX4otK23
 o0CA/DycxECbSJqh5iN7nBl1opvq7xDw3oRkSmxFsNePiJX6AsLVv3NEe
 WIY7pg1PSXT9vqnMdHzY8eHdck7VXXUaea5c9yLGAikbYpSkgS8v5ZhwE
 kSAWtybMv23SuLAVzEaaKI2sk0ZQOfef3be16dTaYTxaACy1ZQEaDjPVF
 l/y7yOZFds4sAF5GffDAacAhf48u3VoTTWr0c1NeHAyC9saSyWbi4Td3c
 YYDFDWVf1uHu6SJE1H8r7DLZYDA7MjgbyA9UeuLTBc0jyGMbIvTd1gjhp Q==;
X-CSE-ConnectionGUID: OZjjSovfSNOAjCFvXurBBg==
X-CSE-MsgGUID: Ns+TrlVTS4SYaFbLZvq8VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69732004"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69732004"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:23 -0700
X-CSE-ConnectionGUID: c7VUoXFNRwCHsWbw4Mfokg==
X-CSE-MsgGUID: Uk+20sljS8WP6V6T98ngmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229123"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:23 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 07/12] net/ice/base: allow overriding recipe ID
Date: Tue,  2 Sep 2025 18:26:57 +0100
Message-ID: <ac3baaf70490565b39dafd2aaf488e63df76174c.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
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

From: Pandi Kumar Maharajan <pandi.maharajan@intel.com>

With the addition of double VLAN mode on the device, the MAC VLAN filter
add rule was previously matching only the inner VLAN, rather than the
intended outer VLAN. This patch resolves the issue by introducing a new
software recipe ID as part of ice_fltr_info, allowing the base code to
send the newly created recipe ID. This ensures that the filter correctly
matches the outer VLAN when processing packets. Issue is observed in ESXi
environment but this patch introduces a generic solution for all
operating systems by adding a rid_override flag. If the base driver needs
to use a recipe ID different from the shared code default, it can set the
rid variable and enable the rid_override flag. This instructs the shared
code to use the specified rid instead of the default value.

Signed-off-by: Pandi Kumar Maharajan <pandi.maharajan@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_switch.c | 6 +++++-
 drivers/net/intel/ice/base/ice_switch.h | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index 628473f100..fff61b89d7 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -4113,7 +4113,11 @@ ice_fill_sw_rule(struct ice_hw *hw, struct ice_fltr_info *f_info,
 		CPU_TO_LE16(ICE_AQC_SW_RULES_T_LKUP_TX);
 
 	/* Recipe set depending on lookup type */
-	s_rule->recipe_id = CPU_TO_LE16(f_info->lkup_type);
+	if (f_info->rid_override) {
+		s_rule->recipe_id = CPU_TO_LE16(f_info->rid);
+	} else {
+		s_rule->recipe_id = CPU_TO_LE16(f_info->lkup_type);
+	}
 	s_rule->src = CPU_TO_LE16(f_info->src);
 	s_rule->act = CPU_TO_LE32(act);
 
diff --git a/drivers/net/intel/ice/base/ice_switch.h b/drivers/net/intel/ice/base/ice_switch.h
index 8eac7739fb..73452cc4c7 100644
--- a/drivers/net/intel/ice/base/ice_switch.h
+++ b/drivers/net/intel/ice/base/ice_switch.h
@@ -195,6 +195,10 @@ struct ice_fltr_info {
 	u8 lb_en;	/* Indicate if packet can be looped back */
 	u8 lan_en;	/* Indicate if packet can be forwarded to the uplink */
 	u8 fltVeb_en;   /* Indicate if VSI is connected to floating VEB */
+
+	/* Override default Recipe ID */
+	u16 rid;
+	bool rid_override;
 };
 
 struct ice_update_recipe_lkup_idx_params {
-- 
2.47.3

