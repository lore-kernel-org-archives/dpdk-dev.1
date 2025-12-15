Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1B9D5B16C
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3578940615;
	Mon, 15 Dec 2025 15:07:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 5392B402D0;
 Mon, 15 Dec 2025 15:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807672; x=1797343672;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tXb/O5HWTy0kL7ElnaWSQ+4FKAq9K02UCf+QMzR+0Bo=;
 b=AkGBn9+jdQ+krSr+E8SZHVYoNvx0gzixWrXYiwknbvoeHOH6IFepGJlx
 3f0skWNbs6vdiyzACqOiGVjUlVi2a8iByYk6GEvZXDOcXCfvKhfENpJxq
 syyd73tMVHljcP1F1G796vFPC16yGEsRdcp10eNTCFE58I/GjfYkbT2K+
 oFPOvMLncQ/ticQ+ROAgL8nxW5BYBbG0S6SQu8OEISilaI8XM14QPPVKm
 ZvZK9ZUU6/OZWCRDLsKcDOkAlHAKu4RUrfMiTDOH6oRAqrRe+oGD/eP7b
 JhcL0tjHdy24hBrKqfdMGOfSYzv2Mu797zh+R4lbHY9CdohJFAY2gjdpQ Q==;
X-CSE-ConnectionGUID: zzZY7WPlS762JXK0e/eH8A==
X-CSE-MsgGUID: wZmlkKIhSoS4BUhyQTn0XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078691"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078691"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:51 -0800
X-CSE-ConnectionGUID: oAnzlUXdT0WilYh3KQTW+w==
X-CSE-MsgGUID: ZkuZc7dgRxyD332tP+KY6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996405"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:50 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 5/8] net/i40e: ensure all Rx paths are selectable
Date: Mon, 15 Dec 2025 14:05:50 +0000
Message-ID: <20251215140553.2283531-6-ciara.loftus@intel.com>
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
different set of Rx paths are defined. The Rx path selection function
iterates sequentially from zero to num_paths where num_paths is the size
of the array as determined by the RTE_DIM macro. However, depending on
the platform, some of these entries may be empty, and valid entries at
the end of the array may never be considered in the selection function.
Fix this by editing the i40e_rx_func_type enum and only defining a value
for the Rx path if it is implemented in the i40e_rx_path_infos array.

Fixes: 3f24891594c1 ("net/i40e: use common Rx path selection infrastructure")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index c3240be960..6d729f6ae9 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1231,16 +1231,22 @@ enum i40e_rx_func_type {
 	I40E_RX_DEFAULT,
 	I40E_RX_SCATTERED,
 	I40E_RX_BULK_ALLOC,
+#ifdef RTE_ARCH_X86
 	I40E_RX_SSE,
 	I40E_RX_SSE_SCATTERED,
 	I40E_RX_AVX2,
 	I40E_RX_AVX2_SCATTERED,
+#ifdef CC_AVX512_SUPPORT
 	I40E_RX_AVX512,
 	I40E_RX_AVX512_SCATTERED,
+#endif
+#elif defined(RTE_ARCH_ARM64)
 	I40E_RX_NEON,
 	I40E_RX_NEON_SCATTERED,
+#elif defined(RTE_ARCH_PPC_64)
 	I40E_RX_ALTIVEC,
 	I40E_RX_ALTIVEC_SCATTERED,
+#endif
 };
 
 enum i40e_tx_func_type {
-- 
2.43.0

