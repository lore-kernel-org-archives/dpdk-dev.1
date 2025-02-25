Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6BEC021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 09:43:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E377E42DBE;
	Tue, 25 Feb 2025 10:43:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 3B4A3427C5;
 Tue, 25 Feb 2025 10:43:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740476618; x=1772012618;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vzy4cBPs4Oe4jU7KDAFKEjxjyW3QZu1T9uDf9Ory3U4=;
 b=YPe+//sxgTAOAlvIG9Lq8MmIdk2ojV0v6WTDdsUaOB1mG3Ij1k9vcBOY
 jbDZLBFGwdN16B+kN0hw1/c3mXKs0CMbR2zvvh2aB6hhAD8xbP4MTmC09
 ttWcfbcMx76uPY9SpIxA5MJs215dfPkpAmWdEhhcla1Afr6cXsAaVF6Ux
 wKn5cADFmmxmSxE70tpc1W71hx3gXjfJ5ZXOy9AIn1aYw5F9Xzbws8MzR
 BJOPy4Yy8pxc9Z52RGp+lHvt1GlyCTYFPZY8ZyAiyceD+D38utnYnZmZJ
 fa4HjU8RIIOkQzFODff4YzaBq40gTHnq81EsI/etwIZILA4FCeBVTbszW w==;
X-CSE-ConnectionGUID: pu+ZfnpHQYyZv65pGovrQA==
X-CSE-MsgGUID: fxaUhmxlTZm7r5a0ISdjNA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40459285"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="40459285"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:43:29 -0800
X-CSE-ConnectionGUID: ZuHJpqegRgKig4YJOZC7IQ==
X-CSE-MsgGUID: AtQe7lugRLCi/aQFoFtgdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="139571675"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 01:43:27 -0800
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2] net/ixgbe: fix min Rx/Tx descriptors
Date: Tue, 25 Feb 2025 09:12:36 +0000
Message-Id: <20250225091236.357008-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250221082318.331815-1-mingjinx.ye@intel.com>
References: <20250221082318.331815-1-mingjinx.ye@intel.com>
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

The minimum free packet threshold (tx_free_thresh) and the minimum RS bit
threshold (tx_rs_thresh) both have a default value of 32. Therefore, the
default minimum number of ring descriptors value is 64.

For reference, see "Configuration of Transmit Queues" in
doc/guides/prog_guide/ethdev/ethdev.rst

Fixes: dee5f1fd5fc7 ("ixgbe: get queue info and descriptor limits")
Cc: stable@dpdk.org

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
v2: Change doc.
---
 doc/guides/nics/ixgbe.rst            | 5 +++--
 drivers/net/intel/ixgbe/ixgbe_rxtx.h | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index c5c6a6c34b..aaed324e15 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -68,11 +68,12 @@ Ensure that the following pre-conditions are satisfied:
 
 *   (rxq->nb_rx_desc % rxq->rx_free_thresh) == 0
 
-*   rxq->nb_rx_desc  < (IXGBE_MAX_RING_DESC - RTE_PMD_IXGBE_RX_MAX_BURST)
+*   rxq->nb_rx_desc >= IXGBE_MIN_RING_DESC
+
+*   rxq->nb_rx_desc <= IXGBE_MAX_RING_DESC
 
 These conditions are checked in the code.
 
-Scattered packets are not supported in this mode.
 If an incoming packet is greater than the maximum acceptable length of one "mbuf" data size (by default, the size is 2 KB),
 vPMD for RX would be disabled.
 
diff --git a/drivers/net/intel/ixgbe/ixgbe_rxtx.h b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
index 278f665108..54569c7ade 100644
--- a/drivers/net/intel/ixgbe/ixgbe_rxtx.h
+++ b/drivers/net/intel/ixgbe/ixgbe_rxtx.h
@@ -26,7 +26,7 @@
  * descriptors should meet the following condition:
  *      (num_ring_desc * sizeof(rx/tx descriptor)) % 128 == 0
  */
-#define	IXGBE_MIN_RING_DESC	32
+#define	IXGBE_MIN_RING_DESC	64
 #define	IXGBE_MAX_RING_DESC	8192
 
 #define RTE_PMD_IXGBE_TX_MAX_BURST 32
-- 
2.25.1

