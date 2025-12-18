Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51201D6D237
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 15:42:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8BE6640609;
	Thu, 18 Dec 2025 16:42:52 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 448BE4026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 16:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766072570; x=1797608570;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=79wAPqPFmmbjncRVrUBbsiN4UEvZ8Wg13/olJkioElU=;
 b=l/y2GqymrGmSq869sSkVBKJGmokm1r1yRjYiQ5j2qyfKcilX3JZkwbue
 swZllLArjQHfeYxGqKP8SxsMw4gQmRbrC7hv/jabD5Tm/uA7KD4xS3jGF
 DgsJnhKDepAeJA9dj4/O3/a0hdggLPegUXh/TU2wF1yrQ8kDoF0HwWGZk
 tCOJ9YcOZ6h2rPoAzFktGpgK/lEnPJv3gQubIbaVq6+GjaGRMoDZDPRPe
 JPAbaTt/vbxC5HAiZsawybsZV2bl+SW2IOd+RiGtqR+S/D3Ofa4JpA43w
 79ZcczlQLoK3cH9AnohFMCB7B1Mv2vTwagpu8SiT436TgRuwCp+tiUI1Z A==;
X-CSE-ConnectionGUID: f/Fa6NTFRMamP9A1wYBYOw==
X-CSE-MsgGUID: G76tlg0nQGi1v5Hd0Zh0Vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="78742493"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="78742493"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 07:42:50 -0800
X-CSE-ConnectionGUID: VwSxlTYFRqiXQhfC6Wvdeg==
X-CSE-MsgGUID: ffa/HRRmRSyuc89XFp9R6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="197861548"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 18 Dec 2025 07:42:49 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 1/2] net/i40e: fix 32-bit Arm build
Date: Thu, 18 Dec 2025 15:42:42 +0000
Message-ID: <20251218154244.4001917-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218154244.4001917-1-ciara.loftus@intel.com>
References: <20251218154244.4001917-1-ciara.loftus@intel.com>
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

i40e_xmit_pkts_vec can be built for both aarch32 and aarch64.

Fixes: 1ff08bb7ad90 ("net/i40e: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 2db58c6b24..cde60cc7bd 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -1598,7 +1598,7 @@ static const struct ci_tx_path_info i40e_tx_path_infos[] = {
 		.pkt_prep = i40e_simple_prep_pkts,
 	},
 #endif
-#elif defined(RTE_ARCH_ARM64)
+#elif defined(RTE_ARCH_ARM)
 	[I40E_TX_NEON] = {
 		.pkt_burst = i40e_xmit_pkts_vec,
 		.info = "Vector Neon",
-- 
2.43.0

