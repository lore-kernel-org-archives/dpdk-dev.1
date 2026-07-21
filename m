Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4763C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 13:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D28114066C;
	Tue, 21 Jul 2026 15:08:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 009AE40294
 for <dev@dpdk.org>; Tue, 21 Jul 2026 15:08:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784639311; x=1816175311;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aytpPoALpQBItrmaDp/H0wyYmGZVioyuooivN4T8jIM=;
 b=dMz2keFeHlG6b4T9pTAuLBJgN4FUrYo6yFRMVBJvSQjEC/f5/ctwzwQh
 ErdXtGs/XoM/xTbJAc3AjgfgbaSIFbvMcUMBn8fsgfCexmGCL5b8dsT0Q
 sWyrUfzco6QZeNrEFl97FlwCnrcUJL6cBEc9WhanEWCCkGVFDLcc2gfgJ
 ercm81VPdgawaLBF1BkV4zeLlQ/xt28CTkieSeZplA+U6yJrZ1xVKt3XI
 njOZ84AfEsz1dVzZ6QMF0qrqPBEIGTGxrRvIQpoNXbJRitMKOL1ML1N7F
 +rxpXJ22EHr8rcekmFOduh4dJJqhGHr1tB28cegD0B9K2n3Fx9zVTkvwo A==;
X-CSE-ConnectionGUID: abGNo58iSgSs/c7hsteOVw==
X-CSE-MsgGUID: sLpXntLMQp2Ses/OxqYuOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="108027789"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="108027789"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2026 06:08:30 -0700
X-CSE-ConnectionGUID: 2c5hzK00Tdm6LkmiJTGAxA==
X-CSE-MsgGUID: 0hB/IDBZSwOxdCIL8faBFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; d="scan'208";a="254360082"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by fmviesa007.fm.intel.com with ESMTP; 21 Jul 2026 06:08:29 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC 1/2] net/iavf: remove auto reconfig devarg
Date: Tue, 21 Jul 2026 13:08:13 +0000
Message-ID: <20260721130814.2950332-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721130814.2950332-1-ciara.loftus@intel.com>
References: <20260721130814.2950332-1-ciara.loftus@intel.com>
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

The `auto_reconfig` devarg controlled whether the promiscuous and
all-multicast states were restored after a VF reset. Remove it and always
restore those states after a reset, for two reasons.

First, a VF almost always wants those states restored after a reset. For
the rare cases where a different post-reset state is wanted, a post-reset
callback can be registered and used to adjust the state once the
reset completes.

Second, the devarg was inconsistent: it only affected promiscuous and
all-multicast, while MAC addresses, the multicast address list, VLAN
configuration and RSS were restored regardless of its value. The "reconfig"
name was also ambiguous, potentially suggesting it governed all settings
when it did not.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/intel_vf.rst           |  5 -----
 doc/guides/rel_notes/release_26_07.rst |  5 +++++
 drivers/net/intel/iavf/iavf.h          |  1 -
 drivers/net/intel/iavf/iavf_ethdev.c   | 28 ++++++--------------------
 4 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/doc/guides/nics/intel_vf.rst b/doc/guides/nics/intel_vf.rst
index 8f8ce32cac..d287a78672 100644
--- a/doc/guides/nics/intel_vf.rst
+++ b/doc/guides/nics/intel_vf.rst
@@ -106,11 +106,6 @@ IAVF PMD parameters
     To disable this functionality,
     set the ``auto_reset`` devarg to zero: ``-a 18:01.0,auto_reset=0``
 
-``auto_reconfig``
-    Restore settings (unicast and multicast promiscuous states) on the VF after a reset event.
-    Enabled by default.
-    To disable it: ``-a 18:01.0,auto_reconfig=0``
-
 ``no-poll-on-link-down``
     Stop polling Rx/Tx hardware queue when link is down.
     This is enabled by default because it is required when ``auto_reset`` is enabled
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 6badd6d91b..a6ff949860 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -301,6 +301,11 @@ Removed Items
   The ZUC and SNOW 3G crypto drivers are using APIs
   that are now deprecated in the Intel IPsec Multi-Buffer library.
 
+* net/iavf: Removed the ``auto_reconfig`` devarg.
+
+  The restoration of the promiscuous and all-multicast settings after a VF reset is
+  now unconditional.
+
 
 API Changes
 -----------
