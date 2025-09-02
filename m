Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC159CA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:27:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93C2F4065A;
	Tue,  2 Sep 2025 19:27:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id DAB174065E;
 Tue,  2 Sep 2025 19:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834045; x=1788370045;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZUpN69ddPVlaJVtZZJtNK/aMWEdNHurHh5mjZJsrdVQ=;
 b=WILjoP1X2WlZ9aJlyA6J4BSHeYUemt5kaJfOdBlbRp3GZTxQt9AVPz7D
 JYP0tbdxAmVG2cNO2q12K5BFCbllfBI4NERJZ0FA95Ujz5Y0KRWVnPv+d
 oiJi51enQCfcg4/KI7xRQ1xIy0oXu0+bi1VIY5PK03Izzws8wy4+C6RiY
 heFDpXqGjyXTV9fZkVcimh/Hjpirpqf7ofp82b+lVFXozlz5TYmveuMHL
 8ndJbjUCZRcaEZdJw4iXkgvv6eZZzi/x/FlfqC/pFI5IZioAClZJ6qOkK
 M5imci3tzgcf4RXMkcyq8DapiDjVts5DSCcEqUu0HicySFIlLFeuNo0mB g==;
X-CSE-ConnectionGUID: bVraGjGbTOe4SiIVK8uX7w==
X-CSE-MsgGUID: z3bPLNpnSby8oDdzC8+k9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69731974"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69731974"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:14 -0700
X-CSE-ConnectionGUID: QIdtIL8ASPqI5TZOuSeYvA==
X-CSE-MsgGUID: jrYwHTbQSTGlXMEPsJY5zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229106"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:13 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Wojciech Drewek <wojciech.drewek@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>,
 Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
 Dan Nowlin <dan.nowlin@intel.com>, Qiming Yang <qiming.yang@intel.com>
Cc: stable@dpdk.org
Subject: [PATCH v1 02/12] net/ice/base: fix adding special words
Date: Tue,  2 Sep 2025 18:26:52 +0100
Message-ID: <6e919683011310f00dcdb60ffbb66c8f721547c7.1756833701.git.anatoly.burakov@intel.com>
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

From: Shaiq Wani <shaiq.wani@intel.com>

The function ice_add_special_words() is meant to add special words (such
as traffic direction) to the rule. The function that
interprets/translates these additional words is ice_get_sw_fv_list().

However, the ice_get_sw_fv_list() is called *before*
ice_add_special_words(), so the "special" words weren't added at that
point yet, hence they're not translated. This results in the driver
ignoring whatever special words that were added. The fix is to call
ice_get_sw_fv_list() *after* ice_add_special_words().

Fixes: ed3066a3b1b0 ("net/ice/base: refactor DDP code")
Cc: stable@dpdk.org

Signed-off-by: Jeff Shaw <jeffrey.b.shaw@intel.com>
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_switch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_switch.c b/drivers/net/intel/ice/base/ice_switch.c
index 54cc2e1c07..f16bec044c 100644
--- a/drivers/net/intel/ice/base/ice_switch.c
+++ b/drivers/net/intel/ice/base/ice_switch.c
@@ -8287,10 +8287,6 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	 */
 	ice_get_compat_fv_bitmap(hw, rinfo, fv_bitmap);
 
-	status = ice_get_sw_fv_list(hw, lkup_exts, fv_bitmap, &rm->fv_list);
-	if (status)
-		goto err_unroll;
-
 	/* Create any special protocol/offset pairs, such as looking at tunnel
 	 * bits by extracting metadata
 	 */
@@ -8298,6 +8294,10 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
 	if (status)
 		goto err_free_lkup_exts;
 
+	status = ice_get_sw_fv_list(hw, lkup_exts, fv_bitmap, &rm->fv_list);
+	if (status)
+		goto err_unroll;
+
 	/* Group match words into recipes using preferred recipe grouping
 	 * criteria.
 	 */
-- 
2.47.3

