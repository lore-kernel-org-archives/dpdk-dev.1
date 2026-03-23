Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BD8EC01C8
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Mar 2026 10:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 38E3C402DF;
	Mon, 23 Mar 2026 11:44:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 7D6854025F;
 Mon, 23 Mar 2026 11:44:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774262646; x=1805798646;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=YG8h45mbiLklfoD5HkY6jyKvgYv2C34saetgWgxjhF4=;
 b=CR3Q5qcoDkG++RJfn+uB19xAzVb4CUAYuEatVCepl0S3bqaqL8lgNK9i
 sMrhk/YZeotIVNrl4e5q6JEFYB9OBYi9OuZnjJbdy2zwMBqAcEjAHXdqf
 wPJJap/5p5QA+iWDCxc4jhRyoMcx8UFcnkoQvEbntyikHsRaQws/MRIiE
 ffugASSqOEVHgVUvajFrqlxJ+448PWS2mw0M8PxmK/Jot4i7TPE9lIlQF
 NRKDNG/CVDApVRvr44qcnGft29iGcLkO5g6GPjmDTgWU4E5YdZbjBcDlX
 obJxnI2oSCPA0dzwjkfaoqhdj9tEg85zh+KnYaxYyom5xy/jlDy0lUFXI w==;
X-CSE-ConnectionGUID: UJ8tKEOrTo6W0oQ+2wy/4A==
X-CSE-MsgGUID: YYFe2fSZTg2GiuORSfXuQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="92636543"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="92636543"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 03:44:05 -0700
X-CSE-ConnectionGUID: qkUvEd4bS0yoJVWuqew3mg==
X-CSE-MsgGUID: t8MEScW6QbC6ScQLfcmjaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; d="scan'208";a="247016999"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa002.fm.intel.com with ESMTP; 23 Mar 2026 03:44:04 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH] net/i40e: fix FDIR VLAN TCI partial mask validation
Date: Mon, 23 Mar 2026 10:43:45 +0000
Message-ID: <20260323104345.1667974-1-ciara.loftus@intel.com>
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

Currently, the i40e flow validation logic accepts some partial VLAN TCI
masks alongside the full mask, and reports an error for any other value.
This is broken in two ways.

First, the error case is not handled correctly. An error is recorded
however execution continues as normal, and a filter is programmed using
the invalid mask, silently producing wrong matching behaviour.

Second, the hardware always compares the full 16-bit TCI field with no
per-bit masking. Partial masks are therefore not honoured and should not
be accepted.

Fix this by accepting only either a wildcard or exact match mask and
handle the invalid mask cases appropriately.

Bugzilla ID: 1340
Fixes: 81aebb47d1 ("net/i40e: fix flow director for eth + VLAN pattern")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_flow.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_flow.c b/drivers/net/intel/i40e/i40e_flow.c
index 84cfddb92d..9369256b48 100644
--- a/drivers/net/intel/i40e/i40e_flow.c
+++ b/drivers/net/intel/i40e/i40e_flow.c
@@ -30,9 +30,6 @@
 #define I40E_IPV6_FRAG_HEADER	44
 #define I40E_TENANT_ARRAY_NUM	3
 #define I40E_VLAN_TCI_MASK	0xFFFF
-#define I40E_VLAN_PRI_MASK	0xE000
-#define I40E_VLAN_CFI_MASK	0x1000
-#define I40E_VLAN_VID_MASK	0x0FFF
 
 static int i40e_flow_validate(struct rte_eth_dev *dev,
 			      const struct rte_flow_attr *attr,
@@ -1765,22 +1762,19 @@ i40e_flow_parse_fdir_pattern(struct rte_eth_dev *dev,
 
 			RTE_ASSERT(!(input_set & I40E_INSET_LAST_ETHER_TYPE));
 			if (vlan_spec && vlan_mask) {
-				if (vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_TCI_MASK) &&
+				if (vlan_mask->hdr.vlan_tci != 0 &&
 				    vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_PRI_MASK) &&
-				    vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_CFI_MASK) &&
-				    vlan_mask->hdr.vlan_tci !=
-				    rte_cpu_to_be_16(I40E_VLAN_VID_MASK)) {
+				    rte_cpu_to_be_16(I40E_VLAN_TCI_MASK)) {
 					rte_flow_error_set(error, EINVAL,
 						   RTE_FLOW_ERROR_TYPE_ITEM,
 						   item,
 						   "Unsupported TCI mask.");
+					return -rte_errno;
+				}
+				if (vlan_mask->hdr.vlan_tci != 0) {
+					input_set |= I40E_INSET_VLAN_INNER;
+					filter->input.flow_ext.vlan_tci = vlan_spec->hdr.vlan_tci;
 				}
-				input_set |= I40E_INSET_VLAN_INNER;
-				filter->input.flow_ext.vlan_tci =
-					vlan_spec->hdr.vlan_tci;
 			}
 			if (vlan_spec && vlan_mask && vlan_mask->hdr.eth_proto) {
 				if (vlan_mask->hdr.eth_proto != RTE_BE16(0xffff)) {
-- 
2.43.0

