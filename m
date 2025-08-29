Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5B3CA0FFE
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 14:02:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF1934065F;
	Fri, 29 Aug 2025 16:02:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 5953F4025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 16:02:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756476163; x=1788012163;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A6sun0IJcYQfpxo8Q8d2R7a4Vb27WkVTdhWT5hc3ASI=;
 b=LovE8+rmcyZ3KTpRFdYrv1guieXM5O42HlH3Zv6K4N9a9dgBkm9ERF5P
 tL01++5EawJ68CHFQZIhuYhqDfzAGLXq3JrNdQmpFipkeQ2+oQDKKi2aJ
 GW4kTDBlbEchzzCVNYn4KNYBPZWcMPMIXwLgYzYxh+Gz6WdW+t0//TZ6l
 dZtuz0OlR5fcIZ4Ei+2/AaaFRXMYJxwnGIgdmxRo81S2hYaIUZ4Ct0cAU
 IUv5v36dJWMwqN6fKbGAt89bC4jkr74XYG2DNSGjdhqllWtDQm05mgBhe
 i3mcq1B4BJvigQ5humCBEBthqDMcAYd7mvQktMR2G1YWiGcdwMsr9sr4n w==;
X-CSE-ConnectionGUID: nZg5AerrSl68H+07oo0rwA==
X-CSE-MsgGUID: 4tFL6WG1TvaqSMG9dL4Akw==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="84166918"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="84166918"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 07:02:41 -0700
X-CSE-ConnectionGUID: bO4GJZBgRQO9H84e2rv9jw==
X-CSE-MsgGUID: iGiwlxEaRDyq6BGzY1Betg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="170295671"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2025 07:02:40 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 1/3] ethdev: add set link state on close API
Date: Fri, 29 Aug 2025 14:02:22 +0000
Message-Id: <20250829140224.1748255-2-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829140224.1748255-1-ciara.loftus@intel.com>
References: <20250829140224.1748255-1-ciara.loftus@intel.com>
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

Allow the user to configure the state a link should be in after
the device has been stopped/closed. Make this configurable
through the new experimental rte_eth_dev_set_link_state_on_close
API. Three states are allowed:
1. down: bring (or keep) the link down
2. up: bring (or keep) the link up
3. initial: restore the link to the state it was in when the device was
started.

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 doc/guides/rel_notes/release_25_11.rst |  4 ++++
 lib/ethdev/ethdev_driver.h             | 18 +++++++++++++++
 lib/ethdev/ethdev_trace.h              |  8 +++++++
 lib/ethdev/ethdev_trace_points.c       |  3 +++
 lib/ethdev/rte_ethdev.c                | 19 +++++++++++++++
 lib/ethdev/rte_ethdev.h                | 32 ++++++++++++++++++++++++++
 6 files changed, 84 insertions(+)

diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 32d61691d2..8f9ab31687 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -55,6 +55,10 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+   * ** Added link state on close ethdev API
+
+     * Added a new API to the ethdev library to allow the configuration of link state
+       on device close. It can be configured as down, up or restored to initial state.
 
 Removed Items
 -------------
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 2b4d2ae9c3..f82c67ce36 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -1199,6 +1199,21 @@ typedef int (*eth_ip_reassembly_conf_set_t)(struct rte_eth_dev *dev,
 typedef const uint32_t *(*eth_buffer_split_supported_hdr_ptypes_get_t)(struct rte_eth_dev *dev,
 								       size_t *no_of_elements);
 
+/**
+ * @internal
+ * Set the state the link should be configured to be on device closure.
+ *
+ * @param dev
+ *   Ethdev handle of port.
+ * @param state
+ *   Either down, up or initial.
+ *
+ * @return
+ *   Negative errno value on error, zero otherwise.
+ */
+typedef int (*eth_link_state_on_close_set_t)(struct rte_eth_dev *dev,
+						enum rte_eth_link_state_on_close state);
+
 /**
  * @internal
  * Dump private info from device to a file.
@@ -1599,6 +1614,9 @@ struct eth_dev_ops {
 	/** Get supported header ptypes to split */
 	eth_buffer_split_supported_hdr_ptypes_get_t buffer_split_supported_hdr_ptypes_get;
 
+	/** Set link state on close */
+	eth_link_state_on_close_set_t link_state_on_close_set;
+
 	/** Dump private info from device */
 	eth_dev_priv_dump_t eth_dev_priv_dump;
 
diff --git a/lib/ethdev/ethdev_trace.h b/lib/ethdev/ethdev_trace.h
index 482befc209..6554d176b8 100644
--- a/lib/ethdev/ethdev_trace.h
+++ b/lib/ethdev/ethdev_trace.h
@@ -1298,6 +1298,14 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_u32(ptypes);
 )
 
