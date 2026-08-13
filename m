Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE557C5CFEB
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 10:45:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97AA942D91;
	Thu, 13 Aug 2026 12:44:31 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2088942D76
 for <dev@dpdk.org>; Thu, 13 Aug 2026 12:44:28 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 060FA1A0036;
 Thu, 13 Aug 2026 12:44:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BEC9D1A003F;
 Thu, 13 Aug 2026 12:44:27 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AAEBB18000B1;
 Thu, 13 Aug 2026 18:44:26 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	thomas@monjalon.net,
	dev@dpdk.org
Subject: [PATCH v10 14/25] net/dpaa: add Tx rate limiting API
Date: Thu, 13 Aug 2026 16:13:54 +0530
Message-Id: <20260813104405.2313474-15-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260813104405.2313474-1-hemant.agrawal@nxp.com>
References: <20260812174609.1100111-1-hemant.agrawal@nxp.com>
 <20260813104405.2313474-1-hemant.agrawal@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add a DPAA PMD API to configure the transmit rate limit (rate and
burst) on a DPAA port, using the FMAN port rate limiter.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa/dpaa_flow.c         | 93 ++++++++++++++++++++++++++++
 drivers/net/dpaa/fmlib/fm_lib.c      | 32 +++++++++-
 drivers/net/dpaa/fmlib/fm_port_ext.h |  4 +-
 drivers/net/dpaa/rte_pmd_dpaa.h      | 23 ++++++-
 4 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index bfe294d21d..db19617c61 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -8,6 +8,8 @@
 #include <unistd.h>
 #include <sys/types.h>
 
+#include <eal_export.h>
+#include <dpaa_mempool.h>
 #include <dpaa_ethdev.h>
 #include <dpaa_flow.h>
 #include <rte_dpaa_logs.h>
@@ -673,6 +675,22 @@ static inline int get_rx_port_type(struct fman_if *fif)
 	return e_FM_PORT_TYPE_DUMMY;
 }
 
+static inline int get_tx_port_type(struct fman_if *fif)
+{
+	if (fif->mac_type == fman_offline_internal ||
+			fif->mac_type == fman_onic)
+		return e_FM_PORT_TYPE_OH_OFFLINE_PARSING;
+	else if (fif->mac_type == fman_mac_1g)
+		return e_FM_PORT_TYPE_TX;
+	else if (fif->mac_type == fman_mac_2_5g)
+		return e_FM_PORT_TYPE_TX_2_5G;
+	else if (fif->mac_type == fman_mac_10g)
+		return e_FM_PORT_TYPE_TX_10G;
+
+	DPAA_PMD_ERR("MAC type unsupported");
+	return e_FM_PORT_TYPE_DUMMY;
+}
+
 static inline int set_fm_port_handle(struct dpaa_if *dpaa_intf,
 				     uint64_t req_dist_set,
 				     struct fman_if *fif)
@@ -1078,3 +1096,78 @@ int dpaa_port_vsp_cleanup(struct dpaa_if *dpaa_intf, struct fman_if *fif)
 
 	return E_OK;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa_port_set_rate_limit, 26.11)
+int rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
+				     uint32_t rate)
+{
+	t_fm_port_rate_limit port_rate_limit;
+	bool port_handle_exists = true;
+	void *handle;
+	int ret;
+	struct rte_eth_dev *dev;
+	struct dpaa_if *dpaa_intf;
+	struct fman_if *fif;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+	dpaa_intf = dev->data->dev_private;
+	fif = dev->process_private;
+
+	memset(&port_rate_limit, 0, sizeof(port_rate_limit));
+	port_rate_limit.max_burst_size = burst;
+	port_rate_limit.rate_limit = rate;
+
+	DPAA_PMD_DEBUG("Setting Rate Limiter for port:%s  Max Burst =%u Max Rate =%u",
+		       dpaa_intf->name, burst, rate);
+
+	if (!dpaa_intf->port_handle) {
+		t_fm_port_params fm_port_params;
+
+		/* Memset FM port params */
+		memset(&fm_port_params, 0, sizeof(fm_port_params));
+
+		/* Set FM port params */
+		fm_port_params.h_fm = fm_open(0);
+		if (!fm_port_params.h_fm) {
+			DPAA_PMD_ERR("fm_open failed for port %s",
+				     dpaa_intf->name);
+			return -ENODEV;
+		}
+		fm_port_params.port_type = get_tx_port_type(fif);
+		fm_port_params.port_id = mac_idx[fif->mac_idx];
+
+		/* FM PORT Open */
+		handle = fm_port_open(&fm_port_params);
+		fm_close(fm_port_params.h_fm);
+		if (!handle) {
+			DPAA_PMD_ERR("fm_port_open failed for port %s",
+				     dpaa_intf->name);
+			return -ENODEV;
+		}
+
+		port_handle_exists = false;
+	} else {
+		handle = dpaa_intf->port_handle;
+	}
+
+	if (burst == 0 || rate == 0)
+		ret = fm_port_delete_rate_limit(handle);
+	else
+		ret = fm_port_set_rate_limit(handle, &port_rate_limit);
+
+	if (ret) {
+		DPAA_PMD_ERR("Failed to set rate limit ret = %d", ret);
+		if (!port_handle_exists)
+			fm_port_close(handle);
+		return ret;
+	}
+
+	DPAA_PMD_DEBUG("Rate limit set successfully for port %s",
+		       dpaa_intf->name);
+
+	if (!port_handle_exists)
+		fm_port_close(handle);
+
+	return 0;
+}
diff --git a/drivers/net/dpaa/fmlib/fm_lib.c b/drivers/net/dpaa/fmlib/fm_lib.c
index 65a818372e..8cdaaa16bc 100644
--- a/drivers/net/dpaa/fmlib/fm_lib.c
+++ b/drivers/net/dpaa/fmlib/fm_lib.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2024 NXP
+ * Copyright 2017-2026 NXP
  */
 
 #include <stdio.h>
