Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519CAC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:51:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95DE94067D;
	Fri, 25 Jul 2025 14:50:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A5F0D40663
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447816; x=1784983816;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vPigurZ/rGhUTPF7ZX62NsAkPtL+tHGCephtn/pa2T8=;
 b=XDrcdpyWIpK45Yb0b/xAisV/BATbrSs4c7oT3Obub2YFBB80lMfLz4VW
 1Tq42X2Ic2yHiYQ3oZKkq8aqUZErrgsG5SFqtumCnyqmTsSJuw7C3gwku
 KkVvJZLKabBRYPhsTHkpmMQmRW1KvEoFciqWX2U95prKZXE2TLOkhtVQh
 nMD5wm7mbk0OPy7YwglvSUdoRfWN072hRDW8WrxnirmNCaGZ7VLoYrby+
 4f8xjQxLm0odtOpklNMVUoVEhpojL5KtXNlyw+n3c2yzrz8po6jDrcnR5
 S1htp5l31pdMvBXv+8fkiGzmvhMsbvSoi2rCWLAsPT0kBA8Qr7kYa3Eoy Q==;
X-CSE-ConnectionGUID: bNeKOiDwR3eHP1ZLfPF2Sg==
X-CSE-MsgGUID: RfSK/SSkSFKhyjamQCZXXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480156"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480156"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:15 -0700
X-CSE-ConnectionGUID: /Ux0VeIdQCKvuupCaDIb+g==
X-CSE-MsgGUID: 5lZdndEGSaugIcH57V8pUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152318"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:14 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 09/14] net/iavf: remove redundant field from iavf adapter
 struct
Date: Fri, 25 Jul 2025 12:49:14 +0000
Message-Id: <20250725124919.3564890-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725124919.3564890-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
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

