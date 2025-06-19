Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF56C7115A
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 13:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF55242E82;
	Thu, 19 Jun 2025 15:37:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 538BD42E80
 for <dev@dpdk.org>; Thu, 19 Jun 2025 15:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750340241; x=1781876241;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=C5K3MV9r5v3RofRZaQj2CmQicYshbaMhJDk/urDtMTI=;
 b=G+ljJ+FdJv5D1JB192tm7Gz3jgPSMaXQMCGi+MbrHycOUVm5MkP0TQgd
 vWGy9RyeRWKB+7X1YBohSPwKEmoEiDsNQ6sIzT1NEe2FR/OvBuaihNtkB
 pEmsJLcOwMOggMHfdIfTJROFY3YX0PlEwxUGk08R9MP0QEKBufLmC+L7P
 dw8xRcJ04iFIM/hkI4Om5qaLZ9qB8xCETQDu/+VMvt6NviILNXWV5dBCn
 BpBbtoJSAHLSoUrl+B5nWG6WKaedZFB0xzw8okvs61ONMrDYspAq1Hruz
 iB71iNRFjEMv8VjhPQqOzg3zLqpvoNLwgw74BJuPV9atWAIB1suHOblDc Q==;
X-CSE-ConnectionGUID: /6kg6EPlQa+C8Z3Pmdi6aA==
X-CSE-MsgGUID: +ZC3fk2jSKC6HrnkJt+TLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52684328"
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="52684328"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 06:37:20 -0700
X-CSE-ConnectionGUID: IlIsV0VqTxWKD33R3RDVgw==
X-CSE-MsgGUID: UdDkdyMTQ22pv80Df/08eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,248,1744095600"; d="scan'208";a="187867123"
Received: from silpixa00401177.ir.intel.com (HELO vm177..) ([10.237.213.77])
 by orviesa001.jf.intel.com with ESMTP; 19 Jun 2025 06:37:19 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: vladimir.medvedkin@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 2/3] net/iavf: fix tx vector path selection logic
Date: Thu, 19 Jun 2025 13:36:57 +0000
Message-Id: <20250619133658.13494-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619133658.13494-1-ciara.loftus@intel.com>
References: <20250619133658.13494-1-ciara.loftus@intel.com>
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

Prior to this change, it was possible the scalar path would be selected
even if the avx-512 path was available. This was due to the ordering of
the logic in the iavf_set_tx_function function. Support for all three
vector paths (sse, avx2 and avx-512) was first established and then in
that order, the tx_burst_type was set to the appropriate type. If all
three paths were supported, then the burst type would be first set to
sse, then avx2 then avx-512. However, in the avx2 logic, if an error
was encountered then the burst type was set to a fallback option of the
scalar path. This is not desired behaviour because the avx-512 path
should be selected over the scalar path when it is available.

This commit fixes this issue by only checking for avx2 support after
deeming that avx512 is not supported.

Fixes: 77b19d1d4b2e ("net/iavf: fix mbuf release path selection")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 1ce9de0699..a7922ee44d 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -4230,16 +4230,16 @@ iavf_set_tx_function(struct rte_eth_dev *dev)
 		if (check_ret == IAVF_VECTOR_PATH) {
 			use_sse = true;
 		}
-		if ((rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
-		     rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
-		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
-			use_avx2 = true;
 #ifdef CC_AVX512_SUPPORT
 		if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1 &&
 		    rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512BW) == 1 &&
 		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_512)
 			use_avx512 = true;
 #endif
+		if (!use_avx512 && (rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX2) == 1 ||
+		     rte_cpu_get_flag_enabled(RTE_CPUFLAG_AVX512F) == 1) &&
+		    rte_vect_get_max_simd_bitwidth() >= RTE_VECT_SIMD_256)
+			use_avx2 = true;
 
 		if (!use_sse && !use_avx2 && !use_avx512)
 			goto normal;
-- 
2.34.1

