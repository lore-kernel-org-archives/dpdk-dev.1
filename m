Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C4FCCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 11:02:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A75F9402D9;
	Fri,  3 Oct 2025 13:02:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 861D640262
 for <dev@dpdk.org>; Fri,  3 Oct 2025 13:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759489352; x=1791025352;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D0rVALuG9tdRm7InainNNRLIte/wamgg6qCCtpcI4lg=;
 b=hff5jNhtyzz33q6ohjiB0vUrMfBAOMNBe87o4L4QOdPlPnw7rbYableH
 UCQ7T8vfh7z91+KNZy8McqhTVKPQwHD4QdrCnsaJ5c2kSi1scoIYboqVn
 NChB3KlycQ4SXi7dJVtW8RjBqgQVqb+R+4En1oQqqmd509vEH10c0pSxj
 YehFAUYOeyab9gAOPlQ1lo9T21/vK58AmK5AAhx5FV0xxIXPja08KwoTP
 HIiM3Gdk9flWjQ1A/xIADbSmKY3Cr0aV17SlfN3PYohrEaUhVFjcvfJgp
 QxAYBAFfoUt1P1u3+6WMJ8cCrvaFQ31PB63M1PC0wAM0dMbqb33eF/Qa6 A==;
X-CSE-ConnectionGUID: ioWFKLQyT5eb+nwwO6QgAg==
X-CSE-MsgGUID: Y1079pZwQdOVLMW6rgga4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72873475"
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="72873475"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Oct 2025 04:02:17 -0700
X-CSE-ConnectionGUID: JYyp4llCQby/dc8qfbxiPw==
X-CSE-MsgGUID: 6ucPYOl1RVGHUAHIJ+TZng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,312,1751266800"; d="scan'208";a="179077634"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa007.jf.intel.com with ESMTP; 03 Oct 2025 04:02:16 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: stephen@networkplumber.org, thomas@monjalon.net,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v3 1/7] net/ice: don't report empty queue xstats
Date: Fri,  3 Oct 2025 12:01:55 +0100
Message-ID: <20251003110201.1541183-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251003110201.1541183-1-bruce.richardson@intel.com>
References: <20250923141207.10403-1-bruce.richardson@intel.com>
 <20251003110201.1541183-1-bruce.richardson@intel.com>
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

