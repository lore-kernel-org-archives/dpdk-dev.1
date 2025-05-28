Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F95CC5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 10:40:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51EFE40E17;
	Wed, 28 May 2025 12:39:47 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0992540B92
 for <dev@dpdk.org>; Wed, 28 May 2025 12:39:40 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DA0FD201183;
 Wed, 28 May 2025 12:39:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 90506200084;
 Wed, 28 May 2025 12:39:39 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DC54B180008F;
 Wed, 28 May 2025 18:39:38 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [v1 07/10] net/dpaa: add Tx rate limiting DPAA PMD API
Date: Wed, 28 May 2025 16:09:31 +0530
Message-Id: <20250528103934.1001747-8-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
References: <20250528103934.1001747-1-vanshika.shukla@nxp.com>
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

From: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>

Add support to set Tx rate on DPAA platform through PMD APIs

Signed-off-by: Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 .mailmap                             |  1 +
 drivers/net/dpaa/dpaa_flow.c         | 87 +++++++++++++++++++++++++++-
 drivers/net/dpaa/fmlib/fm_lib.c      | 30 ++++++++++
 drivers/net/dpaa/fmlib/fm_port_ext.h |  2 +-
 drivers/net/dpaa/rte_pmd_dpaa.h      | 21 ++++++-
 5 files changed, 137 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 563f602bcc..d2d9ad2758 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1635,6 +1635,7 @@ Vincent S. Cojot <vcojot@redhat.com>
 Vinh Tran <vinh.t.tran10@gmail.com>
 Vipin Padmam Ramesh <vipinp@vmware.com>
 Vinod Krishna <vinod.krishna@arm.com>
+Vinod Pullabhatla <vinod.pullabhatla@nxp.com>
 Vipin Varghese <vipin.varghese@amd.com> <vipin.varghese@intel.com>
 Vipul Ashri <vipul.ashri@oracle.com>
 Visa Hankala <visa@hankala.org>
diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 2a22b23c8f..eb4bbb097c 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2019,2021-2024 NXP
+ * Copyright 2017-2019,2021-2025 NXP
  */
 
 /* System headers */
@@ -669,6 +669,22 @@ static inline int get_rx_port_type(struct fman_if *fif)
 	return e_FM_PORT_TYPE_DUMMY;
 }
 
+static inline int get_tx_port_type(struct fman_if *fif)
+{
+	if (fif->mac_type == fman_offline_internal ||
+	    fif->mac_type == fman_onic)
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
@@ -889,9 +905,9 @@ int dpaa_fm_init(void)
 	/* FM PCD Enable */
 	ret = fm_pcd_enable(pcd_handle);
 	if (ret) {
-		fm_close(fman_handle);
 		fm_pcd_close(pcd_handle);
 		DPAA_PMD_ERR("fm_pcd_enable: Failed");
+		fm_close(fman_handle);
 		return -1;
 	}
 
@@ -1073,3 +1089,70 @@ int dpaa_port_vsp_cleanup(struct dpaa_if *dpaa_intf, struct fman_if *fif)
 
 	return E_OK;
 }
