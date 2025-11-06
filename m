Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B83CCFA05
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:11:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E474E40DCE;
	Thu,  6 Nov 2025 15:10:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTP id 10C2A4060B
 for <dev@dpdk.org>; Thu,  6 Nov 2025 15:10:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438216; x=1793974216;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0bw+q9bGeOZOrvoSVwOEz3enBI8+2KSyF/gtOThlvpE=;
 b=T8rv+ufo1Wk0rdvq82GTckb1/WLUOuVdx4vtHczf/KT26kj5EvUg/8uS
 evXeT9l4YH2us5RDb2zUCx5L3SN8/CgIVyHlz1iZt9AsUwSgf6dLycwuW
 Gin9EJlWLMibMUllqBU2HYx8RsyPTV4rCx7LDip5Y6yPng/9QjNbvW10T
 Hg1Y+of0jxZdzJwvAcop6toEzYjDpOmAvjGLd7U8pPjBmbTCH8Zjqn1Ox
 gIzHGCOnNSPj+nJN70ojlQgpBYXFYIavKvqBXfEpaJ6tU7TdcYuEeciFA
 GtcqG+rKc/W86MJuBvph7xpyq0pHKY0AD5Z/fi1tGKN+cRwzOeQM4XgVD Q==;
X-CSE-ConnectionGUID: tFnDYHuTQPe8lCQ0C45JlQ==
X-CSE-MsgGUID: GZnShBnSQGO4LZM2tZci6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="67185323"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="67185323"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:10:16 -0800
X-CSE-ConnectionGUID: wWlqY/IUTV2MuB5B6lSPQg==
X-CSE-MsgGUID: 2+yTvDGoTaCbfrsvCBDSIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054762"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:10:15 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 13/19] net/intel: rename function param to avoid shadow
 warnings
Date: Thu,  6 Nov 2025 14:09:42 +0000
Message-ID: <20251106140948.2894678-14-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

The rx_free_thresh parameter was conflicting with a global value in
testpmd when certain driver-specific files were included in the testpmd
build. Rename the parameter to just "free_thresh" - the "rx" is
unnecessary since the function itself is for Rx queues.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/rx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index 5012e4fced..80b62ce3d5 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -228,11 +228,11 @@ ci_rxq_mbuf_initializer(uint16_t port_id)
  * Individual drivers may have other further tests beyond this.
  */
 static inline bool
-ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh)
+ci_rxq_vec_capable(uint16_t nb_desc, uint16_t free_thresh)
 {
 	if (!rte_is_power_of_2(nb_desc) ||
-			rx_free_thresh < CI_RX_MAX_BURST ||
-			(nb_desc % rx_free_thresh) != 0)
+			free_thresh < CI_RX_MAX_BURST ||
+			(nb_desc % free_thresh) != 0)
 		return false;
 
 	return true;
-- 
2.48.1

