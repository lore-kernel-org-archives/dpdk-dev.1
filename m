Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CB8EDF150
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 10:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A79540DF5;
	Fri, 13 Feb 2026 11:27:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3557040A4B
 for <dev@dpdk.org>; Fri, 13 Feb 2026 11:27:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770978441; x=1802514441;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WrOaDXFvbyE0AfywkAwOngN2DN1zizbB75MK9dt9lKw=;
 b=XfcY3SdatKd34+O7KIhWlrxOGbVq1H8N4Onng9dw6TuMQs/kpQcRvc8v
 R4e5L1NStvtHDKSDczBxof++f5RNetPByokKM1o54HxrAkJoEJm295ERs
 7AFCfupKumH3lWEIexsFbE8EZ7zc+9jkMQzxeReYmTkHN3/AI2+uvYr47
 DOGQ8zdity7pvipdKb1XvHeae30ZltKMa9Gn9eO5fMZOcV1xWbprpAoa7
 0ZeCHCJUZyCPJiStseZrmE+jaG7nImLWRJeO/DI4P3xmSJZuWi8AQsJAb
 +iApsRM+sNxVW1jOQI2/Yd5lH1V3plyqq2YTpFi6p934RAiBl852yDBOE Q==;
X-CSE-ConnectionGUID: 4iawwwA/QIWAAMbOgq+oEg==
X-CSE-MsgGUID: 4L++yOdVSc2VXg7Dd6QVyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="83603117"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="83603117"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 02:27:21 -0800
X-CSE-ConnectionGUID: wq0ewE3STAK7G8HkZ4/CCw==
X-CSE-MsgGUID: gx02GgxkTlCjxOUjgx0F+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="217028148"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 13 Feb 2026 02:27:21 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 25/27] net/ice: avoid rte malloc in MAC address operations
Date: Fri, 13 Feb 2026 10:26:36 +0000
Message-ID: <692fa26644ea85b6ab848e5d8d88155c4ba49925.1770978324.git.anatoly.burakov@intel.com>
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

