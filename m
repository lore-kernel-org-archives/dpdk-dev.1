Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A3EA3F22
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:16:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 083DD40E96;
	Tue, 10 Feb 2026 17:14:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id C3C3740DD8
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740078; x=1802276078;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=WrOaDXFvbyE0AfywkAwOngN2DN1zizbB75MK9dt9lKw=;
 b=SVzuWsklei+Ef2oHitKDGhqLuBlBDDZMZGVRJRLxFsFiJ2ohfYPSG3zA
 FA7UVQyRHv4ID2viRIDQBDUJR2fRXvbDAslttxXg+FLiAF5lJX0E7SgXa
 IT5371WR0UCW10efaX9s7TD1+aLNPbIH0VgWbkyqWpTNvR67rll1gIg1R
 pmXlD7tSSxZNEfvKSK3wDmvpixxpoQPDlFhrJrWnTOLNGgLOmq1bBVRvf
 YAqZ5DJhXwNyfkgriyZxG6n41FDqKwWt6gab4r4JK9qMUeyuJhlJLATve
 2D4Vzu7/puta0o0TawUTd/SwCF97+vIG9q9fe8QTFmdnSWA+3+rFb1Yq+ A==;
X-CSE-ConnectionGUID: bqA1L/Z0Q8+bHD9fJqv5Yg==
X-CSE-MsgGUID: 4fi76OZdSTW6FzhwI/Eqpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286316"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286316"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:37 -0800
X-CSE-ConnectionGUID: u71aLVFTQ2aYfQDncrZahQ==
X-CSE-MsgGUID: Nu1CuyiMTwSAVzUNf956SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127860"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:37 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 25/26] net/ice: avoid rte malloc in MAC address operations
Date: Tue, 10 Feb 2026 16:13:54 +0000
Message-ID: <af147d9cc9449d6104b3ef5a8b94171032ba245f.1770739925.git.anatoly.burakov@intel.com>
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

