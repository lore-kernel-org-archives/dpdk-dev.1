Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D1CDB479
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 15:49:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9E244068A;
	Thu, 25 Jun 2026 17:49:12 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1B6EB4068A
 for <dev@dpdk.org>; Thu, 25 Jun 2026 17:49:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782402552; x=1813938552;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/rAwTWTJNtsxdUw2t4FXzhiNitaz4gkdpxKMMTiWza8=;
 b=Z9DTvIx4s9UaPWmnss8uZu82VHrUTG70wSv3p8t+7KiLJ+G6x4vfSzz+
 TU1/z93fRZLf+j0Yd61JeEIoiHpzWs6A1Vtwj8Cinb8wTrWKOK+O2xMe/
 KVQkqKR0vFs93Q/dW3v8zmsqemr+iHnCsQ0NX8ySborrWEf6SG/fO2mSG
 dm1p5tbg6VtLY5RLhrHBUgxusIVVLq0gQ3ARlu+RqTXcnXk4x/MMRMTuK
 ELTBKUaeq9JgMHz7Twcv508q/ygXRn2kM3fGn79oV28mNPhPFSRWqT0BW
 EdMa9F2xtR+OB73qdEQXs2bQtZq2hfPe1J3vVQdJiYDgmOJXSRZu/Zzmv Q==;
X-CSE-ConnectionGUID: sI1roQtKT+i+CzBoXxqS2A==
X-CSE-MsgGUID: vawoMT9sS0W0kSEigW/s9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11828"; a="83371771"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="83371771"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2026 08:49:10 -0700
X-CSE-ConnectionGUID: ozeIUektSPy8Qx8dp5CHug==
X-CSE-MsgGUID: HVN8BUfhSJivRA5Addj9Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; d="scan'208";a="280983491"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 25 Jun 2026 08:49:09 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 1/1] net/ice: fix NULL pointer dereference in DCF
Date: Thu, 25 Jun 2026 16:49:08 +0100
Message-ID: <5fc2bdc0501a03687b4155cc847f89bb76687c0f.1782402538.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

When calling into common parameter checks and subsequent action check
callbacks, the DCF path never supplied the `driver_ctx` struct, yet the
callback itself dereferenced the struct.

Fix it by supplying the DCF adapter struct as context.

Fixes: db24a8092854 ("net/ice: use common action checks for switch")
Cc: vladimir.medvedkin@intel.com

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_switch_filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index 5d9e0062af..6f5af03f6a 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -1773,6 +1773,7 @@ ice_switch_parse_pattern_action(struct ice_adapter *ad,
 		},
 		.max_actions = 1,
 		.check = ice_switch_dcf_action_check,
+		.driver_ctx = container_of(ad, struct ice_dcf_adapter, parent),
 	};
 	struct ci_flow_actions_check_param param = {
 		.allowed_types = (enum rte_flow_action_type[]){
-- 
2.47.3

