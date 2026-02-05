Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E66EC1E91
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 10:30:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C2D640E3A;
	Thu,  5 Feb 2026 11:30:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 44D6D40264;
 Thu,  5 Feb 2026 11:30:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770287427; x=1801823427;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lgkG9pCe0KkwwIvhM1C9TG6Mc/X6LfgtBsTz2npNkN4=;
 b=aFBW9CXVDc3kwJ3C2xdiqBcOawj2IR9BdJqdLVORRC20HwxS+eD/e34+
 wFcpnbUX4iuUJTZA1LZeJBrRGTrYCvKwA5ogKMONZ5mHgeRX3J43SI52q
 dgfBQWk6F8qqYupj3ITcZLJ8quhAMG8p8tniqP7ZxgT+x1nMHeekzNDXN
 jg0EVf2htUQVkBOSntcPQrok8etCfgl0CjLMcCZaPXRaaRyi8FDPFnLMg
 w8ZAH7s1uDm+guVK0r4stLdeQWmcEPD5UnNtodAb7ipj+Y+g3Ygsib9uH
 s7q7NWP+P2LxFawLFul0p3w4JOhGMxrcuFBsxxfn64V+w1NT3QUI+jSJL w==;
X-CSE-ConnectionGUID: 5j7hNcc6QqG5lUWxOyXj8w==
X-CSE-MsgGUID: hSM0nYzWReiSFDvdd61N7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="89064765"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="89064765"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Feb 2026 02:30:26 -0800
X-CSE-ConnectionGUID: 71gY9sxkTPmHBpqSpqJScw==
X-CSE-MsgGUID: z9NM7KUjSQey1COztQrzqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; d="scan'208";a="210447554"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa008.fm.intel.com with ESMTP; 05 Feb 2026 02:30:26 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 01/10] net/i40e: permit secondary process Rx path selection
Date: Thu,  5 Feb 2026 10:29:59 +0000
Message-ID: <20260205103008.190493-2-ciara.loftus@intel.com>
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

Commit 258f346f5d5e ("net/i40e: use same Rx path across processes")
changed the way that secondary processes selected their Rx burst
function. Instead of letting secondary processes select their own
function, they now used the function selected by the primary process.
However, the primary process only selects the function at device start,
so if the primary process hadn't started the device by the time the
secondary process was selecting its Rx burst function, the secondary
process would not select the correct function.

This commit addresses this issue by allowing the secondary process to
select the path if the device has not been started yet.

Fixes: 258f346f5d5e ("net/i40e: use same Rx path across processes")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 1c3586778c..3deeff165d 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3494,8 +3494,8 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 	uint16_t i;
 	enum rte_vect_max_simd rx_simd_width = i40e_get_max_simd_bitwidth();
 
-	/* The primary process selects the rx path for all processes. */
-	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+	/* If the device has started the function has already been selected. */
+	if (dev->data->dev_started)
 		goto out;
 
 	/* In order to allow Vector Rx there are a few configuration
-- 
2.43.0

