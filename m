Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FC7606A334
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gnqd1Kej
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 09DCF42E02;
	Fri,  6 Nov 2026 10:40:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 80B1342D83;
 Fri,  6 Nov 2026 10:40:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793958029; x=1825494029;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BCXRbaZJSJPJZtn6n22lonONbLdHkFQ5MOeLyzPUnfk=;
 b=gnqd1KejyE6wRi90UKm2ylNKvm4fOXGTmCpFQWU4Bmio6rq6ol6O+Qnw
 MOo1a0OaDjOw6kWrGPKnOgWcYAgaSYnao4vXYTBKd6eACDk6p1qtHRI8k
 18UBc4Ex66jxfkGPUbFZh0cLBJ9JTA+KCHvuithxNfk3se8bieADmYZrY
 r8X7HZs7NvwQMprzNAM8lp337SmmK29VdXBzUyJOURz0r5G3a+PZhvdb9
 Fsrf5OLZdQHNNexJUs04n5gX0MHXOeVDUHsnbFXOWTktP1xTQLahaCndk
 li/ArnE+ZlYCdqhBj+5fRooeNDLbLnmayhYISFMV7R7pUvE2yNRIrj0Cq w==;
X-CSE-ConnectionGUID: t4oW5v9VSymdYc5kkzgMrw==
X-CSE-MsgGUID: eaRe4guXT+GM3MNBHfnrNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2808516"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2808516"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 01:40:28 -0800
X-CSE-ConnectionGUID: YuldV+HDQNSxde3FX9vozQ==
X-CSE-MsgGUID: N2kL1UvhQcaK9kmjOjyj0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7287110"
Received: from silpixa00401177.ir.intel.com (HELO vm-icx177..)
 ([10.20.224.214])
 by orviesa002.jf.intel.com with ESMTP; 06 Nov 2026 01:40:27 -0800
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>,
	stable@dpdk.org
Subject: [PATCH v4 4/4] net/iavf: fix watchdog enable racing disable
Date: Fri,  6 Nov 2026 09:40:12 +0000
Message-ID: <20261106094014.28784-5-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106094014.28784-1-ciara.loftus@intel.com>
References: <20261105123237.12279-1-ciara.loftus@intel.com>
 <20261106094014.28784-1-ciara.loftus@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

iavf_dev_watchdog_enable() runs on the interrupt thread from the link
change and reset impending handlers, while iavf_dev_watchdog_disable()
runs on a control thread from dev_stop and dev_close. Disable clears
`watchdog_enabled` before cancelling the alarm. An enable landing in
between sets the flag again and arms a new alarm, which the cancel then
removes. The flag is left set with no alarm armed, so every later enable
is a no-op and the watchdog is dead until the port is re-probed.

Serialise enable and disable with a spinlock held across the flag
update and the alarm set or cancel.

Fixes: 4c9b1d2ff616 ("net/iavf: refactor watchdog")
Cc: stable@dpdk.org

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/iavf/iavf.h        |  1 +
 drivers/net/intel/iavf/iavf_ethdev.c | 37 +++++++++++++++++-----------
 2 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 04c2900afe..0c98ae28e1 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -247,6 +247,7 @@ struct iavf_info {
 
 	/** iAVF watchdog enable */
 	bool watchdog_enabled;
+	rte_spinlock_t watchdog_lock;
 
 	/* Event from pf */
 	bool dev_closed;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 83470a636d..10069feae2 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -374,16 +374,19 @@ iavf_dev_watchdog_enable(struct iavf_adapter *adapter)
 {
 	if (!adapter->devargs.watchdog_period) {
 		PMD_DRV_LOG(INFO, "Device watchdog is disabled");
-	} else {
-		if (!adapter->vf.watchdog_enabled) {
-			PMD_DRV_LOG(INFO, "Enabling device watchdog, period is %dμs",
-						adapter->devargs.watchdog_period);
-			adapter->vf.watchdog_enabled = true;
-			if (rte_eal_alarm_set(adapter->devargs.watchdog_period,
-						&iavf_dev_watchdog, (void *)adapter))
-				PMD_DRV_LOG(ERR, "Failed to enable device watchdog");
-		}
+		return;
+	}
+
+	rte_spinlock_lock(&adapter->vf.watchdog_lock);
+	if (!adapter->vf.watchdog_enabled) {
+		PMD_DRV_LOG(INFO, "Enabling device watchdog, period is %dμs",
+					adapter->devargs.watchdog_period);
+		adapter->vf.watchdog_enabled = true;
+		if (rte_eal_alarm_set(adapter->devargs.watchdog_period,
+					&iavf_dev_watchdog, (void *)adapter))
+			PMD_DRV_LOG(ERR, "Failed to enable device watchdog");
 	}
+	rte_spinlock_unlock(&adapter->vf.watchdog_lock);
 }
 
 void
@@ -391,13 +394,16 @@ iavf_dev_watchdog_disable(struct iavf_adapter *adapter)
 {
 	if (!adapter->devargs.watchdog_period) {
 		PMD_DRV_LOG(INFO, "Device watchdog is not enabled");
-	} else {
-		if (adapter->vf.watchdog_enabled) {
-			PMD_DRV_LOG(INFO, "Disabling device watchdog");
-			adapter->vf.watchdog_enabled = false;
-			rte_eal_alarm_cancel(&iavf_dev_watchdog, (void *)adapter);
-		}
+		return;
+	}
+
+	rte_spinlock_lock(&adapter->vf.watchdog_lock);
+	if (adapter->vf.watchdog_enabled) {
+		PMD_DRV_LOG(INFO, "Disabling device watchdog");
+		adapter->vf.watchdog_enabled = false;
+		rte_eal_alarm_cancel(&iavf_dev_watchdog, (void *)adapter);
 	}
+	rte_spinlock_unlock(&adapter->vf.watchdog_lock);
 }
 
 static int
@@ -3077,6 +3083,7 @@ iavf_dev_init(struct rte_eth_dev *eth_dev)
 	adapter->mac_primary_set = false;
 	adapter->tpid = RTE_ETHER_TYPE_VLAN; /* VLAN TPID set to 0x8100 by default */
 	rte_spinlock_init(&adapter->phc_sync_lock);
+	rte_spinlock_init(&vf->watchdog_lock);
 
 	if (!rte_atomic_load_explicit(&vf->in_reset_recovery, rte_memory_order_relaxed) &&
 	    iavf_dev_event_handler_init())
-- 
2.43.0

