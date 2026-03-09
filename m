Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD1FF3C257
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 13:28:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42AFD40651;
	Mon,  9 Mar 2026 14:28:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C1731402BE;
 Mon,  9 Mar 2026 14:28:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773062910; x=1804598910;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=g29wm/bDr8v+LNP5SpOI278nfsbILHX7xV5sn3BDwTw=;
 b=XHA8Ldi+I2OmwkGsr47cd/y+ha+SLpzti8ga0vsLj6fUM6ysHPE/qv63
 BAOghvzSLer10zABnJx8XS67oPlIjI9qX85y+S2F7DWdLEdgffeU9SdWJ
 0W9/BAs1TsD+/4BNgWWuinuLbIAzLXL7Uhvfn2k8HjEfBvkwmzbP/46CX
 gv/p9Q+Moe5eNRdVeoM9xKRhUlcsqL7K3FKwCVVDg/N9kBW1MMNdptevJ
 4SvQ8gQaU6LqjLsQLcEqri6UKLnVOnUW/+7P5Znjj24AxG2ELLzs7vQBj
 2ahEXLsN7/lka04eg9foHgrnE6mRsWYHzVC/qd+SGJoZbmAylNMaUmm0j g==;
X-CSE-ConnectionGUID: r8LW3ls2RcOZaYwH4vFPww==
X-CSE-MsgGUID: Q8MK1DVLQNeMV2XRZCqZGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="74163591"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74163591"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 06:28:29 -0700
X-CSE-ConnectionGUID: Jw6780u1ThKqvLN8ZCIzJA==
X-CSE-MsgGUID: UzUWBaioSwqwtXA3GpnAqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="242775902"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 09 Mar 2026 06:28:28 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/i40e: fix null dereference in raw flow item
Date: Mon,  9 Mar 2026 13:28:02 +0000
Message-ID: <20260309132802.3094565-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
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

When a RTE_FLOW_ITEM_TYPE_RAW item is used with a non-zero length
and a NULL pattern pointer in either the spec or mask, a segfault
occurs as the pattern bytes are accessed unconditionally in a loop.
Add NULL checks for both spec->pattern and mask->pattern before entering
the loop that uses those fields.

Bugzilla ID: 1155
Fixes: 6ced3dd72f5f ("net/i40e: support flexible payload parsing for FDIR")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 2374b9bbca..6ad3013573 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -2350,6 +2350,24 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
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
+
+				if (raw_mask->pattern == NULL) {
+					rte_flow_error_set(error, EINVAL,
+							   RTE_FLOW_ERROR_TYPE_ITEM,
+							   item,
+							   "NULL RAW mask pattern");
+					return -rte_errno;
+				}
+			}
+
 			for (i = 0; i < raw_spec->length; i++) {
 				j = i + next_dst_off;
 				if (j >= RTE_ETH_FDIR_MAX_FLEXLEN ||
-- 
2.43.0

