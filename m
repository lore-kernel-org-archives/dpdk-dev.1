Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFC7C43458
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:26:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 800F840A87;
	Thu,  9 Jul 2026 13:26:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 65BB5406B7;
 Thu,  9 Jul 2026 13:26:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783596387; x=1815132387;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lnTsTehGq3wSpvMgNwAj9pjQBf+3osmlVGKrADlC5cU=;
 b=hXR1lx+CKFmphR1nElfrAlUnEVuIkW2EX4eHN8S4OhLj+sJ/zr2+6ltG
 5OrYht6vU9cTP5eKfkd8DJQA9qilVaaxEAR0eoqRAI0xw3bPH+7vzYjtC
 7S9ryYTzY93Y0fQImoYc6abzCthvDSVre55zNHC5J59Iba1PscZzXpHtV
 nW5IUltx4jxOb7aLHu4g3MpGBJXEqdCD6ng+ydNYmJu7CaQT2Y9NhaIHq
 wnFGe9tY4Z4P9W4mvOJGRwUk7rJgvZcvKEbfc/IqBhEIxw7YMv2pPkXXj
 2Vf1GHV7Ma/PqmXUiyx4DRZpnqv4lt2wUAF3HuojDjq0Mx5h/KVKGpv2u A==;
X-CSE-ConnectionGUID: apfX+WsLSMKzmC6wZsNY9g==
X-CSE-MsgGUID: ghxWlr+2S/OjSWtXBCc9rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="94879772"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="94879772"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2026 04:26:25 -0700
X-CSE-ConnectionGUID: eBHn9fNJQwWMBLBt8uyBug==
X-CSE-MsgGUID: i7SF0I36RNG5XxuFWjJw5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="259461760"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa005.fm.intel.com with ESMTP; 09 Jul 2026 04:26:25 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, Ciara Loftus <ciara.loftus@intel.com>,
 stable@dpdk.org
Subject: [PATCH v2 3/3] net/ice: fix adapter stopped on device start error
Date: Thu,  9 Jul 2026 11:25:56 +0000
Message-ID: <20260709112556.1765262-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260709112556.1765262-1-ciara.loftus@intel.com>
References: <20260630141627.1035420-1-ciara.loftus@intel.com>
 <20260709112556.1765262-1-ciara.loftus@intel.com>
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

Currently, `adapter_stopped` is cleared during device startup but is not
restored to true if startup fails partway through. Reset `adapter_stopped`
to true on the device startup error path to accurately reflect device state
after a failed start.

Fixes: 437dbd2fd428 ("net/ice: support 1PPS")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 8db5168b88..76b8ff0a72 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -4582,6 +4582,8 @@ ice_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < nb_txq; i++)
 		ice_tx_queue_stop(dev, i);
 
+	pf->adapter_stopped = true;
+
 	return -EIO;
 }
 
-- 
2.43.0

