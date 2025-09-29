Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9FCCAC5B9
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 15:00:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63320406B4;
	Mon, 29 Sep 2025 17:00:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id D6CCF40289
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759158018; x=1790694018;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D0rVALuG9tdRm7InainNNRLIte/wamgg6qCCtpcI4lg=;
 b=LXRuL02vL/uqsbb1nXK25fk3xwc80+WgSRVtpWwoLoKffBS7/rEVZaHn
 qbxN+yhNIdZ/o7GgdVVRN+pg/+KNCkelMw97gG/VYoh7iiugWhD82VBhv
 Fz6+t6Qv/50Th7MhFjkEhWFPFlW0Pk6DnP4NqOqoD6dEUgu5Uy+P3gQY2
 htTmp9LNk148i1gJRDGC6yfDsyFaw3vImIDy/M1YmosgJQc2iYXbhBySh
 m5keDBd+eYvOV2DoMkTK4DZ8DBnQ3Ts3Tqnj6HzeUOlcnoj8H7Jl/08qr
 VHd9K50z5UG8f71f0ybB+NqPl5mXWdiRkmrwqNyjupjF2rWLwBDtqT+HK Q==;
X-CSE-ConnectionGUID: NnIWUgFWQVOMiU8OH+TyUg==
X-CSE-MsgGUID: ZF54JlVKQvOJLQRqj2BtUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84017107"
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="84017107"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2025 08:00:16 -0700
X-CSE-ConnectionGUID: HjxtS1/NRU+hiWXh7GUskg==
X-CSE-MsgGUID: HNFuk41jQeml6mmU4fOT2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,301,1751266800"; d="scan'208";a="178637990"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa008.fm.intel.com with ESMTP; 29 Sep 2025 08:00:15 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/6] net/ice: don't report empty queue xstats
Date: Mon, 29 Sep 2025 16:00:04 +0100
Message-ID: <20250929150009.1542208-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250929150009.1542208-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20250929150009.1542208-1-bruce.richardson@intel.com>
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

