Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F526CCD18E
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 08:45:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7377A40672;
	Tue, 14 Oct 2025 10:45:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 14D4A40288;
 Tue, 14 Oct 2025 10:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760431538; x=1791967538;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eyQk/PDJVeKnpNmt7AATKvn3+dbwzLIzKhbVsj6D44k=;
 b=kRFj+JTEB0fCSlM85I2OQQ4Rs/z8BBTgADlKcClfx34v7W+DT/tl5VJ1
 83gQ5tSO05iseIsRzQoCpOaI31U9D6QOJwwRlduEIdC9ad0+z90EETBEA
 I48byxgznKlyMfnQ68FHfkRjqHpx45gufKbRb+YF8yLMH1FSx5fcQABQI
 cCMaI7ToWMPH4UeSoZ52v9YnxPjipmC3C4CFVTiZf1FLJzNPowFDTx9Np
 tPkqknMCFQ3QEW3s6N8pIEqzPOLYfNeKOZiRgE/ICbqNDRyaLuH69WAFS
 WX0jL6Sh3GeVggpr4Z5aF1NG64Kcrhlz5mG2t+lQs1VUl/eilKu9yXaOA w==;
X-CSE-ConnectionGUID: Xlq99adGTXaAVfbk4XC1yg==
X-CSE-MsgGUID: oat6jCE9TYS+aYH0yZOxrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61796252"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61796252"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 01:45:38 -0700
X-CSE-ConnectionGUID: L792wWHgRMKG/Wt1Gl/TQQ==
X-CSE-MsgGUID: f9K8De5xR+CHn3BnZYn1jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181630654"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa007.jf.intel.com with ESMTP; 14 Oct 2025 01:45:37 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 2/6] net/iavf: fix Rx paths feature definitions
Date: Tue, 14 Oct 2025 08:45:13 +0000
Message-Id: <20251014084517.1407407-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014084517.1407407-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
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
index 775fb4a66f..67c73f9ad6 100644
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

