Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A161E9E30A
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 13:56:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C9D640E34;
	Wed, 11 Feb 2026 14:54:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id D431440E18
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:54:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770818043; x=1802354043;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WrOaDXFvbyE0AfywkAwOngN2DN1zizbB75MK9dt9lKw=;
 b=WiE5YhfMcrcNsb1BEV1ed/faSvvQwf+aBl9aXM8wSLUXkqprcK1f/2lK
 5FvaEzRlCGU0ug9PX4EcrlpsiwTTmDUCnELX4q/TVuUcxDTWQqBkjBfDT
 deiHSRDGFqHroSKnylpSkNe33LUMX23kuiN+kw7KjNXvoae04wAbo0Cvw
 MwUYCBRAHDNK/WQoCAX8DWdS1mqsDKiY+td2kQi9MlVZPCKeYOrU5MlO2
 dwVv8sAOrQaWO5bxL/btiQh1C7VPuzwMxgksPBzqzEz9QPT+FYTBdpJMR
 gYuXrOJqydXoYBxVu8V0Sw/Gxupn/KuaV6jn8xguv0GqFUx7p3bGROKja w==;
X-CSE-ConnectionGUID: xiD5HZnATAy0cXAhNUmIIw==
X-CSE-MsgGUID: ZcJ3rrBAQrm6nVhwEz1/EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="75808282"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75808282"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 05:54:02 -0800
X-CSE-ConnectionGUID: wCaZgLt0TtO3Q0dMIxn3Yg==
X-CSE-MsgGUID: KXpkato3S/qaIqIIO/9U+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="212359705"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa007.jf.intel.com with ESMTP; 11 Feb 2026 05:54:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 25/27] net/ice: avoid rte malloc in MAC address operations
Date: Wed, 11 Feb 2026 13:53:07 +0000
Message-ID: <808305080bf4a8af17edaca162d49f5fd94d5556.1770817884.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770817884.git.anatoly.burakov@intel.com>
 <cover.1770817884.git.anatoly.burakov@intel.com>
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

Currently, when adding or deleting MAC addresses, we are using
rte_zmalloc followed by an immediate rte_free. This is not needed as this
memory is not being stored anywhere, so replace it with regular
calloc/free.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_dcf_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index 037382b336..d2a7a2847b 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -936,7 +936,7 @@ dcf_add_del_mc_addr_list(struct ice_dcf_hw *hw,
 	len = sizeof(struct virtchnl_ether_addr_list);
 	len += sizeof(struct virtchnl_ether_addr) * mc_addrs_num;
 
-	list = rte_zmalloc(NULL, len, 0);
+	list = calloc(1, len);
 	if (!list) {
 		PMD_DRV_LOG(ERR, "fail to allocate memory");
 		return -ENOMEM;
@@ -961,7 +961,7 @@ dcf_add_del_mc_addr_list(struct ice_dcf_hw *hw,
 		PMD_DRV_LOG(ERR, "fail to execute command %s",
 			    add ? "OP_ADD_ETHER_ADDRESS" :
 			    "OP_DEL_ETHER_ADDRESS");
-	rte_free(list);
+	free(list);
 	return err;
 }
 
-- 
2.47.3

