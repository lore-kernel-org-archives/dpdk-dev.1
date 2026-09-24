Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A59C98314
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 13:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FCF542FB1;
	Thu, 24 Sep 2026 15:14:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 6F1AB42FA5;
 Thu, 24 Sep 2026 15:14:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790255678; x=1821791678;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iLjOWrR+sD7BRTy3VTPoyRur4ZnK85X+Q65QICuIfcs=;
 b=XlAjI6+Dnk8GKPXMvAdFJlhhYHQkEOr6EPSm1EBDTIvpmbIjk+AWyN++
 4dRsk+AmsM3hiDoDyQ/HaJxDpdczUYTzsNXLRJ/9LKvJ8NsTrtatQ3O4H
 EnQNVY+4jssP/8q8okWEhEBy8r5Ml4AtwvonuuKuUQfy9tGqoloEuRfv/
 2tLlgl0vsDyWQiIyXKVBvD+98m6DQx4ePZru5Ywca/NFtNA+4Xt+ZY/ZP
 4o+Rvuakk8Pu6Crt0cBcGaEjmxrUcUnUbgv7JkXkmucrf3e8g86gn7dt5
 iX18Kva8slGYOmmSHPtbwDSz5di78/LZ7PaLDMoVfjQRCJccYB7oTKgrE w==;
X-CSE-ConnectionGUID: HugAtDB4TouIPNH+NWg0FQ==
X-CSE-MsgGUID: G+Dm7sOpRp2nEradhsVO+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11914"; a="93915425"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="93915425"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2026 06:14:37 -0700
X-CSE-ConnectionGUID: e9iH9u6LTkSsZm6ifPHeFA==
X-CSE-MsgGUID: tFuCZXVQQhSunx37QD0meA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; d="scan'208";a="273518526"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 24 Sep 2026 06:14:36 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 3/6] net/i40e: drop unimplemented UDP TSO from Tx mask
Date: Thu, 24 Sep 2026 13:13:43 +0000
Message-ID: <20260924131346.100156-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924131346.100156-1-ciara.loftus@intel.com>
References: <20260924131346.100156-1-ciara.loftus@intel.com>
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

Commit d9550ce576a7 ("net/intel: create common checksum Tx offload
function") added RTE_ETH_TX_OFFLOAD_UDP_TSO to the scalar Tx offload mask
when merging i40e's checksum helper with ice's, but UDP TSO was never
actually wired up for i40e. i40e_calc_context_desc() does not trigger on
RTE_MBUF_F_TX_UDP_SEG, so no context descriptor is built for UDP
segmentation, and get_context_desc() only invokes i40e_set_tso_ctx() for
RTE_MBUF_F_TX_TCP_SEG, so the TSO fields are never programmed for a
UDP-segmented packet either.

Fix this by removing the unimplemented offload from the mask.

Fixes: d9550ce576a7 ("net/intel: create common checksum Tx offload function")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.h b/drivers/net/intel/i40e/i40e_rxtx.h
index 88d47f261e4..09773420644 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.h
+++ b/drivers/net/intel/i40e/i40e_rxtx.h
@@ -97,7 +97,6 @@ enum i40e_header_split_mode {
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |		\
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |	\
 		RTE_ETH_TX_OFFLOAD_TCP_TSO |		\
-		RTE_ETH_TX_OFFLOAD_UDP_TSO |		\
 		RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |	\
 		RTE_ETH_TX_OFFLOAD_GRE_TNL_TSO |	\
 		RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO |	\
-- 
2.43.0

