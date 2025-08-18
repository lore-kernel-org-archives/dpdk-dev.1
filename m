Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054A9CA0EC6
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 11:00:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA15F40611;
	Mon, 18 Aug 2025 12:59:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 9BB0E4042F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514782; x=1787050782;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hFDOUzQfQt/eybDUcmjmWDpDL94pqpToaOJPOmlFXoA=;
 b=W2kvKpT/E5sNylbd8ZAhVdakDPO24cfrRyU3DUcxbfG9mRF73KIs8BlR
 W8+D99lPZ5gHioSYIl7aQM1EFRPTpdEs9QE6+viWIoRWRXh4DSjYFkMEY
 lgZiG4S9FjUyr/I+ffrl3RRKomwC607GJowtSt/6g+YHQJs2oraOL/MBd
 xPWU6FP4CRmg7k74/mQ+fZ/UPu904ph4GbhyxIe23EmnDKsjn4HY2C+2I
 MJJ/j26wSjfQPsM0N9A6jk6QVsUDDZ4On9VKaHFkPVb6Z+7cmNSXi1BuV
 3+6rTbnInrcdudmnYOwWvR6Dln7K8s+sECIf24WPPmUuHjtZ4WVROI3Yf Q==;
X-CSE-ConnectionGUID: Q44qeeD5TI+Jf2E74/l6sQ==
X-CSE-MsgGUID: h9EEGfF1Tm+Yd2/xShC9Hw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165436"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165436"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:41 -0700
X-CSE-ConnectionGUID: MfRmqTy1R6SZ/OVMylxThg==
X-CSE-MsgGUID: L8hFIADoR/+MgTuIy7t3IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166722980"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:40 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 09/15] net/iavf: remove redundant field from iavf adapter
 struct
Date: Mon, 18 Aug 2025 10:59:08 +0000
Message-Id: <20250818105914.169732-10-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250818105914.169732-1-ciara.loftus@intel.com>
References: <20250818105914.169732-1-ciara.loftus@intel.com>
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
it's not necessary to have it part of the iavf_adapter structure.

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

