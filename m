Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84826CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 15:27:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7128140A82;
	Wed,  5 Nov 2025 16:26:57 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E33114021F
 for <dev@dpdk.org>; Wed,  5 Nov 2025 16:26:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762356416; x=1793892416;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IuaXTPmk7BbPC/lBYrRHob0OCWtqrpXr5TOA1jy9Q/Q=;
 b=E7Lm4yxiYX+Y5vlMm8saYl5NpipeAZW0jRRnKpKkQ3fRBGtduB+c6uLY
 u0WuZxax33PvmmP8Hdv2+4u80zpgQ5NMdNh51dtVPA9kqy3cLxZETanUw
 ovMYEVLDJ6Cz529gb8NSaw/e0HgV3mThHUWRnjGzI2Vc88y9ZyjZ5HfXU
 PL1Mnc94xOJh61R6ktSmJ0lQj4V8ZwIRwzcqqH1PikIkRs5zisj0iDJgf
 oYRXRr+7PCcJ4BOh1bHrNO0rY4dLn3TZ+JcfkRilQi3cQMf+FPWLhTUEB
 B7xxtaU/nfoH9D1goUk8k97Bn0+Bjg4W8U0bJBg4aeds2167s5Gti4x79 A==;
X-CSE-ConnectionGUID: q1znYsEaQrK/reAMviGe0w==
X-CSE-MsgGUID: olkNjwY3ROWVyoUTZYg9Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="68127082"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="68127082"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 07:26:55 -0800
X-CSE-ConnectionGUID: GHnKf7TgQ4amrEvzNPWuIA==
X-CSE-MsgGUID: 1PI2HMozQRGNZ4cZcZuNbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; d="scan'208";a="218257304"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa001.fm.intel.com with ESMTP; 05 Nov 2025 07:26:54 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 1/6] net/iavf: fix compilation with VLAN insertion disabled
Date: Wed,  5 Nov 2025 15:26:37 +0000
Message-Id: <20251105152642.2981673-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105152642.2981673-1-ciara.loftus@intel.com>
References: <20251031152250.2441980-1-ciara.loftus@intel.com>
 <20251105152642.2981673-1-ciara.loftus@intel.com>
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

If IAVF_TX_VLAN_QINQ_OFFLOAD is undefined there will be an unused
variable warning. Fix this.

Fixes: 3aa4efa36438 ("net/iavf: support VLAN insertion in AVX512 Tx")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
index f513777663..5ac96f239b 100644
--- a/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
+++ b/drivers/net/intel/iavf/iavf_rxtx_vec_common.h
@@ -164,7 +164,12 @@ iavf_tx_vec_dev_check_default(struct rte_eth_dev *dev)
 
 static __rte_always_inline void
 iavf_txd_enable_offload(__rte_unused struct rte_mbuf *tx_pkt,
-			uint64_t *txd_hi, uint8_t vlan_flag)
+			uint64_t *txd_hi,
+#ifdef IAVF_TX_VLAN_QINQ_OFFLOAD
+			uint8_t vlan_flag)
+#else
+			__rte_unused uint8_t vlan_flag)
+#endif
 {
 #if defined(IAVF_TX_CSUM_OFFLOAD) || defined(IAVF_TX_VLAN_QINQ_OFFLOAD)
 	uint64_t ol_flags = tx_pkt->ol_flags;
-- 
2.34.1

