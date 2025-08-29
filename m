Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D381CA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 09:45:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EA5A40263;
	Fri, 29 Aug 2025 11:45:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 960134025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 11:45:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756460754; x=1787996754;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fEMz9hY/lTwsH+t9d9JV0ShOtpvs2hTBs/3VERk+39g=;
 b=WF3KljvXQ055Ls/C8RwoE+7bEyA3BPOz+Qk3lyuTatSopP3MxfKi7y0B
 5uIKBqJ6uqFf70aOTLEJRCHQJyG+giqYfAWcQjeX4mZAPXF9y7zFRBOx/
 qT/1OOZSGnZmKjhxWCcxG58Mh9ijyvMnGG43BUj9j8sOzuI6mMNGsPx7S
 u4XNDUikxFYN2Azw3pZd+VKqc6jeq3deVOzomRW/D8gxqILXwkiqd6B/X
 WO7tHg24aFpBSS6HPTeDekdXJsFqBWk4/0/TKOiVH+i4MOoSa3ElTyIeI
 HxxbsMExGBQK++97Vh+Ea/jcw/A3IHyiuxV4/tWkBa0D9aM0CdBxlRvUc Q==;
X-CSE-ConnectionGUID: N8co6GUhSSKKK/3OvbomnA==
X-CSE-MsgGUID: BGbESIdRRASGyALjK/0AOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="70113514"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="70113514"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 02:45:53 -0700
X-CSE-ConnectionGUID: bjTmBUzlQwSwObNtAR+IUA==
X-CSE-MsgGUID: OZUdIvDjQBallpc740OhDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170240649"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 29 Aug 2025 02:45:51 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2] net/ice: make link state configurable on device close
Date: Fri, 29 Aug 2025 09:45:23 +0000
Message-Id: <20250829094523.1582102-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828102305.1522036-1-ciara.loftus@intel.com>
References: <20250828102305.1522036-1-ciara.loftus@intel.com>
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

Introduce the device argument link_state_on_close for the ice driver.
When the device is stopped or closed, the link state will be configured
as follows for each of the three options:
1. down: bring (or keep) the link down
2. up: bring (or keep) the link up
3. initial: restore the link to the state it was in when the device
started.

Prior to this commit the default behaviour was to always restore the
link to its initial state. The new default behaiour is to always bring
the link down, which is in keeping with most other drivers.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
v2:
* Changed devarg name and made it tri-state instead of boolean
---
 doc/guides/nics/ice.rst            | 13 ++++++++++
 drivers/net/intel/ice/ice_ethdev.c | 41 ++++++++++++++++++++++++++++--
 drivers/net/intel/ice/ice_ethdev.h |  1 +
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/ice.rst b/doc/guides/nics/ice.rst
index 2c0f41c56c..3802db8120 100644
--- a/doc/guides/nics/ice.rst
+++ b/doc/guides/nics/ice.rst
@@ -322,6 +322,19 @@ Runtime Configuration
 
     -a af:00.0,pps_out='[pin:0]'
 
+- ``Link state on close`` (default ``down``)
+
+  The user can request that the link be set to up or down or restored to its
+  original state when the device is closed.
+
+    -a af:00.0,link_state_on_close=<state>
+
+  Supported values for the ``<state>`` parameter:
+
+  * ``down``: Leave the link in the down state.
+  * ``up``: Leave the link in the up state.
+  * ``initial``: Restore the link to the state it was in when the device started.
+
 - ``Low Rx latency`` (default ``0``)
 
   vRAN workloads require low latency DPDK interface for the front haul
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..a93b0fe202 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -41,6 +41,7 @@
 #define ICE_DDP_FILENAME_ARG      "ddp_pkg_file"
 #define ICE_DDP_LOAD_SCHED_ARG    "ddp_load_sched_topo"
 #define ICE_TM_LEVELS_ARG         "tm_sched_levels"
+#define ICE_LINK_STATE_ON_CLOSE   "link_state_on_close"
 
 #define ICE_CYCLECOUNTER_MASK  0xffffffffffffffffULL
 
