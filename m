Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00210CA0EED
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 Aug 2025 10:23:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D19BE402DC;
	Thu, 28 Aug 2025 12:23:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 8B5E34025A
 for <dev@dpdk.org>; Thu, 28 Aug 2025 12:23:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756376598; x=1787912598;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=J0faHwqgvlF1K7loBpyDdSOy2YcmGAvZK1o7GcX7l4E=;
 b=RQAKwwqTypBmHIDrrXG2AysggLjY974sECy23UDkPa9TXz4PjYm1q0zL
 qWR1LzfMJmqeFcb7RcJXu3Ues17lvfVmAuQFdvccznFebOQXPe+jGGv+d
 GixBZd3k9mZQCMhXtQ0o/F9SSWxXXuxSVuaslP9LnSfZtc5CdQ46S3QF1
 Hx1yWDfsEwvSf0SZhe04MlzqBvaWR5cErcABONx08SE70YZSIrvJ5O8ST
 Ia0aJmHAps/sy7iXITNOpURVMUFfj7FFjCAwbxcIeFaPm1cpcK13FgQt8
 B7HpZPF1TshY4pqiq9+aMdD5K1DWZyXSQFNs3XnBJYrgk9FDRxmEzn+uZ g==;
X-CSE-ConnectionGUID: j2gOV9DjRuecGOfXZMkDdA==
X-CSE-MsgGUID: RYcrIlDZS7SvpCWJGo07XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="69348528"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="69348528"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 03:23:17 -0700
X-CSE-ConnectionGUID: DQDjYLr5SPKkY1kOFVRcLw==
X-CSE-MsgGUID: m3MjfTnCT6KlYo8SgezDhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="169322374"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 28 Aug 2025 03:23:16 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH] net/ice: make link state configurable on device stop
Date: Thu, 28 Aug 2025 10:23:05 +0000
Message-Id: <20250828102305.1522036-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

Introduce the boolean restore_link_state devarg for the ice driver. When
set, when the ice port is stopped, the physical link will be restored to
the state it was in when the device was started.

Prior to this patch the default behaviour was to always restore the link
to its original state. The new default behaiour is to always bring the
link down, which is in keeping with most other drivers.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/nics/ice.rst            | 12 ++++++++++++
 drivers/net/intel/ice/ice_ethdev.c | 10 ++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 2c0f41c56c..9007b79471 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -322,6 +322,18 @@ Runtime Configuration
 
     -a af:00.0,pps_out='[pin:0]'
 
+- ``Restore initial link state`` (default ``0``)
+
+  The user can request that the link be restored to its original state when
+  the device is stopped.
+
+    -a af:00.0,restore_link_state=1
+
+  The default behaviour is to bring the link down when the device is stopped,
+  however if restore_link_state is set and if the link state was up when the
+  device was started, then it will be restored to the up state when the
+  device is stopped.
+
 - ``Low Rx latency`` (default ``0``)
 
   vRAN workloads require low latency DPDK interface for the front haul
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..0c1dc9db1a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -41,6 +41,7 @@
 #define ICE_DDP_FILENAME_ARG      "ddp_pkg_file"
 #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
 #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
+#define ICE_RESTORE_LINK_STATE    "restore_link_state"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
 
@@ -57,6 +58,7 @@ static const char * const ice_valid_args[] = {
 	ICE_DDP_FILENAME_ARG,
 	ICE_DDP_LOAD_SCHED_ARG,
 	ICE_TM_LEVELS_ARG,
+	ICE_RESTORE_LINK_STATE,
 	NULL
 };
 
@@ -2368,6 +2370,9 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, ICE_RESTORE_LINK_STATE,
+				 &parse_bool, &ad->devargs.restore_link_state);
+
 bail:
 	rte_kvargs_free(kvlist);
 	return ret;
@@ -2811,7 +2816,7 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	/* disable all queue interrupts */
 	ice_vsi_disable_queues_intr(main_vsi);
 
-	if (pf->init_link_up)
+	if (pf->adapter->devargs.restore_link_state && pf->init_link_up)
 		ice_dev_set_link_up(dev);
 	else
 		ice_dev_set_link_down(dev);
@@ -7320,7 +7325,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_DDP_FILENAME_ARG "=</path/to/file>"
 			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
 			      ICE_TM_LEVELS_ARG "=<N>"
-			      ICE_RX_LOW_LATENCY_ARG "=<0|1>");
+			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
+			      ICE_RESTORE_LINK_STATE "=<0|1>");
 
 RTE_LOG_REGISTER_SUFFIX(ice_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(ice_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 8e5799f8b4..4605fee6c5 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -597,6 +597,7 @@ struct ice_devargs {
 	uint8_t pps_out_ena;
 	uint8_t ddp_load_sched;
 	uint8_t tm_exposed_levels;
+	uint8_t restore_link_state;
 	int xtr_field_offs;
 	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
 	/* Name of the field. */
-- 
2.34.1

