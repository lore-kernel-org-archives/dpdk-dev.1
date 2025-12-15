Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628E5D5B16E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:08:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7A21402DE;
	Mon, 15 Dec 2025 15:07:54 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id AAA054026F
 for <dev@dpdk.org>; Mon, 15 Dec 2025 15:07:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807669; x=1797343669;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XMgwh94bmT66Id50O+z6z2IRI1UVm9h/l1y/p3qdP58=;
 b=VTEIVh/hHqPepz7Y9Wu3oqkLU8EzbP8GwNDkcGWraPVH+7c6O8gYmIxZ
 tBYmCVAfcLc9z+8QkplkxsvHDaM5hi+6WFBA+gehFYqqlDmF77RbX2PnB
 hQaSr6h4PqUHJplXY9EJkcImf5gGLWNRvmJgQHRA6a68WpptJtfFqA9zw
 P/ru4SlSSZvcSOQ561EsWJjvJREpssa+/yRArb76+cZYAMjhxMc7m2Ohy
 pm+XkJxFutv/KJKK2OAS7166PMnvV9cdSvIWbK4BoMZc5DhVW4dR/MRUr
 lH+rG2fwlejjrleokdDEa88+8H97QigB64h8xIrqhKBcB6RlNcd4C+0Je Q==;
X-CSE-ConnectionGUID: IqJzqMw0T8uafjVPaz9bAg==
X-CSE-MsgGUID: 7RbP08mQTiaJj0l28W7ytQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078683"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078683"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:48 -0800
X-CSE-ConnectionGUID: GveWW90CTSi2g+PV+60yxA==
X-CSE-MsgGUID: tTO3Kt/KTkKSciAIeaCz1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996394"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:48 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 2/8] net/iavf: ensure all Tx paths are selectable
Date: Mon, 15 Dec 2025 14:05:47 +0000
Message-ID: <20251215140553.2283531-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215140553.2283531-1-ciara.loftus@intel.com>
References: <20251215140553.2283531-1-ciara.loftus@intel.com>
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

Depending on the underlying architecture and CPU flags available, a
different set of Tx paths are defined. The Tx path selection function
iterates sequentially from zero to num_paths where num_paths is the size
of the array as determined by the RTE_DIM macro. However, depending on
the platform, some of these entries may be empty, and valid entries at
the end of the array may never be considered in the selection function.
Fix this by editing the iavf_tx_func_type enum and only defining a value
for the Tx path if it is implemented in the iavf_tx_path_infos array.

Fixes: d89b61bed380 ("net/iavf: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 921bf0a607..35d3bd5671 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -353,13 +353,17 @@ enum iavf_rx_func_type {
 enum iavf_tx_func_type {
 	IAVF_TX_DISABLED,
 	IAVF_TX_DEFAULT,
+#ifdef RTE_ARCH_X86
 	IAVF_TX_SSE,
 	IAVF_TX_AVX2,
 	IAVF_TX_AVX2_OFFLOAD,
+#ifdef CC_AVX512_SUPPORT
 	IAVF_TX_AVX512,
 	IAVF_TX_AVX512_OFFLOAD,
 	IAVF_TX_AVX512_CTX,
 	IAVF_TX_AVX512_CTX_OFFLOAD,
+#endif
+#endif
 };
 
 #define IAVF_MBUF_CHECK_F_TX_MBUF        (1ULL << 0)
-- 
2.43.0

