Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717E7CA0EC0
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 11:00:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 29AEF4069F;
	Mon, 18 Aug 2025 12:59:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id CD4B14067E
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514783; x=1787050783;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VyDoYs5qsXoQqjlcN0Hd/5U+Xd18LGmdTCGMXN21dM0=;
 b=nWbTvnpUGS4ujUC3DfsCYq1DCcmU651cyKEJ5fxdrjAwqe4CTXQNnH4H
 6+EStGE7rWnzSTm7JAQBfrHj0ZNxNKwJMQ67rSCY3w6XTFz6XW4BaklFE
 Q6m8yvr8Hx8+X6qiI9hiEfkufhMXbMF3sozMKmMYARAbVGtv9crtcWNDH
 HvqnliAFpX7UsfNnGPlSRHUW9TTXo5CyH1NxHbJmI57TvjMEdo9EqgGdT
 gymIKjLUFtKny1kjemxYLUUZHuLum/S3JeMIaPHybsvU4x2Fy2MD3R5gO
 zgqPwoPaVT9fBkt8XXOEcbNFAiUS3anyug0rFk6S1LgySDgjhBu+MOfjJ w==;
X-CSE-ConnectionGUID: 0WagivYMSVqYq4VP/mb3QQ==
X-CSE-MsgGUID: MhTyhJwYRBKISsDBdj17/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165437"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165437"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:42 -0700
X-CSE-ConnectionGUID: 2DQghpUNTdmnJsdRt0SBuQ==
X-CSE-MsgGUID: O7blQ6+sT82Bta5/3S4Waw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166722985"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:41 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 10/15] net/ice: remove unsupported Rx offload
Date: Mon, 18 Aug 2025 10:59:09 +0000
Message-Id: <20250818105914.169732-11-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818105914.169732-1-ciara.loftus@intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
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

The offload RTE_ETH_RX_OFFLOAD_SCTP_CKSUM is not supported in the ice
driver so remove the one erroneous use of it.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_rxtx_vec_common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_rxtx_vec_common.h b/drivers/net/intel/ice/ice_rxtx_vec_common.h
index 9430a99ba5..5529e06a8d 100644
--- a/drivers/net/intel/ice/ice_rxtx_vec_common.h
+++ b/drivers/net/intel/ice/ice_rxtx_vec_common.h
@@ -71,7 +71,6 @@ _ice_rx_queue_release_mbufs_vec(struct ci_rx_queue *rxq)
 
 #define ICE_RX_VECTOR_OFFLOAD (				\
 		RTE_ETH_RX_OFFLOAD_CHECKSUM |		\
-		RTE_ETH_RX_OFFLOAD_SCTP_CKSUM |		\
 		RTE_ETH_RX_OFFLOAD_VLAN |			\
 		RTE_ETH_RX_OFFLOAD_RSS_HASH)
 
-- 
2.34.1

