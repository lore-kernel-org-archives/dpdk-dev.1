Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F821C87FCF
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:40:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E2F44069D;
	Thu,  7 Aug 2025 14:40:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 947A34066F
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:40:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570404; x=1786106404;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YSHU2SnnEN2BUtxtU8Kx3HcDrSPxFmC2StzOpvDYE8g=;
 b=JA6Ty1BzOGx6A+KDUMBGo6fIFHkANTPHByzm+uJ8gtiTWtb9wMPWP6V0
 U3vz35opLnsZn0N0L2ge7R9bK1PJQtezjJvL4JW+Kl6urUNVEfdGPx5KA
 8xDYokrP183DTMISsfoJagLEEBup1gQrY6coXGcuGostdFB2u74LmrdhW
 yBfOXOqR5UeSfX5Vv0lLDGdXQeZyqZKaHYbKxrEfV8YA84TwD1fl0StrT
 1olr0jl1Y5ajDC4FbMosTYi3uANnEkeAW33GIWwSMiWkWtDisTpnmrnpk
 sB3/82B3giX5LJtBGnBkuo6NQ/n9TMazHNlokeQlOKEUYpsigZslGd/x4 A==;
X-CSE-ConnectionGUID: ca5An3XMS6Kmojx5/jhsWA==
X-CSE-MsgGUID: RmUjrWcxToC84XXRg3YHpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981126"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981126"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:40:04 -0700
X-CSE-ConnectionGUID: 5Zq89vhLQOuwo81eZFoI6w==
X-CSE-MsgGUID: QS0uimLFTPqRGu8IKXUY6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886756"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:40:03 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 09/15] net/iavf: remove redundant field from iavf adapter
 struct
Date: Thu,  7 Aug 2025 12:39:43 +0000
Message-Id: <20250807123949.4063416-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807123949.4063416-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
 <20250807123949.4063416-1-ciara.loftus@intel.com>
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

The variable rx_vec_allowed was only used in one function, so
it's not necessary to have it part of the iavf_adapater structure.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/iavf/iavf.h        | 1 -
 drivers/net/intel/iavf/iavf_ethdev.c | 1 -
 drivers/net/intel/iavf/iavf_rxtx.c   | 6 ++----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index dacfb92d5f..69f9abbef3 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -375,7 +375,6 @@ struct iavf_adapter {
 
 	bool rx_bulk_alloc_allowed;
 	/* For vector PMD */
-	bool rx_vec_allowed;
 	bool tx_vec_allowed;
 	alignas(RTE_CACHE_LINE_MIN_SIZE) uint32_t ptype_tbl[IAVF_MAX_PKT_TYPE];
 	bool stopped;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 335a8126c4..33b00e8ae4 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -668,7 +668,6 @@ iavf_dev_configure(struct rte_eth_dev *dev)
 	/* Initialize to TRUE. If any of Rx queues doesn't meet the
 	 * vector Rx/Tx preconditions, it will be reset.
 	 */
-	ad->rx_vec_allowed = true;
 	ad->tx_vec_allowed = true;
 
 	if (dev->data->dev_conf.rxmode.mq_mode & RTE_ETH_MQ_RX_RSS_FLAG)
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index e36a07d5ac..367dde89ca 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -725,12 +725,10 @@ iavf_dev_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		ad->rx_bulk_alloc_allowed = false;
 	}
 
-	if (!ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads))
-		ad->rx_vec_allowed = false;
-
 #if defined RTE_ARCH_X86 || defined RTE_ARCH_ARM
 	/* check vector conflict */
-	if (ad->rx_vec_allowed && iavf_rxq_vec_setup(rxq)) {
+	if (ci_rxq_vec_capable(rxq->nb_rx_desc, rxq->rx_free_thresh, rxq->offloads) &&
+			iavf_rxq_vec_setup(rxq)) {
 		PMD_DRV_LOG(ERR, "Failed vector rx setup.");
 		return -EINVAL;
 	}
-- 
2.34.1

