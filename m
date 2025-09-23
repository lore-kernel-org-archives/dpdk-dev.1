Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25A6CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:12:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66EC84067C;
	Tue, 23 Sep 2025 16:12:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id A618D40672
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:12:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758636738; x=1790172738;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D0rVALuG9tdRm7InainNNRLIte/wamgg6qCCtpcI4lg=;
 b=TKP6kypgkk4gT7PmBPUZ7trXYMXIEbl7HrbNyf/NBSQjLjmwMpmY7gXG
 dsri4FrwimyLQ7bBtCEnYvdEvBYrOVYmBUK+rEi6M7+kUlk7eiAyh4pNa
 iAQvTCursNx67fldnJMIRfYl9EBnRUJdj2+RMgYaUhExvy0HZqp+r5jYz
 aGXot+FE287dGtVSR6udx+eWfV8+kpEUYaoYxEPQ85Kr1Gr6jTlI5m3jN
 wdyPXEiMXCGmZZHnds+drNeCKJRjgwsCjGjANBiCvDznPpcHH6nh6q6T4
 lK0WpFvuri0fq2AJtTviBsCoSvFCWd1OAP1Lsa48QgIjaX1dloQ/5VTzM Q==;
X-CSE-ConnectionGUID: yohH+EkUSf21w3l2kGsbLw==
X-CSE-MsgGUID: sA1HdDARQOCHigHGsdnM1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64554236"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="64554236"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:12:17 -0700
X-CSE-ConnectionGUID: xPc+MVm+TC2rPgX9pooRnQ==
X-CSE-MsgGUID: 6btjn0moSqChCXyO3fWqXg==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2025 07:12:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC PATCH 1/6] net/ice: don't report empty queue xstats
Date: Tue, 23 Sep 2025 15:12:01 +0100
Message-ID: <20250923141207.10403-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250923141207.10403-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
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

The ice driver does not fill in the queue statistics in the
rte_eth_stats structure, meaning that the per-queue xstats reported are
meaningless, and always zero. Don't set the device flag
"RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS" so these zero-stats are not
automatically created by the ethdev layer.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index a9a49cd924..31f1419897 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2580,8 +2580,6 @@ ice_dev_init(struct rte_eth_dev *dev)
 		return 0;
 	}
 
-	dev->data->dev_flags |= RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS;
-
 	ice_set_default_ptype_table(dev);
 	pci_dev = RTE_DEV_TO_PCI(dev->device);
 	intr_handle = pci_dev->intr_handle;
-- 
2.48.1

