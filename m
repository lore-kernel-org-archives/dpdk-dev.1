Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6324CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:07:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 150BE40E3A;
	Wed, 15 Oct 2025 12:07:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id B8B4040A82;
 Wed, 15 Oct 2025 12:07:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760522854; x=1792058854;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b7k4I/wq10pSx7ISqgjCMEHcOGGBFPpD5vQPQoQ2jjo=;
 b=SJJAdvjz89+MMt4h2claTAjTZGSl2j0qkhUZi3Dyu+XSDKxWG8jWhaQe
 LEQ/43zhOJo605miOxN07J33+c/kcne1iBTnYfVmOrVeUhg1DWOjo/S9k
 5y/vlFtWXuRDsAPg1nC8suPw5oMgMIiWXW6tKAHA+bnj/ZDr+QmORNSRx
 MkmdkBlqmjWgqInvRDcn97QKAYoE0nIh87Vz0Lc2ZRmFdnyIWttolVvcy
 jtKHLJoi/5601N+V6xfFr/B+SboODCvGuYw2XhIfFKTdJJKBMTSWOYGs/
 r0zVpnRTYZwd9Yi2WNb+edpND6gxIz3Fvsg85p9CfxI3sKda85B8k3+uL A==;
X-CSE-ConnectionGUID: dayZm+PARB+n7c7tlMhfyA==
X-CSE-MsgGUID: Kbfo3efASO+fsVOTWPsVfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73371791"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="73371791"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:07:33 -0700
X-CSE-ConnectionGUID: Vq69myZNTa6YQMV0lE/Bxw==
X-CSE-MsgGUID: Jr1cSvO9QliIeJVb3u1IYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181262613"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 03:07:32 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v2 3/7] net/iavf: fix Rx paths feature definitions
Date: Wed, 15 Oct 2025 10:07:19 +0000
Message-Id: <20251015100723.1603296-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015100723.1603296-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
 <20251015100723.1603296-1-ciara.loftus@intel.com>
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

Two rx paths had incorrect feature and offload definitions
which led to incorrect path selections. Fix these.

Remove timestamp offload from the list of offloads
supported by paths that use the flexible rx descriptor. It
is only available in the "offload" versions of those paths.

Fixes: 91e3205d72d8 ("net/iavf: use common Rx path selection infrastructure")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 5 +++--
 drivers/net/intel/iavf/iavf_rxtx.h | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index f500ba030f..d3bf062619 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -3768,13 +3768,14 @@ static const struct ci_rx_path_info iavf_rx_path_infos[] = {
 			{.scattered = true, .flex_desc = true, .bulk_alloc = true}}},
 	[IAVF_RX_AVX2_FLEX_RXD_OFFLOAD] = {
 		iavf_recv_pkts_vec_avx2_flex_rxd_offload, "Vector AVX2 Flex Offload",
-			{IAVF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_256,
+			{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS, RTE_VECT_SIMD_256,
 				{.flex_desc = true, .bulk_alloc = true}}},
 	[IAVF_RX_AVX2_SCATTERED_FLEX_RXD_OFFLOAD] = {
 		iavf_recv_scattered_pkts_vec_avx2_flex_rxd_offload,
 		"Vector Scattered AVX2 Flex Offload",
 		{IAVF_RX_VECTOR_OFFLOAD_FLEX_OFFLOADS | RTE_ETH_RX_OFFLOAD_SCATTER,
-			RTE_VECT_SIMD_256, {.flex_desc = true, .bulk_alloc = true}}},
+			RTE_VECT_SIMD_256,
+			{.scattered = true, .flex_desc = true, .bulk_alloc = true}}},
 #ifdef CC_AVX512_SUPPORT
 	[IAVF_RX_AVX512] = {iavf_recv_pkts_vec_avx512, "Vector AVX512",
 		{IAVF_RX_VECTOR_OFFLOADS, RTE_VECT_SIMD_512, {.bulk_alloc = true}}},
diff --git a/drivers/net/intel/iavf/iavf_rxtx.h b/drivers/net/intel/iavf/iavf_rxtx.h
index 3f461efb28..44be29caf6 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.h
+++ b/drivers/net/intel/iavf/iavf_rxtx.h
@@ -83,7 +83,6 @@
 /* vector paths that use the flex rx desc */
 #define IAVF_RX_VECTOR_FLEX_OFFLOADS (			\
 		IAVF_RX_VECTOR_OFFLOADS |		\
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP |		\
 		RTE_ETH_RX_OFFLOAD_SECURITY)
 /* vector offload paths */
 #define IAVF_RX_VECTOR_OFFLOAD_OFFLOADS (		\
-- 
2.34.1

