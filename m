Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84596F417F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 15:29:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D800D40658;
	Mon,  9 Mar 2026 16:29:33 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id B6D8740261;
 Mon,  9 Mar 2026 16:29:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773070172; x=1804606172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fkVtb05vFhYk3sRrXTFtgUG6BDBPyZFVMgQ2/CsfsxU=;
 b=kViAolafmHW6sTLGASR1N/0whdtinORcOgVlj8vMhnD/hKF0TrIWYb04
 GCj80ZoG7uZYhFaG8q65rMtFhZDlklcNccOJEJ/cv5o4KCzTIpeNVK2mX
 UhtD7dlZLvHB/mdfckv2g3Va0CWYsVMVYaZCCyV7sC7lDpW3o0wzZ/I95
 giP7V3e1ihBNdpR4hFvepdSRHAhtN30F4oy+fF5PI+wun3U1V36k3mPwb
 T0jSoCP6bxw1Nyep0JdUmn+dxzQtLQCyRk53+5ipqye/H5sGqnBJZkzYG
 B0BYZMHvYOaXTHBFVLtZiY6pdP2Nu+lRJ5JaICT/smG9qcfS9N2OvnLd/ Q==;
X-CSE-ConnectionGUID: j0W5qIwXT9CmrbvMt401lw==
X-CSE-MsgGUID: W7wUJuLCSXy/FMGUCEwpRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="85445187"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="85445187"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 08:29:31 -0700
X-CSE-ConnectionGUID: 1cXMDJRdQha86S42yC/r5Q==
X-CSE-MsgGUID: I17OwCmiRlSH2mnrKyj+Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219762880"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa008.jf.intel.com with ESMTP; 09 Mar 2026 08:29:30 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2] net/i40e: validate raw flow items before dereferencing
Date: Mon,  9 Mar 2026 15:29:19 +0000
Message-ID: <20260309152919.3193943-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309132802.3094565-1-ciara.loftus@intel.com>
References: <20260309132802.3094565-1-ciara.loftus@intel.com>
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

When a RTE_FLOW_ITEM_TYPE_RAW item is used with a non-zero length,
the spec and mask pattern pointers are dereferenced unconditionally
in a loop, causing a segfault if either is NULL. Additionally, no
check is made that the spec and mask have equal lengths before
iterating, which could result in out-of-bounds access.

Add validation before the loop: reject the item if either pattern
pointer is NULL, or if the spec and mask lengths differ.

Bugzilla ID: 1155
Fixes: 6ced3dd72f5f ("net/i40e: support flexible payload parsing for FDIR")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Add an additional check for spec and mask length mismatch
---
 drivers/net/intel/i40e/i40e_flow.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 2374b9bbca..4624edc758 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2350,6 +2350,30 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 				return -rte_errno;
 			}
 
+			if (raw_spec->length != 0) {
+				if (raw_spec->pattern == NULL) {
+					rte_flow_error_set(error, EINVAL,
+							   RTE_FLOW_ERROR_TYPE_ITEM,
+							   item,
+							   "NULL RAW spec pattern");
+					return -rte_errno;
+				}
+				if (raw_mask->pattern == NULL) {
+					rte_flow_error_set(error, EINVAL,
+							   RTE_FLOW_ERROR_TYPE_ITEM,
+							   item,
+							   "NULL RAW mask pattern");
+					return -rte_errno;
+				}
+				if (raw_spec->length != raw_mask->length) {
+					rte_flow_error_set(error, EINVAL,
+							   RTE_FLOW_ERROR_TYPE_ITEM,
+							   item,
+							   "RAW spec and mask length mismatch");
+					return -rte_errno;
+				}
+			}
+
 			for (i = 0; i < raw_spec->length; i++) {
 				j = i + next_dst_off;
 				if (j >= RTE_ETH_FDIR_MAX_FLEXLEN ||
-- 
2.43.0

