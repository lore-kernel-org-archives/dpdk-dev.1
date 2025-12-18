Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DDAD6D237
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 15:43:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A51E40647;
	Thu, 18 Dec 2025 16:42:53 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id D0A874026A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 16:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766072571; x=1797608571;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZBSYE9V+luyzc+0YQm5E/ue/8S/srNFQfW5AmTGb/lA=;
 b=I2yPgAyKCTmCVafnMyFg24DMcNNfq2W6HsociImqHq5bElzfKaa5dkY2
 /3VmQ+BqmTnEUT2XaQM7q4950w7yQ7bhmHdVP+NVgXuzjJYfW/LQO0SQA
 gRWjdWLENATZYTiz2CK0Ynag7qvBMwuOFAL1i/QVKNWXvQRSSlbLcEAWP
 FOxc8HSi5sJiPGu22SfbehMfgaOGBp3CpF3Shy0feZLoTDxtOO0Hmg+pV
 DyCEAhiM/RPXvXFBRPXRCbDBsTNGzvMZViCfYyD+k17m1iW+cOp03IaAv
 nm9VqT04eyAoFf49YMdIJw8WRyoFTgUJlLkc4ypzo9ooXAp9IU6cNHMmG g==;
X-CSE-ConnectionGUID: 3nHEwOlbSS+bdK1+1+nQBQ==
X-CSE-MsgGUID: WIRNYWTwR4Onc+O/pgl+dA==
X-IronPort-AV: E=McAfee;i="6800,10657,11646"; a="78742495"
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="78742495"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2025 07:42:50 -0800
X-CSE-ConnectionGUID: M1vBY2buSZqC/E29RmpFYw==
X-CSE-MsgGUID: jfZgJaSeScaOHEnxz40Wzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,158,1763452800"; d="scan'208";a="197861552"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa010.jf.intel.com with ESMTP; 18 Dec 2025 07:42:50 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 2/2] net/i40e: unset vector flag when scalar path is chosen
Date: Thu, 18 Dec 2025 15:42:43 +0000
Message-ID: <20251218154244.4001917-3-ciara.loftus@intel.com>
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

The tx_vec_allowed flag should be set to false if a scalar Tx path is
chosen.

Fixes: 1ff08bb7ad90 ("net/i40e: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index cde60cc7bd..290fec2b0a 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3631,6 +3631,10 @@ i40e_set_tx_function(struct rte_eth_dev *dev)
 			ad->tx_func_type == I40E_TX_ALTIVEC ||
 			ad->tx_func_type == I40E_TX_AVX2)
 		dev->recycle_tx_mbufs_reuse = i40e_recycle_tx_mbufs_reuse_vec;
+
+	ad->tx_vec_allowed =
+		(i40e_tx_path_infos[ad->tx_func_type].features.simd_width >= RTE_VECT_SIMD_128);
+
 }
 
 int
-- 
2.43.0

