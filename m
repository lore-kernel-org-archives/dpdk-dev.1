Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391DEE9A04A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:24:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EBFCD4065F;
	Thu, 19 Feb 2026 17:23:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id CEE43402F2
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518206; x=1803054206;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=uwxlNxibRhrTvZAS+s+P641C9cbqH766qWDqEDLFeuY=;
 b=Ok8xJogcT5vaMEB3NKAm/UGwgmZHM1rITgRydwRQ7ZbQ5uvqUUSsAc77
 9bMSn0R07mM/GzgzzN2rVQ7bv2DQarZT25DfkFQUXEcv/g6qYIJuImbP0
 6Mn6uFut0jC60s2IMdlklvDztrxDvKo1rCuVUb/bLTJoBZcVqsUnPURD5
 /rlcxB1H/4jppchOc3h0wEYNWEPuJ94m1zeWydnism6RM+khwu5/qqPtZ
 6R4OzQhJcZd+Pn++yc+yoVJ4Lc6O5MVSkypgnRfc4hV2OvR3vYe6gZVQG
 WjxiSWymGzaUd5pkoIe97Y39JmQA7n8xqIRTaTpUoKEVp9B1i92R2puO9 Q==;
X-CSE-ConnectionGUID: oE4KPzblROiIqsjj0GTIEw==
X-CSE-MsgGUID: QoJu7lK7Q6eBvHdt4UOR7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231432"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231432"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:26 -0800
X-CSE-ConnectionGUID: IL5tNWLgS3qcCF+gQkQmpw==
X-CSE-MsgGUID: ugv2aePhSLW0C8MolPxDjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699829"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:25 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 07/27] net/i40e: use proper flex len define
Date: Thu, 19 Feb 2026 16:22:50 +0000
Message-ID: <c323050cc2b54e645976c7c1ffff078a1fefbaa5.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1771518103.git.anatoly.burakov@intel.com>
 <cover.1771518103.git.anatoly.burakov@intel.com>
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

