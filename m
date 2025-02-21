Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B93C021B3
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Feb 2025 08:54:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCBA240647;
	Fri, 21 Feb 2025 09:54:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id 2167E4029A;
 Fri, 21 Feb 2025 09:54:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740128059; x=1771664059;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FJRYWyKn0rtSyLqpxNHcjzIdd3GQJAORsON4DhHRKMw=;
 b=moi6NpltZb5EWf3cZ4F24mVqfQiBJSVGpAI2VR8IeCYcokT2irAZOR3U
 SFoFgta0czJBZ+vo8jvlfUKXa3lDmsfchVVbmbYrnbEDbkSeqXbCMz9qc
 M7kN6zLNimrQ2Zti+IqkicAjXA7iJMbXDWt3tn1bpi9SU3H+YEyIOPo1d
 gU+DS5hg5S7J/zEywlqbSk+0Hw/NVbnoXuAo51kBCr4Xld+K/7CYdXFEA
 tNeunybH+SGnqqo+WgfOvH3tk+02S/I5XGJ2+OD1h2sboOKn165bauQQu
 f0IT9UcamplaJhT6lw4T8Dr152HYkn8eWfK6eIMRqcfhDtmLgUrk0A+c3 A==;
X-CSE-ConnectionGUID: NkCKnMADQ8O+lx6f5ZGIsw==
X-CSE-MsgGUID: voxVL3yyRMS4LzFu/zbbVw==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="51156663"
X-IronPort-AV: E=Sophos;i="6.13,304,1732608000"; d="scan'208";a="51156663"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 00:54:17 -0800
X-CSE-ConnectionGUID: ELieNMBAQVyM123OgcVpnA==
X-CSE-MsgGUID: 17Kl0oToT9qsUUWoUf3jVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115156997"
Received: from unknown (HELO localhost.localdomain) ([10.239.252.253])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Feb 2025 00:54:16 -0800
From: Mingjin Ye <mingjinx.ye@intel.com>
To: dev@dpdk.org
Cc: Mingjin Ye <mingjinx.ye@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH] net/ixgbe: fix min Rx/Tx descriptors
Date: Fri, 21 Feb 2025 08:23:18 +0000
Message-Id: <20250221082318.331815-1-mingjinx.ye@intel.com>
X-Mailer: git-send-email 2.25.1
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

Fixes: dee5f1fd5fc7 ("ixgbe: get queue info and descriptor limits")
Cc: stable@dpdk.org

Signed-off-by: Mingjin Ye <mingjinx.ye@intel.com>
---
 doc/guides/nics/ixgbe.rst            | 2 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/ixgbe.rst b/doc/guides/nics/ixgbe.rst
index c5c6a6c34b..10a0cdd270 100644
--- a/doc/guides/nics/ixgbe.rst
+++ b/doc/guides/nics/ixgbe.rst
@@ -76,7 +76,7 @@ Scattered packets are not supported in this mode.
 If an incoming packet is greater than the maximum acceptable length of one "mbuf" data size (by default, the size is 2 KB),
 vPMD for RX would be disabled.
 
-By default, IXGBE_MAX_RING_DESC is set to 8192 and RTE_PMD_IXGBE_RX_MAX_BURST is set to 32.
+By default, IXGBE_MAX_RING_DESC is set to 8192 and RTE_PMD_IXGBE_RX_MAX_BURST is set to 64.
 
 Windows Prerequisites and Pre-conditions
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
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