@@ -561,3 +561,33 @@ get_device_id(t_handle h_dev)
 
 	return (t_handle)p_dev->id;
 }
+
+uint32_t
+fm_port_delete_rate_limit(t_handle h_fm_port)
+{
+	t_device        *p_dev = (t_device *)h_fm_port;
+
+	_fml_dbg("Calling...\n");
+
+	if (ioctl(p_dev->fd, FM_PORT_IOC_REMOVE_RATE_LIMIT))
+		RETURN_ERROR(MINOR, E_INVALID_OPERATION, NO_MSG);
+
+	_fml_dbg("Finishing.\n");
+
+	return E_OK;
+}
+
+uint32_t
+fm_port_set_rate_limit(t_handle h_fm_port, t_fm_port_rate_limit *p_rate_limit)
+{
+	t_device        *p_dev = (t_device *)h_fm_port;
+
+	_fml_dbg("Calling...\n");
+
+	if (ioctl(p_dev->fd, FM_PORT_IOC_SET_RATE_LIMIT, p_rate_limit))
+		RETURN_ERROR(MINOR, E_INVALID_OPERATION, NO_MSG);
+
+	_fml_dbg("Finishing.\n");
+
+	return E_OK;
+}
diff --git a/drivers/net/dpaa/fmlib/fm_port_ext.h b/drivers/net/dpaa/fmlib/fm_port_ext.h
index bb2e00222e..f4a6053339 100644
--- a/drivers/net/dpaa/fmlib/fm_port_ext.h
+++ b/drivers/net/dpaa/fmlib/fm_port_ext.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright 2008-2012 Freescale Semiconductor Inc.
- * Copyright 2017-2020 NXP
+ * Copyright 2017-2022 NXP
  */
 
 #ifndef __FM_PORT_EXT_H
@@ -274,7 +274,7 @@ typedef struct ioc_fm_port_congestion_groups_t {
  * @Return	0 on success; error code otherwise.
  */
 #define FM_PORT_IOC_SET_RATE_LIMIT \
-	IOW(FM_IOC_TYPE_BASE, FM_PORT_IOC_NUM(3), ioc_fm_port_rate_limit_t)
+	_IOW(FM_IOC_TYPE_BASE, FM_PORT_IOC_NUM(3), ioc_fm_port_rate_limit_t)
 
 /*
  * @Function	  fm_port_delete_rate_limit
diff --git a/drivers/net/dpaa/rte_pmd_dpaa.h b/drivers/net/dpaa/rte_pmd_dpaa.h
index 0a57e2097a..680ff387f8 100644
--- a/drivers/net/dpaa/rte_pmd_dpaa.h
+++ b/drivers/net/dpaa/rte_pmd_dpaa.h
@@ -1,11 +1,12 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018 NXP
+ * Copyright 2018,2022 NXP
  */
 
 #ifndef _PMD_DPAA_H_
 #define _PMD_DPAA_H_
 
 #include <stdint.h>
+#include <rte_compat.h>
 
 /**
  * @file rte_pmd_dpaa.h
@@ -33,4 +34,24 @@
 int
 rte_pmd_dpaa_set_tx_loopback(uint16_t port, uint8_t on);
 
+/**
+ * Set TX rate limit
+ *
+ * @param port_id
+ *    The port identifier of the Ethernet device.
+ * @param burst
+ *    Max burst size(KBytes) of the Ethernet device.
+ *    0 - Disable TX rate limit.
+ * @param rate
+ *    Max rate(Kb/sec) of the Ethernet device.
+ *    0 - Disable TX rate limit.
+ * @return
+ *    0 - if successful.
+ *    <0 - if failed, with proper error code.
+ */
+__rte_experimental
+int
+rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
+				 uint32_t rate);
+
 #endif /* _PMD_DPAA_H_ */
-- 
2.25.1

