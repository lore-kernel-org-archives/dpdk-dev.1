Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B8FC55184
	for <dpdk-dev@archiver.kernel.org>; Mon,  3 Aug 2026 09:31:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE8B640272;
	Mon,  3 Aug 2026 11:31:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id D07DF40269
 for <dev@dpdk.org>; Mon,  3 Aug 2026 11:31:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785749471; x=1817285471;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UPYnwnGzxftHwyIMDAVuL6UNCdUL24P8iIQx+zgQro4=;
 b=UD/8br1InGTPk/13Q9W80iFlnUWHBjq8oI+KjoOXuv0lLOrTnoC598PD
 Pcy1BthYijgzUmHM1MI6Umk8OdY3nAmxcqvaFXeDQYzSIP/qrMRurKmxo
 p6KXCrOToBzRLjaYBx5BCGzzqCEmX6HgraeMxqtxY3SZapkqpxvxZ51Ck
 r0qKqoMGjycuDzs0/sfENltj6vHzvFelaxWVi903OqyPaBGof00qBM5bZ
 eQzIHvS+iB+VkZVdwWdG/PRTI2fk8XFtMwlsT8u0r5OoBNqOIT9kn1mUJ
 BVObkEb1vmBDTGVeeRTa9SgZhPLK5Z7xj67Wbs8rYf7ZYV8t78w2GDyzE Q==;
X-CSE-ConnectionGUID: DSThOAWXRyK71yY+ijKJ4g==
X-CSE-MsgGUID: Qqjs4boaQv6+TFEvaBvTGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="86141220"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; d="scan'208";a="86141220"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Aug 2026 02:31:10 -0700
X-CSE-ConnectionGUID: /+RYpDk8QUCjrK/8lCH2Vw==
X-CSE-MsgGUID: 0+7J4XInTQCZ+7mPx5yHVA==
X-ExtLoop1: 1
Received: from pae-14.iind.intel.com ([10.190.203.153])
 by fmviesa003.fm.intel.com with ESMTP; 03 Aug 2026 02:31:08 -0700
From: Anurag Mandal <anurag.mandal@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, praveen.shetty@intel.com,
 Anurag Mandal <anurag.mandal@intel.com>
Subject: [PATCH v2] net/cpfl: add timesync support
Date: Mon,  3 Aug 2026 09:30:27 +0000
Message-Id: <20260803093027.870965-1-anurag.mandal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728102008.860157-1-anurag.mandal@intel.com>
References: <20260728102008.860157-1-anurag.mandal@intel.com>
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

The cpfl PMD advertises RTE_ETH_RX_OFFLOAD_TIMESTAMP, so received
packets carry a 32-bit hardware timestamp that the common idpf Rx
path extends to 64-bit nanoseconds using the device PTP clock (PHC).
However, it never initialised the PHC, so the timestamp conversion
had no reference time.
Applications had no way to enable timestamping or to read the
current device clock to correlate the mbuf timestamps.

This patch adds PTP support by reusing the idpf common PTP helpers:

- timesync_enable: allocate and initialise the adapter PTP state,
  query the PTP capabilities, program the base increment value
  and set the device clock to the current system time.
  The PTP state is shared by all vports of an adapter, so it
  is initialised only once.

- timesync_read_time: return the current device clock as a timespec.

- timesync_disable: release the PTP state.

Once timesync is enabled, the common Rx path resolves the cached
PHC time, so the mbuf Rx timestamp dynfield reports valid
nanosecond values and applications can read the device clock with
rte_eth_timesync_read_time().

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
---
V2: Removed read_clock support

 drivers/net/intel/cpfl/cpfl_ethdev.c | 107 +++++++++++++++++++++++++++
 drivers/net/intel/cpfl/cpfl_ethdev.h |   1 +
 drivers/net/intel/idpf/idpf_ptp.c    |   5 ++
 drivers/net/intel/idpf/idpf_ptp.h    |   4 +
 4 files changed, 117 insertions(+)

diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 4315adb68c..e4dabd8043 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -1335,6 +1335,110 @@ cpfl_hairpin_unbind(struct rte_eth_dev *dev, uint16_t rx_port)
 	return 0;
 }
 
+static int
+cpfl_timesync_enable(struct rte_eth_dev *dev)
+{
+	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
+	struct idpf_vport *vport = &cpfl_vport->base;
+	struct idpf_adapter *adapter = vport->adapter;
+	struct timespec sys_ts;
+	uint64_t ns;
+	int ret;
+
+	if (dev->data->dev_started && !(dev->data->dev_conf.rxmode.offloads &
+	    RTE_ETH_RX_OFFLOAD_TIMESTAMP)) {
+		PMD_DRV_LOG(ERR, "Rx timestamp offload not configured");
+		return -1;
+	}
+
+	/* PTP state is shared by all vports of the adapter. */
+	if (adapter->ptp != NULL)
+		return 0;
+
+	adapter->ptp = rte_zmalloc(NULL, sizeof(struct idpf_ptp), 0);
+	if (adapter->ptp == NULL) {
+		PMD_DRV_LOG(ERR, "Failed to allocate memory for PTP");
+		return -ENOMEM;
+	}
+
+	ret = idpf_ptp_get_caps(adapter);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "Failed to get PTP capabilities, err=%d", ret);
+		goto fail_ptp;
+	}
+
+	/*
+	 * Write the default increment time value if the clock adjustments
+	 * are enabled.
+	 */
+	if (adapter->ptp->adj_dev_clk_time_access != IDPF_PTP_NONE) {
+		ret = idpf_ptp_adj_dev_clk_fine(adapter, adapter->ptp->base_incval);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP set incval failed, err=%d", ret);
+			goto fail_ptp;
+		}
+	}
+
+	/* Do not initialize the PTP if the device clock time cannot be read. */
+	if (adapter->ptp->get_dev_clk_time_access == IDPF_PTP_NONE) {
+		PMD_DRV_LOG(ERR, "Getting device clock time is not supported");
+		ret = -EIO;
+		goto fail_ptp;
+	}
+
+	/* Set the device clock time to system time. */
+	if (adapter->ptp->set_dev_clk_time_access != IDPF_PTP_NONE) {
+		clock_gettime(CLOCK_REALTIME, &sys_ts);
+		ns = rte_timespec_to_ns(&sys_ts);
+		ret = idpf_ptp_set_dev_clk_time(adapter, ns);
+		if (ret) {
+			PMD_DRV_LOG(ERR, "PTP set clock time failed, err=%d", ret);
+			goto fail_ptp;
+		}
+	}
+
+	adapter->ptp->cmd.shtime_enable_mask = PF_GLTSYN_CMD_SYNC_SHTIME_EN_M;
+	adapter->ptp->cmd.exec_cmd_mask = PF_GLTSYN_CMD_SYNC_EXEC_CMD_M;
+
+	return 0;
+
+fail_ptp:
+	rte_free(adapter->ptp);
+	adapter->ptp = NULL;
+	return ret;
+}
+
+static int
+cpfl_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
+{
+	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = cpfl_vport->base.adapter;
+	uint64_t time;
+	int ret;
+
+	ret = idpf_ptp_read_src_clk_reg(adapter, &time);
+	if (ret)
+		PMD_DRV_LOG(ERR, "PTP read time failed, err %d", ret);
+	else
+		*ts = rte_ns_to_timespec(time);
+
+	return ret;
+}
+
+static int
+cpfl_timesync_disable(struct rte_eth_dev *dev)
+{
+	struct cpfl_vport *cpfl_vport = dev->data->dev_private;
+	struct idpf_adapter *adapter = cpfl_vport->base.adapter;
+
+	if (adapter->ptp != NULL) {
+		rte_free(adapter->ptp);
+		adapter->ptp = NULL;
+	}
+
+	return 0;
+}
+
 static const struct eth_dev_ops cpfl_eth_dev_ops = {
 	.dev_configure			= cpfl_dev_configure,
 	.dev_close			= cpfl_dev_close,
@@ -1368,6 +1472,9 @@ static const struct eth_dev_ops cpfl_eth_dev_ops = {
 	.hairpin_get_peer_ports         = cpfl_hairpin_get_peer_ports,
 	.hairpin_bind                   = cpfl_hairpin_bind,
 	.hairpin_unbind                 = cpfl_hairpin_unbind,
+	.timesync_enable                = cpfl_timesync_enable,
+	.timesync_read_time             = cpfl_timesync_read_time,
+	.timesync_disable               = cpfl_timesync_disable,
 };
 
 static int
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index d41aa93191..a9e532a46c 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -16,6 +16,7 @@
 
 #include <idpf_common_device.h>
 #include <idpf_common_virtchnl.h>
+#include <idpf_ptp.h>
 #include <base/idpf_prototype.h>
 #include <base/virtchnl2.h>
 
diff --git a/drivers/net/intel/idpf/idpf_ptp.c b/drivers/net/intel/idpf/idpf_ptp.c
index 5c3fcb90e4..47830de239 100644
--- a/drivers/net/intel/idpf/idpf_ptp.c
+++ b/drivers/net/intel/idpf/idpf_ptp.c
@@ -2,6 +2,7 @@
  * Copyright(c) 2025 Intel Corporation
  */
 
+#include <eal_export.h>
 #include "idpf_ptp.h"
 #include "idpf_common_virtchnl.h"
 #include "base/virtchnl2.h"
@@ -38,6 +39,7 @@ idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 		IDPF_PTP_ACCESS(adapter, VIRTCHNL2_CAP_PTP_TX_TSTAMPS);
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_get_caps)
 int
 idpf_ptp_get_caps(struct idpf_adapter *adapter)
 {
@@ -212,6 +214,7 @@ idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_set_dev_clk_time)
 int
 idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time)
 {
@@ -256,6 +259,7 @@ idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta)
 	return err;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_adj_dev_clk_fine)
 int
 idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t incval)
 {
@@ -487,6 +491,7 @@ idpf_ptp_read_src_clk_reg_mailbox(struct idpf_adapter *adapter,
  *
  * Return: 0 on success, -errno otherwise.
  */
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_ptp_read_src_clk_reg)
 int
 idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t *src_clk)
 {
diff --git a/drivers/net/intel/idpf/idpf_ptp.h b/drivers/net/intel/idpf/idpf_ptp.h
index 0c901440fb..851cdad027 100644
--- a/drivers/net/intel/idpf/idpf_ptp.h
+++ b/drivers/net/intel/idpf/idpf_ptp.h
@@ -88,13 +88,17 @@ struct idpf_ptp_dev_timers {
 	uint64_t dev_clk_time_ns;
 };
 
+__rte_internal
 int idpf_ptp_get_caps(struct idpf_adapter *adapter);
+__rte_internal
 int idpf_ptp_read_src_clk_reg(struct idpf_adapter *adapter, uint64_t *src_clk);
 int idpf_ptp_get_dev_clk_time(struct idpf_adapter *adapter,
 			     struct idpf_ptp_dev_timers *dev_clk_time);
 int idpf_ptp_get_cross_time(struct idpf_adapter *adapter,
 			    struct idpf_ptp_dev_timers *cross_time);
+__rte_internal
 int idpf_ptp_set_dev_clk_time(struct idpf_adapter *adapter, uint64_t time);
+__rte_internal
 int idpf_ptp_adj_dev_clk_fine(struct idpf_adapter *adapter, uint64_t incval);
 int idpf_ptp_adj_dev_clk_time(struct idpf_adapter *adapter, int64_t delta);
 int idpf_ptp_get_vport_tstamps_caps(struct idpf_vport *vport);
-- 
2.34.1

