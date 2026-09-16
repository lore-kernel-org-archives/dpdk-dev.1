Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB49C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 10:36:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C6CC42D99;
	Wed, 16 Sep 2026 12:36:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id AD136410FD
 for <dev@dpdk.org>; Wed, 16 Sep 2026 12:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789554991; x=1821090991;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=M+NXnRBVYrPlwzjx2pRhfvtRy6qquCtpqs7vuTmlwgo=;
 b=ityzUBTAR3TxeDU7ccs/D1Wd4xrGU4RQaHrWKDRm4CzciZREBUm8DUAI
 kwzMaDV//cFD1KYLXtPDLLXqkoqrMErG2wuaU2Aw6U0l/wGDxesQrY1ae
 Ug4UCLYNnK5YAJKpYRxyRdp/szaeu5kYH2BKyjnujnBhA0e18j8S25YU5
 yidO1Y+3dZ0s3K/65Pn+d8g6IoDJbiKtlJsnNZ85F37iSrWJtcrxQ1D9y
 nJo4vPkBl5+Jy+AtdU5g2XV4rD1Neyo6lRew/looLX6FXCoTwoVkF/Ok8
 gLjQqejUmisp9vNX7HoVKhJ85xnxUDNfEXKEbsMtloD32ikaEP1ConBoM Q==;
X-CSE-ConnectionGUID: GgwWEBLHQWK0N3kmhIXtWg==
X-CSE-MsgGUID: pZDhPjMUQiqiQ6Q8v5piuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89867622"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89867622"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 03:36:30 -0700
X-CSE-ConnectionGUID: ORv6dWTlTQSUQtufXOQIFQ==
X-CSE-MsgGUID: Ul8W9bEjSxWMMG0Gp6HNzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1528132"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa012.fm.intel.com with ESMTP; 16 Sep 2026 03:36:29 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: ciara.loftus@intel.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 02/15] net/intel: make Tx context flag common
Date: Wed, 16 Sep 2026 11:36:09 +0100
Message-ID: <20260916103622.319874-3-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916103622.319874-1-bruce.richardson@intel.com>
References: <20260903170140.360477-1-bruce.richardson@intel.com>
 <20260916103622.319874-1-bruce.richardson@intel.com>
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

The flag for enabling context descriptors in the vector paths should not
be limited to just the iavf driver, as other drivers may use context
paths in future also. Therefore move the flag out of the iavf-specific
part of the Tx queue structure, to put with other standard queue flags.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/common/tx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 2d4a8b5d3c..fb5268c972 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -173,6 +173,7 @@ struct ci_tx_queue {
 	bool tx_deferred_start; /* don't start this queue in dev start */
 	bool q_set;             /* indicate if tx queue has been configured */
 	bool use_vec_entry;     /* use sw_ring_vec (true for vector and simple paths) */
+	bool use_ctx;           /* with ctx info, each pkt needs two desc in vec paths */
 	union {                  /* the VSI this queue belongs to */
 		struct i40e_vsi *i40e_vsi;
 		struct iavf_vsi *iavf_vsi;
@@ -194,7 +195,6 @@ struct ci_tx_queue {
 #define IAVF_TX_FLAGS_VLAN_TAG_LOC_L2TAG2 BIT(1)
 			uint8_t vlan_flag;
 			uint8_t tc;
-			bool use_ctx;  /* with ctx info, each pkt needs two descriptors */
 			bool lldp_enabled;
 		};
 		struct { /* ixgbe specific values */
-- 
2.53.0

