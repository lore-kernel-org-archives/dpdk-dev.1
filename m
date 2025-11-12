Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602AFCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 14:11:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE2A740A7D;
	Wed, 12 Nov 2025 15:11:09 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3494A406B6;
 Wed, 12 Nov 2025 15:11:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762956668; x=1794492668;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pMZ83ynyQSVBv8y62nEG4gCinZbyAQm0VOzWdzDIHyU=;
 b=C3PVpqTZTkTvMvITrkeJACviSasWN+41wokT9wstI5hkAKU2JoqfbFQW
 /cRk4T4MLYC/eo6uOG4tZngS81xPC76VYyYy2ywvH5rL7y7RKYKvY56nJ
 AzLZ5goVqb7PNj/AsqPzFUOFtLvHZGd9SdaWIW4YDlciw8IhYuxE5oi52
 3LKSAHl2SGV9+431b/VGnBoWhqRqUZRXAE6buIFKxoA6E7NdiOK0YriAc
 SeRNVk88A6MY5H+BIV/1qI0U+ZitTzLLAaeHHeyWxNIw62T+poJlbMX8t
 yuOe/Qk+9X41wgTrf3MKBJbFvN/lhLTZXmBUEshKZMTdhs4s3d3/QkofV w==;
X-CSE-ConnectionGUID: Q6+LCDARQ3+zTAd2ll4Jgw==
X-CSE-MsgGUID: 5SEmizQwT9SnELYLWFrIxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82415962"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="82415962"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 06:11:07 -0800
X-CSE-ConnectionGUID: +IR4JAX7SlKjm5H4GdciaA==
X-CSE-MsgGUID: yL7fY7XURwm9Sro9Z0auPQ==
X-Ironport-Invalid-End-Of-Message: True
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="226500136"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 12 Nov 2025 06:11:06 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Sunil Kumar Kori <skori@marvell.com>,
 Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org
Subject: [PATCH v2 3/3] net/fm10k: fix null packet prepare function
Date: Wed, 12 Nov 2025 14:10:59 +0000
Message-ID: <20251112141059.1576919-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251112141059.1576919-1-bruce.richardson@intel.com>
References: <20251110122457.2575615-1-skori@marvell.com>
 <20251112141059.1576919-1-bruce.richardson@intel.com>
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

As per recent change by the following commit:

commit 066f3d9cc21c ("ethdev: remove callback checks from fast path")

framework unconditionally invokes dev->tx_pkt_prepare. Ensure
dev->tx_pkt_prepare is not NULL when vector or simple TX paths are
selected, by assigning rte_eth_tx_pkt_prepare_dummy.

This aligns with expectations with above mentioned commit.

Fixes: 9b134aa39716 ("net/fm10k: add Tx preparation")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/fm10k/fm10k_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 82c0f1a1ad..97f61afec2 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -2955,7 +2955,7 @@ fm10k_set_tx_function(struct rte_eth_dev *dev)
 		} else {
 			PMD_INIT_LOG(DEBUG, "Use vector Tx func");
 			dev->tx_pkt_burst = fm10k_xmit_pkts_vec;
-			dev->tx_pkt_prepare = NULL;
+			dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 		}
 		return;
 	}
@@ -2979,7 +2979,7 @@ fm10k_set_tx_function(struct rte_eth_dev *dev)
 			fm10k_txq_vec_setup(txq);
 		}
 		dev->tx_pkt_burst = fm10k_xmit_pkts_vec;
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 	} else {
 		dev->tx_pkt_burst = fm10k_xmit_pkts;
 		dev->tx_pkt_prepare = fm10k_prep_pkts;
-- 
2.48.1

