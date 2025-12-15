Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68C8D5B16E
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Dec 2025 14:08:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 905E740657;
	Mon, 15 Dec 2025 15:08:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 247364026F;
 Mon, 15 Dec 2025 15:08:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765807684; x=1797343684;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gkSovvBH+NxQsGRdKd9IWc0YmOvekipEK9GNf73d1HA=;
 b=aCii525HHIog+XMNXdfc+YZzWaGQm22/Wyzmu0pUwgiTyR5Ageho4yO2
 Snp9OigGf+iWcY/An1mbsUGh9JZj7sJNTna+5D7V0lGrIai5QxH9PtAwH
 qCLe+WflesuGbAvWxHPfKHpUodWjfN4bsAr2ZKIDY3eZ45Sy77+qKHqVx
 w11IcMDUk6bSa2WNytL7Zk1ws7wp7ELJvJ4IMbaWBQFat6+Os5svnFJpI
 kZbA9mp490GQkbsvhyda1Z4bPkvQTjiWx3s7LX6IEGJqPBRNWHoZZsoEi
 6h0GhJBJLhA1xoYRdI+y7SQ9asoBxjRTHrBnIXAcr8GCS2x33ViP7MrlQ Q==;
X-CSE-ConnectionGUID: yE650IssQ/6wlkPt0v94Ug==
X-CSE-MsgGUID: PH1o1Lm8RZ2MqiYt/ctRgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79078699"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="79078699"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2025 06:07:53 -0800
X-CSE-ConnectionGUID: q29g98YDRTe0z3oFanMNGQ==
X-CSE-MsgGUID: 7Z2YRUOTSWKciQT1iItXvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="196996417"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 15 Dec 2025 06:07:52 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 7/8] net/ice: ensure all Rx paths are selectable
Date: Mon, 15 Dec 2025 14:05:52 +0000
Message-ID: <20251215140553.2283531-8-ciara.loftus@intel.com>
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
Fix this by editing the ice_rx_func_type enum and only defining a value
for the Rx path if it is implemented in the ice_rx_path_infos array.

Fixes: 872b57178709 ("net/ice: use common Rx path selection infrastructure")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index d1d31760d5..b682df0717 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -196,16 +196,20 @@ enum ice_rx_func_type {
 	ICE_RX_DEFAULT,
 	ICE_RX_SCATTERED,
 	ICE_RX_BULK_ALLOC,
+#ifdef RTE_ARCH_X86
 	ICE_RX_SSE,
 	ICE_RX_SSE_SCATTERED,
 	ICE_RX_AVX2,
 	ICE_RX_AVX2_SCATTERED,
 	ICE_RX_AVX2_OFFLOAD,
 	ICE_RX_AVX2_SCATTERED_OFFLOAD,
+#ifdef CC_AVX512_SUPPORT
 	ICE_RX_AVX512,
 	ICE_RX_AVX512_SCATTERED,
 	ICE_RX_AVX512_OFFLOAD,
 	ICE_RX_AVX512_SCATTERED_OFFLOAD,
+#endif /* CC_AVX512_SUPPORT */
+#endif /* RTE_ARCH_X86 */
 };
 
 enum ice_tx_func_type {
-- 
2.43.0

