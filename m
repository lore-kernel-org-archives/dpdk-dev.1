Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B161EC1E91
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:30:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5733140E68;
	Thu,  5 Feb 2026 11:30:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id DB99640264;
 Thu,  5 Feb 2026 11:30:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287429; x=1801823429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9mxlPWZbTHWZRj7O3gcBAM+l7gjkzTO3LOOKzEpmldQ=;
 b=lQSKCaoJ0pvba9f2OweRo5uFb8VUxEtouEJ9FvXpJa2bPoSbu9y1wU6O
 Eod6c8PhJxV7kwXhDeQLtVJFSZkDUl9qkpzHnINlS+066J8SiW2Nrymla
 Ze83OU6mU0jf3o/gTazAot5tCxB3qr4AVG6OYv5vn6BUetxThZjsVeZcI
 33KU4lFYA1h79NwVm6UG1H/sXbUV6Or4aQAmT2fqLn7t0/rUAzhLCDaN0
 jq2natvkZq/YbLAobKyztZXOZogQuZPH0IHDrB34zfAYTtICixXHO0mDr
 jrTaHgPk1iuuSm+U5NfhiIPR8sCP0jZ2+NxXwM8yT0IcCweLlcSI7l45X w==;
X-CSE-ConnectionGUID: VkAfRVTSTSmqZaiq3gHlmQ==
X-CSE-MsgGUID: c6wLxX2ATSyxaXlR/m28uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064770"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064770"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:28 -0800
X-CSE-ConnectionGUID: vasxStsVQu63usReePpTsg==
X-CSE-MsgGUID: VB1H4M7CSPeCK/ZV76EPGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447562"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:28 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 03/10] net/ice: permit secondary process Rx path selection
Date: Thu,  5 Feb 2026 10:30:01 +0000
Message-ID: <20260205103008.190493-4-ciara.loftus@intel.com>
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

Commit 197e70fb8961 ("net/ice: use same Rx path across processes")
changed the way that secondary processes selected their Rx burst
function. Instead of letting secondary processes select their own
function, they now used the function selected by the primary process.
However, the primary process only selects the function at device start,
so if the primary process hadn't started the device by the time the
secondary process was selecting its Rx burst function, the secondary
process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 197e70fb8961 ("net/ice: use same Rx path across processes")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index f3bc79423d..bbd9cfa7a5 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -3822,8 +3822,8 @@ ice_set_rx_function(struct rte_eth_dev *dev)
 		.simd_width = RTE_VECT_SIMD_DISABLED,
 	};
 
-	/* The primary process selects the rx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 #ifdef RTE_ARCH_X86
-- 
2.43.0

