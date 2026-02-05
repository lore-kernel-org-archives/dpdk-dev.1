Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F03EEC1E97
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:31:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5953C40EE7;
	Thu,  5 Feb 2026 11:30:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id A657C40ECF
 for <dev@dpdk.org>; Thu,  5 Feb 2026 11:30:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287435; x=1801823435;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GDyv9ZhS7CIWDpz41GGZks5LscujIjxtzVQCTOOxRX8=;
 b=fNwQFMjIPiImvPuMlidotewFLO2MYAGVR3t1lJ6IyhTDQfvLLz4gtDLD
 El8jHdFRdN7cnHU2Kh0rOTGhPhIFZcSdW/6ttPRgCpS/CvZa31PAD0sFB
 m0Reju34jlw7E+eWStK+2bSWjbPkoUs9YAfeUQXiWFCKX1HrcMlhk9pLR
 Yy6BaN+ZXS5ljLbiZTWd0iGFaj93zjl5hWUjdBV/QiwqEPkQufYACZ5c3
 qL1l0adni4TroiEEOA+9/6v/8z6H5NK1Ukv/53n/ZS7/qWjtNrVoZCfHg
 rx/NG+ievpx0E1Gn42wKLPwbAVI3E7RUi20sCmSD0N6HMorjUwXRCTBZM Q==;
X-CSE-ConnectionGUID: vySsWoqLSvKinPJbo4FUoQ==
X-CSE-MsgGUID: V6D+ioirTVicJq+v43P4UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064785"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064785"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:34 -0800
X-CSE-ConnectionGUID: w1F3Xa+XRTSqDH/HOp1K0A==
X-CSE-MsgGUID: k6q1lEvTQhid+lddl11tXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447597"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:34 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH 10/10] net/cpfl: permit secondary process Tx path selection
Date: Thu,  5 Feb 2026 10:30:08 +0000
Message-ID: <20260205103008.190493-11-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205103008.190493-1-ciara.loftus@intel.com>
References: <20260205103008.190493-1-ciara.loftus@intel.com>
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

Commit 6970745698b9 ("net/cpfl: use common Tx path selection
infrastructure") changed the way that secondary processes selected their
Tx burst function. Instead of letting secondary processes select their
own function, they now used the function selected by the primary
process. However, the primary process only selects the function at
device start, so if the primary process hadn't started the device by the
time the secondary process was selecting its Tx burst function, the
secondary process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 6970745698b9 ("net/cpfl: use common Tx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/cpfl/cpfl_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/cpfl/cpfl_rxtx.c b/drivers/net/intel/cpfl/cpfl_rxtx.c
index 1de53f8827..7c0d576b75 100644
--- a/drivers/net/intel/cpfl/cpfl_rxtx.c
+++ b/drivers/net/intel/cpfl/cpfl_rxtx.c
@@ -1491,8 +1491,8 @@ cpfl_set_tx_function(struct rte_eth_dev *dev)
 		.single_queue = (vport->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)
 	};
 
-	/* The primary process selects the tx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