+RTE_TRACE_POINT(
+	rte_eth_trace_link_state_on_close_set,
+	RTE_TRACE_POINT_ARGS(uint16_t port_id, enum rte_eth_link_state_on_close state, int ret),
+	rte_trace_point_emit_u16(port_id);
+	rte_trace_point_emit_int(state);
+	rte_trace_point_emit_int(ret);
+)
+
 RTE_TRACE_POINT(
 	rte_eth_trace_cman_info_get,
 	RTE_TRACE_POINT_ARGS(uint16_t port_id,
diff --git a/lib/ethdev/ethdev_trace_points.c b/lib/ethdev/ethdev_trace_points.c
index 071c508327..e515efacc7 100644
--- a/lib/ethdev/ethdev_trace_points.c
+++ b/lib/ethdev/ethdev_trace_points.c
@@ -482,6 +482,9 @@ RTE_TRACE_POINT_REGISTER(rte_eth_trace_ip_reassembly_conf_set,
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_buffer_split_get_supported_hdr_ptypes,
 	lib.ethdev.buffer_split_get_supported_hdr_ptypes)
 
+RTE_TRACE_POINT_REGISTER(rte_eth_trace_link_state_on_close_set,
+	lib.ethdev.link_state_on_close_set)
+
 RTE_TRACE_POINT_REGISTER(rte_eth_trace_cman_info_get,
 	lib.ethdev.cman_info_get)
 
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..4847a89440 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -7344,6 +7344,25 @@ rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes
 	return j;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_set_link_state_on_close, 25.11)
+int
+rte_eth_dev_set_link_state_on_close(uint16_t port_id, enum rte_eth_link_state_on_close state)
+{
+	struct rte_eth_dev *dev;
+	int ret;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (dev->dev_ops->link_state_on_close_set == NULL)
+		return -ENOTSUP;
+	ret = eth_err(port_id, dev->dev_ops->link_state_on_close_set(dev, state));
+
+	rte_eth_trace_link_state_on_close_set(port_id, state, ret);
+
+	return ret;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_count_aggr_ports, 23.03)
 int rte_eth_dev_count_aggr_ports(uint16_t port_id)
 {
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index f9fb6ae549..3312f1e95c 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -514,6 +514,12 @@ struct rte_eth_rss_conf {
 	enum rte_eth_hash_function algorithm;	/**< Hash algorithm. */
 };
 
+enum rte_eth_link_state_on_close {
+	RTE_ETH_LINK_STATE_ON_CLOSE_DOWN = 1,
+	RTE_ETH_LINK_STATE_ON_CLOSE_UP = 2,
+	RTE_ETH_LINK_STATE_ON_CLOSE_INITIAL = 3
+};
+
 /*
  * A packet can be identified by hardware as different flow types. Different
  * NIC hardware may support different flow types.
@@ -7065,6 +7071,32 @@ __rte_experimental
 int rte_eth_buffer_split_get_supported_hdr_ptypes(uint16_t port_id, uint32_t *ptypes, int num)
 	__rte_warn_unused_result;
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice
+ *
+ * Configure the state of the physical link when the device is closed.
+ *
+ * This function allows the configuration of the physical link state
+ * when the device is closed. The link can be set to either down, up or
+ * remain configured as the device default, depending on the value of the
+ * 'state' parameter.
+ *
+ * @param port_id
+ *   The port identifier of the device.
+ * @param state
+ *  - RTE_ETH_LINK_STATE_ON_CLOSE_DOWN - Bring (or keep) the link down.
+ *  - RTE_ETH_LINK_STATE_ON_CLOSE_UP   - Bring (or keep) the link up.
+ *  - RTE_ETH_LINK_STATE_ON_CLOSE_INITIAL - Restore the link to the state it
+ *    was in when the device was started.
+ * @return
+ *   - (0) on success
+ *   - (-ENOTSUP) if the device does not support this function.
+ */
+__rte_experimental
+int rte_eth_dev_set_link_state_on_close(uint16_t port_id, enum rte_eth_link_state_on_close state)
+	__rte_warn_unused_result;
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
-- 
2.34.1

