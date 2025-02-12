Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D447C021A8
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 05:53:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 69EA642E9D;
	Thu, 13 Feb 2025 06:53:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id DAADE400D5
 for <dev@dpdk.org>; Thu, 13 Feb 2025 06:53:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739426006; x=1770962006;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=skoEzdzNtQrrMQcth5JbL8qRavxNuaADfPayZwgmtCU=;
 b=PPEmUEEGB1CdGpRvavx7dB7Gxd6WJ9Wlq+K/YITTvH0dtyAu4DJMRfs/
 vaB0iGu1hfVFxdm78OVdgl8IxAi/nqtRkuqbesQri3CFSSVYzrkpybYjJ
 AMKRdkLfDMZbntjseNl4figs3NAzmZTxnEZY8NHlVHkCqj6NNNI26Hbb1
 iYCMW20bx0nAqBZ4/DsZigYBApbu1xHXFcHQRG0ZuLsvKu6Jyf8b5u81w
 14d3QWNeEsWMU7ZgzCk3xghM36XdCKFrat5DV1DmxGE+m8RhcYs99XHFx
 fXhuhAGf7MdMGkWC5HwUzKjldqozMr+TOc2o+bmAuNLlxp4Gn19fHVrfJ g==;
X-CSE-ConnectionGUID: Cr7U8wRtTtiaoriDrf0dAg==
X-CSE-MsgGUID: r+P19HMiR/SM2/fU4O6heA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39813332"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; d="scan'208";a="39813332"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2025 21:53:25 -0800
X-CSE-ConnectionGUID: ezzeVpCCQOSh2zJuyujdFg==
X-CSE-MsgGUID: 0gO/GJnIRS2KW5XTinfRXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; d="scan'208";a="113035644"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by fmviesa007.fm.intel.com with ESMTP; 12 Feb 2025 21:53:23 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH v2 1/2] net/intel: add E830 ETF offload timestamp resolution
Date: Wed, 12 Feb 2025 21:47:10 +0000
Message-ID: <20250212214711.1046777-2-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250212214711.1046777-1-soumyadeep.hore@intel.com>
References: <20250207124300.1022523-2-soumyadeep.hore@intel.com>
 <20250212214711.1046777-1-soumyadeep.hore@intel.com>
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

From: Paul Greenwalt <paul.greenwalt@intel.com>

Update E830 ETF offload time stamp resolution to 128ns along
with certain HW defines for TXTIME_PROFILE register.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/intel/ice/base/ice_lan_tx_rx.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
index f92382346f..940c6843d9 100644
--- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
+++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
@@ -1278,6 +1278,8 @@ struct ice_ts_desc {
 #define ICE_TXTIME_MAX_QUEUE		2047
 #define ICE_SET_TXTIME_MAX_Q_AMOUNT	127
 #define ICE_OP_TXTIME_MAX_Q_AMOUNT	2047
+#define ICE_TXTIME_FETCH_TS_DESC_DFLT	8
+
 /* Tx Time queue context data
  *
  * The sizes of the variables may be larger than needed due to crossing byte
@@ -1303,6 +1305,8 @@ struct ice_txtime_ctx {
 	u8 drbell_mode_32;
 #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
 	u8 ts_res;
+#define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
+#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
 	u8 ts_round_type;
 	u8 ts_pacing_slot;
 	u8 merging_ena;
-- 
2.43.0

