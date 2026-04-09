Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23517E98FB0
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Apr 2026 05:23:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9F1D402D3;
	Thu,  9 Apr 2026 07:23:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 61B8D402D1
 for <dev@dpdk.org>; Thu,  9 Apr 2026 07:23:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775712205; x=1807248205;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GvEE7TWOBtmgYjKE3DhhqDbw5Ede/GaKuKDpARv56nY=;
 b=mR65wpmLZWNildBjrOu4CpDoGYuKX2STrqaGf7MkLjaRKk1hAdcgXrxy
 67xbQr3gufLTB2Ml/RBm+HjqedrPS5qJc01d+DkbG5RvW1R6T8n7W6vIJ
 AYsGxL2jE7SnOw/ybR3cZsc991AGtGRZHA0/ouYmm5moQ40CJaSpylNqX
 g9U5A3gp02S8J4MdI92qc5OAiRkvTdDkFpmjQw1PZbJqzQ/pkJTFXQj+u
 6CIjHo0ESlaN+thJLGqbFjLCwn7jduXaK4po274r6y0UjfbH+x0IkpkDN
 grpkBs5USl1oUiD1c9c1dNK9jdgaRfDkRT0ZkBjJ0r3G2wNmjwo5EH9Te A==;
X-CSE-ConnectionGUID: r46SMgRBRvW3MxDj/OFcCA==
X-CSE-MsgGUID: wjwTnu4NRD+1lGtkKXMunQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="75744480"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="75744480"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 22:23:23 -0700
X-CSE-ConnectionGUID: KZtk03+XQeG530SpDSh0+w==
X-CSE-MsgGUID: 5WrLgTrfS2+YYbPyZXGj3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="225495958"
Received: from unknown (HELO sprmax15..) ([10.138.182.128])
 by fmviesa007.fm.intel.com with ESMTP; 08 Apr 2026 22:23:22 -0700
From: Shaiq Wani <shaiq.wani@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Subject: [PATCH v2] net/ice: detect L2TPv2 tunnel type in pre-scan loop
Date: Thu,  9 Apr 2026 10:48:34 +0530
Message-ID: <20260409051835.3413336-1-shaiq.wani@intel.com>
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

The pre-scan in ice_fdir_parse_pattern() recognises VXLAN and
GTPU items but not L2TPV2.  When an L2TPv2 item is present, tunnel_type
stays NONE, so the ETH item handler stores MAC addresses in the inner
ext_data struct instead of ext_data_outer resulting in rule not matching.

Add ICE_FDIR_TUNNEL_TYPE_L2TPV2 detection alongside the existing VXLAN
check.

Fixes: 733640dae75e ("net/ice: support L2TPv2 flow pattern matching")
Signed-off-by: Shaiq Wani <shaiq.wani@intel.com>
---
v2:
- Split from combined outer-MAC patch into separate fix (review feedback).

 drivers/net/intel/ice/ice_fdir_filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index 3522d77123..1cbc613020 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1911,6 +1911,8 @@ ice_fdir_parse_pattern(__rte_unused struct ice_adapter *ad,
 	for (item = pattern; item->type != RTE_FLOW_ITEM_TYPE_END; item++) {
 		if (item->type == RTE_FLOW_ITEM_TYPE_VXLAN)
 			tunnel_type = ICE_FDIR_TUNNEL_TYPE_VXLAN;
+		if (item->type == RTE_FLOW_ITEM_TYPE_L2TPV2)
+			tunnel_type = ICE_FDIR_TUNNEL_TYPE_L2TPV2;
 		/* To align with shared code behavior, save gtpu outer
 		 * fields in inner struct.
 		 */
-- 
2.43.0