+
+int rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
+				     uint32_t rate)
+{
+	t_fm_port_rate_limit port_rate_limit;
+	bool port_handle_exists = true;
+	void *handle;
+	uint32_t ret;
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
+	DPAA_PMD_DEBUG("Port:%s: set max Burst =%u max Rate =%u",
+		dpaa_intf->name, burst, rate);
+
+	if (!dpaa_intf->port_handle) {
+		t_fm_port_params fm_port_params;
+
+		/* Memset FM port params */
+		memset(&fm_port_params, 0, sizeof(fm_port_params));
+
+		/* Set FM port params */
+		fm_port_params.h_fm = fm_open(0);
+		fm_port_params.port_type = get_tx_port_type(fif);
+		fm_port_params.port_id = mac_idx[fif->mac_idx];
+
+		/* FM PORT Open */
+		handle = fm_port_open(&fm_port_params);
+		fm_close(fm_port_params.h_fm);
+		if (!handle) {
+			DPAA_PMD_ERR("Can't open handle %p",
+				     fm_info.fman_handle);
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
+		DPAA_PMD_ERR("Failed to %s rate limit ret = %#x.",
+			(!burst || !rate) ? "del" : "set", ret);
+	} else {
+		DPAA_PMD_DEBUG("Success to %s rate limit,",
+			(!burst || !rate) ? "del" : "set");
+	}
+
+	if (!port_handle_exists)
+		fm_port_close(handle);
+
+	return -ret;
+}
diff --git a/drivers/net/dpaa/fmlib/fm_lib.c b/drivers/net/dpaa/fmlib/fm_lib.c
index b35feba004..d34993de38 100644
--- a/drivers/net/dpaa/fmlib/fm_lib.c
+++ b/drivers/net/dpaa/fmlib/fm_lib.c
@@ -558,3 +558,33 @@ get_device_id(t_handle h_dev)
 
 	return (t_handle)p_dev->id;
 }
+
+uint32_t
+fm_port_delete_rate_limit(t_handle h_fm_port)
+{
+	t_device        *p_dev = (t_device *)h_fm_port;
+
+	_fml_dbg("Calling...");
+
+	if (ioctl(p_dev->fd, FM_PORT_IOC_REMOVE_RATE_LIMIT))
+		RETURN_ERROR(MINOR, E_INVALID_OPERATION, NO_MSG);
+
+	_fml_dbg("Finishing.");
+
+	return E_OK;
+}
+
+uint32_t
+fm_port_set_rate_limit(t_handle h_fm_port, t_fm_port_rate_limit *p_rate_limit)
+{
+	t_device        *p_dev = (t_device *)h_fm_port;
+
+	_fml_dbg("Calling...");
+
+	if (ioctl(p_dev->fd, FM_PORT_IOC_SET_RATE_LIMIT, p_rate_limit))
+		RETURN_ERROR(MINOR, E_INVALID_OPERATION, NO_MSG);
+
+	_fml_dbg("Finishing.");
+
+	return E_OK;
+}
diff --git a/drivers/net/dpaa/fmlib/fm_port_ext.h b/drivers/net/dpaa/fmlib/fm_port_ext.h
index bb2e00222e..f1cbf37de3 100644
--- a/drivers/net/dpaa/fmlib/fm_port_ext.h
+++ b/drivers/net/dpaa/fmlib/fm_port_ext.h
@@ -274,7 +274,7 @@ typedef struct ioc_fm_port_congestion_groups_t {
  * @Return	0 on success; error code otherwise.
  */
 #define FM_PORT_IOC_SET_RATE_LIMIT \
-	IOW(FM_IOC_TYPE_BASE, FM_PORT_IOC_NUM(3), ioc_fm_port_rate_limit_t)
+	_IOW(FM_IOC_TYPE_BASE, FM_PORT_IOC_NUM(3), ioc_fm_port_rate_limit_t)
 
 /*
  * @Function	  fm_port_delete_rate_limit
diff --git a/drivers/net/dpaa/rte_pmd_dpaa.h b/drivers/net/dpaa/rte_pmd_dpaa.h
index ec45633ba2..1a847c4d43 100644
--- a/drivers/net/dpaa/rte_pmd_dpaa.h
+++ b/drivers/net/dpaa/rte_pmd_dpaa.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018 NXP
+ * Copyright 2018, 2022, 2024 NXP
  */
 
 #ifndef _PMD_DPAA_H_
@@ -31,4 +31,23 @@
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
+int
+rte_pmd_dpaa_port_set_rate_limit(uint16_t port_id, uint16_t burst,
+				 uint32_t rate);
+
 #endif /* _PMD_DPAA_H_ */
-- 
2.25.1

