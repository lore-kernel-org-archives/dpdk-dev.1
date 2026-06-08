Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B970CD8CAA
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 14:55:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D1EE040676;
	Mon,  8 Jun 2026 16:55:37 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id CDED640265;
 Mon,  8 Jun 2026 16:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780930534; x=1812466534;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VgX2CQpdmxwkTz4G9QT54ALEuq35IO+GPDighAQdadA=;
 b=Ugp9S6zqUK+6rZknKoejJ5xtEt7YvNZDrV/t5IH06/siNsBU/YwrGaSK
 rUpI2IqhD+NJrBfH4y8kgSiY7jyBNKAV5vieXmKZ7NyobN+e6zErZCG7x
 vGPz9gZ1CDhK7bbEigJNzRIwWAVd2rX2T6yzePICeNaR7rGEVyjzQ9A7L
 Jh4dTLGHDNTBIYGlLDee1KdeuYdjP91qjiroBQvoq963RKIWU8z2zQe6l
 wAS06XVlxKUF5Js6d6hE9Ac0+oAbT288toF2aucmnDQ4514cEHZV4M63q
 UiqOEuV12sBIX1M9gt1ulQEXhVb85S/CXVZbQx2/7vIOIB8WWg+hwOy2Z g==;
X-CSE-ConnectionGUID: I7SwSO7ERKCCxrcUkV+a1w==
X-CSE-MsgGUID: BpA5WphRTxWA0N+7sNU3vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93055943"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="93055943"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 07:55:33 -0700
X-CSE-ConnectionGUID: tmnpo0HlQGeCk2TxMHq4kw==
X-CSE-MsgGUID: kypBgUbOTaSw1DMv3vln2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="247436468"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa004.fm.intel.com with ESMTP; 08 Jun 2026 07:55:32 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH 3/3] net/iavf: fix event handler refcount leak on HW reset
Date: Mon,  8 Jun 2026 14:55:18 +0000
Message-ID: <20260608145518.1705524-4-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608145518.1705524-1-ciara.loftus@intel.com>
References: <20260608145518.1705524-1-ciara.loftus@intel.com>
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

Currently, when handling a hardware reset, the uninit path skips
releasing the event handler reference while in_reset_recovery is set,
to prevent premature teardown of the event handler thread. However, the
subsequent re-init call unconditionally increments the reference count,
inflating ndev on every reset cycle. On the final device removal, the
count never reaches zero and the event handler thread is never joined.

Fix it by also skipping the event handler reference acquisition during
reset recovery, matching the symmetric skip in the uninit path so the
count stays stable across each reset cycle.

Fixes: 3e6a5d2d310a ("net/iavf: add devargs to enable VF auto-reset")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index a38132e80e..ec1ad02826 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3031,7 +3031,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	adapter->tpid = RTE_ETHER_TYPE_VLAN; /* VLAN TPID set to 0x8100 by default */
 	rte_spinlock_init(&adapter->phc_sync_lock);
 
-	if (iavf_dev_event_handler_init())
+	if (!vf->in_reset_recovery && iavf_dev_event_handler_init())
 		goto init_vf_err;
 
 	if (iavf_init_vf(eth_dev) != 0) {
-- 
2.43.0