diff --git a/drivers/net/intel/iavf/iavf.h b/drivers/net/intel/iavf/iavf.h
index 293adaf6c9..143ab3c1c0 100644
--- a/drivers/net/intel/iavf/iavf.h
+++ b/drivers/net/intel/iavf/iavf.h
@@ -323,7 +323,6 @@ struct iavf_devargs {
 	uint16_t quanta_size;
 	uint32_t watchdog_period;
 	int auto_reset;
-	int auto_reconfig;
 	int no_poll_on_link_down;
 	uint64_t mbuf_check;
 	int enable_ptype_lldp;
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index d601ec3b6a..829573983a 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -42,7 +42,6 @@
 #define IAVF_QUANTA_SIZE_ARG       "quanta_size"
 #define IAVF_RESET_WATCHDOG_ARG    "watchdog_period"
 #define IAVF_ENABLE_AUTO_RESET_ARG "auto_reset"
-#define IAVF_ENABLE_AUTO_RECONFIG_ARG "auto_reconfig"
 #define IAVF_NO_POLL_ON_LINK_DOWN_ARG "no-poll-on-link-down"
 #define IAVF_MBUF_CHECK_ARG       "mbuf_check"
 #define IAVF_ENABLE_PTYPE_LLDP_ARG "enable_ptype_lldp"
@@ -55,7 +54,6 @@ static const char * const iavf_valid_args[] = {
 	IAVF_QUANTA_SIZE_ARG,
 	IAVF_RESET_WATCHDOG_ARG,
 	IAVF_ENABLE_AUTO_RESET_ARG,
-	IAVF_ENABLE_AUTO_RECONFIG_ARG,
 	IAVF_NO_POLL_ON_LINK_DOWN_ARG,
 	IAVF_MBUF_CHECK_ARG,
 	IAVF_ENABLE_PTYPE_LLDP_ARG,
@@ -2468,7 +2466,6 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 
 	ad->devargs.auto_reset = 1;
 	ad->devargs.no_poll_on_link_down = 1;
-	ad->devargs.auto_reconfig = 1;
 
 	if (!devargs)
 		return 0;
@@ -2531,11 +2528,6 @@ static int iavf_parse_devargs(struct rte_eth_dev *dev)
 		ad->devargs.no_poll_on_link_down = 1;
 	}
 
-	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_AUTO_RECONFIG_ARG,
-				 &parse_bool, &ad->devargs.auto_reconfig);
-	if (ret)
-		goto bail;
-
 	ret = rte_kvargs_process(kvlist, IAVF_ENABLE_PTYPE_LLDP_ARG,
 				 &parse_bool, &ad->devargs.enable_ptype_lldp);
 	if (ret)
@@ -3358,7 +3350,7 @@ iavf_is_reset_detected(struct iavf_adapter *adapter)
 static int
 iavf_post_reset_reconfig(struct rte_eth_dev *dev)
 {
-	int ret, status = 0;
+	int ret = 0;
 	bool allmulti = false, allunicast = false;
 	struct iavf_adapter *adapter = IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 
@@ -3377,10 +3369,9 @@ iavf_post_reset_reconfig(struct rte_eth_dev *dev)
 			PMD_DRV_LOG(DEBUG, "Restored unicast promiscuous mode (%s) "
 						"and multicast promiscuous mode (%s)",
 						allunicast ? "on" : "off", allmulti ? "on" : "off");
-		status |= ret;
 	}
 
-	return status;
+	return ret;
 }
 
 /*
@@ -3435,17 +3426,10 @@ iavf_handle_hw_reset(struct rte_eth_dev *dev, bool vf_initiated_reset)
 	}
 
 	/* Restore settings after the reset */
-	if (adapter->devargs.auto_reconfig) {
-		ret = iavf_post_reset_reconfig(dev);
-		if (ret) {
-			PMD_DRV_LOG(ERR, "Failed to restore VF settings after reset");
-			goto error;
-		}
-	} else {
-		dev->data->promiscuous = 0;
-		dev->data->all_multicast = 0;
-		vf->promisc_unicast_enabled = false;
-		vf->promisc_multicast_enabled = false;
+	ret = iavf_post_reset_reconfig(dev);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to restore VF settings after reset");
+		goto error;
 	}
 
 	goto exit;
-- 
2.43.0