@@ -57,6 +58,7 @@ static const char * const ice_valid_args[] = {
 	ICE_DDP_FILENAME_ARG,
 	ICE_DDP_LOAD_SCHED_ARG,
 	ICE_TM_LEVELS_ARG,
+	ICE_LINK_STATE_ON_CLOSE,
 	NULL
 };
 
@@ -95,6 +97,12 @@ static struct proto_xtr_ol_flag ice_proto_xtr_ol_flag_params[] = {
 		.param = { .name = "intel_pmd_dynflag_proto_xtr_ip_offset" }}
 };
 
+enum ice_link_state_on_close {
+	ICE_LINK_DOWN,
+	ICE_LINK_UP,
+	ICE_LINK_INITIAL,
+};
+
 #define ICE_OS_DEFAULT_PKG_NAME		"ICE OS Default Package"
 #define ICE_COMMS_PKG_NAME			"ICE COMMS Package"
 #define ICE_MAX_RES_DESC_NUM        1024
@@ -2116,6 +2124,29 @@ parse_tx_sched_levels(const char *key, const char *value, void *args)
 	return 0;
 }
 
+static int
+parse_link_state_on_close(const char *key, const char *value, void *args)
+{
+	int *state = args, ret = 0;
+
+	if (value == NULL || state == NULL)
+		return -EINVAL;
+
+	if (strcmp(value, "down") == 0) {
+		*state = ICE_LINK_DOWN;
+	} else if (strcmp(value, "up") == 0) {
+		*state = ICE_LINK_UP;
+	} else if (strcmp(value, "initial") == 0) {
+		*state = ICE_LINK_INITIAL;
+	} else {
+		ret = -EINVAL;
+		PMD_DRV_LOG(WARNING, "%s: Invalid value \"%s\", "
+				"should be \"down\" \"up\" or \"initial\"", key, value);
+	}
+
+	return ret;
+}
+
 static int
 lookup_pps_type(const char *pps_name)
 {
@@ -2368,6 +2399,9 @@ static int ice_parse_devargs(struct rte_eth_dev *dev)
 	if (ret)
 		goto bail;
 
+	ret = rte_kvargs_process(kvlist, ICE_LINK_STATE_ON_CLOSE,
+				 &parse_link_state_on_close, &ad->devargs.link_state_on_close);
+
 bail:
 	rte_kvargs_free(kvlist);
 	return ret;
@@ -2811,7 +2845,9 @@ ice_dev_stop(struct rte_eth_dev *dev)
 	/* disable all queue interrupts */
 	ice_vsi_disable_queues_intr(main_vsi);
 
-	if (pf->init_link_up)
+	if (pf->adapter->devargs.link_state_on_close == ICE_LINK_UP ||
+			(pf->adapter->devargs.link_state_on_close == ICE_LINK_INITIAL &&
+				pf->init_link_up))
 		ice_dev_set_link_up(dev);
 	else
 		ice_dev_set_link_down(dev);
@@ -7320,7 +7356,8 @@ RTE_PMD_REGISTER_PARAM_STRING(net_ice,
 			      ICE_DDP_FILENAME_ARG "=</path/to/file>"
 			      ICE_DDP_LOAD_SCHED_ARG "=<0|1>"
 			      ICE_TM_LEVELS_ARG "=<N>"
-			      ICE_RX_LOW_LATENCY_ARG "=<0|1>");
+			      ICE_RX_LOW_LATENCY_ARG "=<0|1>"
+			      ICE_LINK_STATE_ON_CLOSE "=<down|up|initial>");
 
 RTE_LOG_REGISTER_SUFFIX(ice_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(ice_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 8e5799f8b4..23014f4f72 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -597,6 +597,7 @@ struct ice_devargs {
 	uint8_t pps_out_ena;
 	uint8_t ddp_load_sched;
 	uint8_t tm_exposed_levels;
+	int link_state_on_close;
 	int xtr_field_offs;
 	uint8_t xtr_flag_offs[PROTO_XTR_MAX];
 	/* Name of the field. */
-- 
2.34.1

