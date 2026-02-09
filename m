Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E3AFE9E311
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 15:05:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CDAC4065D;
	Wed, 11 Feb 2026 16:04:50 +0100 (CET)
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com
 [67.231.149.131])
 by mails.dpdk.org (Postfix) with ESMTP id E765E402B0
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:16:07 +0100 (CET)
Received: from pps.filterd (m0050095.ppops.net [127.0.0.1])
 by m0050095.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id
 619BQCHV4036027; Mon, 9 Feb 2026 16:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=jan2016.eng;
 bh=heQs19i3rNfqc5G+OZw3RyWCf88ALQCrYsJl/Y4CMiw=; b=j7UTLJ0r4bdO
 MmWZI+Vc1JoreizfBer5reM7RfFmKxDF8/BV4qTRZ5BVUTcThrzbR3gmrK0yWxUE
 KSG65zAdkgq5mIVSUrVZzv+VC2kEJsd3q6e8DoTyY+LCsyZP3MXWurLTy7AyofBC
 iM/rGTBmKNRadwu/ez1IesvkNpTCkuxUiH8Zlze6IfHnYzXxamrogclOEgjHo0hh
 yGCLyZ7OMwlWvqGnA6hT0WPLEypZnlxlJxke7kikac5WlUP7Y3JsaHChRtpwC7kG
 +BGXdzRdD+7QaBgP705zlFLXQ4iwwfmkuYeLi0eyvXO0l3L+kJD8G1U1LjozRTlc
 8Qs9pc2wbA==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
 by m0050095.ppops.net-00190b01. (PPS) with ESMTPS id 4c5xgr8amb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 16:16:06 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
 by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id
 619F0Uu5029982; Mon, 9 Feb 2026 11:16:05 -0500
Received: from email.msg.corp.akamai.com ([172.27.91.41])
 by prod-mail-ppoint1.akamai.com (PPS) with ESMTPS id 4c61m3fevh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Feb 2026 11:16:05 -0500
Received: from usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Feb 2026 08:16:05 -0800
Received: from lon-lph85swt.london.corp.akamai.com (172.27.164.43) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 id 15.2.2562.29 via Frontend Transport; Mon, 9 Feb 2026 08:16:05 -0800
Received: by lon-lph85swt.london.corp.akamai.com (Postfix, from userid 37336)
 id 74A4D15634D2; Mon,  9 Feb 2026 16:16:04 +0000 (GMT)
From: Max Tottenham <mtottenh@akamai.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <mtottenh@akamai.com>, <johunt@akamai.com>
Subject: [PATCH v2 1/3] common/mlx5: fix ROCE disable for auxiliary SF devices
Date: Mon, 9 Feb 2026 16:14:38 +0000
Message-ID: <20260209161440.1947052-2-mtottenh@akamai.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260209161440.1947052-1-mtottenh@akamai.com>
References: <20260209161440.1947052-1-mtottenh@akamai.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 malwarescore=0
 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2602090135
X-Proofpoint-GUID: agZLyDTCK-XdJ_yyrSPME9M9vA7YNpXD
X-Authority-Analysis: v=2.4 cv=L8kQguT8 c=1 sm=1 tr=0 ts=698a0846 cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=X7Ea-ya5AAAA:8 a=Q5woQSn8qfGFZKRTzbwA:9
X-Proofpoint-ORIG-GUID: agZLyDTCK-XdJ_yyrSPME9M9vA7YNpXD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA5MDEzNyBTYWx0ZWRfX8eVVei5OnxtN
 Oo3wOvFgpBi3O3TPOF1afAeGiJjDAYzWtqDpKzeEEYZ+iGLd2GMUUp5DIJjSIZNrbFFDXAGR+jN
 LmiobPaYRUCuJlWPdhJH0jrQ5lmXclisKr1pwL2IV2p0JiGze8NsHqRdmQ9kj1DiRdMHX7tMJlY
 PCOVvgUhIrMmjlDKOSUJf1w2+xHBmOvBt917UAN9XxSoKc/lJ/w7ZoiTLSuywDohyS66BG5Q2O1
 d5N7x2TBLHDk7hL3jLwR/J/xITzBpU2l34qeabop2dd2J6ATUqRFHB8yhsP2/zDr1tREgMhvreA
 IjsQrboAxBVJZmsf2zf10DkIP57Y41PunzoIss4GaPpr6c2QEVBEjF+2MQm65//rQvnpfkCsgQ5
 R6IfhX9gNWeaRo86RkEumRcseVuGRBW7RiqyCRsj44wOz+3vTauQJSCx6+WP4XsOOBlXY8Pcyx0
 8nDUMFV+0GsdXjjWzLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602090137
X-Mailman-Approved-At: Wed, 11 Feb 2026 16:04:47 +0100
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

When probing an SF as a vDPA device, mlx5_roce_disable() targets the
parent PF address (via mlx5_dev_to_pci_str). This incorrectly attempts
to disable ROCE on the parent PF rather than the SF itself.

This causes vDPA probe failures when the parent PF already has an open
IB context (e.g., probed for uplink ports or SF representors).

Properly disable ROCE for auxiliary devices by using the correct devlink
attributes:
- DEVLINK_ATTR_BUS_NAME = "auxiliary"
- DEVLINK_ATTR_DEV_NAME = device name from rte_device->name

Refactor mlx5_nl_enable_roce_get(), mlx5_nl_enable_roce_set(), and
mlx5_nl_driver_reload() to accept bus_name and dev_name parameters
instead of hardcoding "pci". This allows the same netlink code path
to work for both PCI and auxiliary bus devices.

For PCI devices, behavior is unchanged: try netlink first, fall back
to sysfs. For auxiliary devices, only netlink is used since sysfs
ROCE control is PCI-based.

Signed-off-by: Max Tottenham <mtottenh@akamai.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c | 37 ++++++++---
 drivers/common/mlx5/linux/mlx5_nl.c        | 72 ++++++++++++----------
 drivers/common/mlx5/linux/mlx5_nl.h        |  8 +--
 3 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 2867e21618..3e2c66539c 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -609,7 +609,7 @@ mlx5_os_get_ibv_device(const struct rte_pci_device *pci_dev)
 
 /* Try to disable ROCE by Netlink\Devlink. */
 static int
-mlx5_nl_roce_disable(const char *addr)
+mlx5_nl_roce_disable(const char *bus_name, const char *dev_name)
 {
 	int nlsk_fd = mlx5_nl_init(NETLINK_GENERIC, 0);
 	int devlink_id;
@@ -625,7 +625,8 @@ mlx5_nl_roce_disable(const char *addr)
 			"Failed to get devlink id for ROCE operations by Netlink.");
 		goto close;
 	}
-	ret = mlx5_nl_enable_roce_get(nlsk_fd, devlink_id, addr, &enable);
+	ret = mlx5_nl_enable_roce_get(nlsk_fd, devlink_id, bus_name, dev_name,
+				      &enable);
 	if (ret) {
 		DRV_LOG(DEBUG, "Failed to get ROCE enable by Netlink: %d.",
 			ret);
@@ -634,7 +635,8 @@ mlx5_nl_roce_disable(const char *addr)
 		DRV_LOG(INFO, "ROCE has already disabled(Netlink).");
 		goto close;
 	}
-	ret = mlx5_nl_enable_roce_set(nlsk_fd, devlink_id, addr, 0);
+	ret = mlx5_nl_enable_roce_set(nlsk_fd, devlink_id, bus_name, dev_name,
+				      0);
 	if (ret)
 		DRV_LOG(DEBUG, "Failed to disable ROCE by Netlink: %d.", ret);
 	else
@@ -688,14 +690,29 @@ mlx5_sys_roce_disable(const char *addr)
 static int
 mlx5_roce_disable(const struct rte_device *dev)
 {
-	char pci_addr[PCI_PRI_STR_SIZE] = { 0 };
+	if (mlx5_dev_is_pci(dev)) {
+		char pci_addr[PCI_PRI_STR_SIZE] = { 0 };
 
-	if (mlx5_dev_to_pci_str(dev, pci_addr, sizeof(pci_addr)) < 0)
-		return -rte_errno;
-	/* Firstly try to disable ROCE by Netlink and fallback to sysfs. */
-	if (mlx5_nl_roce_disable(pci_addr) != 0 &&
-	    mlx5_sys_roce_disable(pci_addr) != 0)
-		return -rte_errno;
+		if (mlx5_dev_to_pci_str(dev, pci_addr, sizeof(pci_addr)) < 0)
+			return -rte_errno;
+		/* For PCI: try netlink first, fallback to sysfs. */
+		if (mlx5_nl_roce_disable("pci", pci_addr) != 0 &&
+		    mlx5_sys_roce_disable(pci_addr) != 0)
+			return -rte_errno;
+	} else {
+		/*
+		 * For auxiliary (SF) devices: use netlink with auxiliary bus.
+		 * The device name from rte_device is used directly as the
+		 * devlink device identifier.
+		 */
+		if (mlx5_nl_roce_disable("auxiliary", dev->name) != 0) {
+			DRV_LOG(WARNING,
+				"Failed to disable ROCE for SF \"%s\" via netlink.",
+				dev->name);
+			/* No sysfs fallback for auxiliary devices. */
+			return -rte_errno;
+		}
+	}
 	return 0;
 }
 
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index d53543a113..7bb1c7d258 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -1783,8 +1783,10 @@ mlx5_nl_roce_cb(struct nlmsghdr *nh, void *arg)
  *   Netlink socket file descriptor.
  * @param[in] family_id
  *   the Devlink family ID.
- * @param pci_addr
- *   The device PCI address.
+ * @param[in] bus_name
+ *   The devlink bus name (e.g., "pci" or "auxiliary").
+ * @param[in] dev_name
+ *   The devlink device name (e.g., PCI address or auxiliary device name).
  * @param[out] enable
  *   Where to store the enable status.
  *
@@ -1793,8 +1795,8 @@ mlx5_nl_roce_cb(struct nlmsghdr *nh, void *arg)
  *   and rte_errno is set.
  */
 int
-mlx5_nl_enable_roce_get(int nlsk_fd, int family_id, const char *pci_addr,
-			int *enable)
+mlx5_nl_enable_roce_get(int nlsk_fd, int family_id, const char *bus_name,
+			const char *dev_name, int *enable)
 {
 	struct nlmsghdr *nlh;
 	struct genlmsghdr *genl;
@@ -1815,20 +1817,20 @@ mlx5_nl_enable_roce_get(int nlsk_fd, int family_id, const char *pci_addr,
 	nlh->nlmsg_len += sizeof(struct genlmsghdr);
 	genl->cmd = DEVLINK_CMD_PARAM_GET;
 	genl->version = DEVLINK_GENL_VERSION;
-	nl_attr_put(nlh, DEVLINK_ATTR_BUS_NAME, "pci", 4);
-	nl_attr_put(nlh, DEVLINK_ATTR_DEV_NAME, pci_addr, strlen(pci_addr) + 1);
+	nl_attr_put(nlh, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) + 1);
+	nl_attr_put(nlh, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) + 1);
 	nl_attr_put(nlh, DEVLINK_ATTR_PARAM_NAME, "enable_roce", 12);
 	ret = mlx5_nl_send(nlsk_fd, nlh, sn);
 	if (ret >= 0)
 		ret = mlx5_nl_recv(nlsk_fd, sn, mlx5_nl_roce_cb, &cur_en);
 	if (ret < 0) {
-		DRV_LOG(DEBUG, "Failed to get ROCE enable on device %s: %d.",
-			pci_addr, ret);
+		DRV_LOG(DEBUG, "Failed to get ROCE enable on device %s/%s: %d.",
+			bus_name, dev_name, ret);
 		return ret;
 	}
 	*enable = cur_en;
-	DRV_LOG(DEBUG, "ROCE is %sabled for device \"%s\".",
-		cur_en ? "en" : "dis", pci_addr);
+	DRV_LOG(DEBUG, "ROCE is %sabled for device \"%s/%s\".",
+		cur_en ? "en" : "dis", bus_name, dev_name);
 	return ret;
 }
 
@@ -1839,16 +1841,17 @@ mlx5_nl_enable_roce_get(int nlsk_fd, int family_id, const char *pci_addr,
  *   Netlink socket file descriptor.
  * @param[in] family_id
  *   the Devlink family ID.
- * @param pci_addr
- *   The device PCI address.
- * @param[out] enable
- *   The enable status to set.
+ * @param[in] bus_name
+ *   The devlink bus name (e.g., "pci" or "auxiliary").
+ * @param[in] dev_name
+ *   The devlink device name (e.g., PCI address or auxiliary device name).
  *
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 static int
-mlx5_nl_driver_reload(int nlsk_fd, int family_id, const char *pci_addr)
+mlx5_nl_driver_reload(int nlsk_fd, int family_id, const char *bus_name,
+		      const char *dev_name)
 {
 	struct nlmsghdr *nlh;
 	struct genlmsghdr *genl;
@@ -1868,18 +1871,18 @@ mlx5_nl_driver_reload(int nlsk_fd, int family_id, const char *pci_addr)
 	nlh->nlmsg_len += sizeof(struct genlmsghdr);
 	genl->cmd = DEVLINK_CMD_RELOAD;
 	genl->version = DEVLINK_GENL_VERSION;
-	nl_attr_put(nlh, DEVLINK_ATTR_BUS_NAME, "pci", 4);
-	nl_attr_put(nlh, DEVLINK_ATTR_DEV_NAME, pci_addr, strlen(pci_addr) + 1);
+	nl_attr_put(nlh, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) + 1);
+	nl_attr_put(nlh, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) + 1);
 	ret = mlx5_nl_send(nlsk_fd, nlh, sn);
 	if (ret >= 0)
 		ret = mlx5_nl_recv(nlsk_fd, sn, NULL, NULL);
 	if (ret < 0) {
-		DRV_LOG(DEBUG, "Failed to reload %s device by Netlink - %d",
-			pci_addr, ret);
+		DRV_LOG(DEBUG, "Failed to reload %s/%s device by Netlink - %d",
+			bus_name, dev_name, ret);
 		return ret;
 	}
-	DRV_LOG(DEBUG, "Device \"%s\" was reloaded by Netlink successfully.",
-		pci_addr);
+	DRV_LOG(DEBUG, "Device \"%s/%s\" was reloaded by Netlink successfully.",
+		bus_name, dev_name);
 	return 0;
 }
 
@@ -1890,17 +1893,19 @@ mlx5_nl_driver_reload(int nlsk_fd, int family_id, const char *pci_addr)
  *   Netlink socket file descriptor.
  * @param[in] family_id
  *   the Devlink family ID.
- * @param pci_addr
- *   The device PCI address.
- * @param[out] enable
+ * @param[in] bus_name
+ *   The devlink bus name (e.g., "pci" or "auxiliary").
+ * @param[in] dev_name
+ *   The devlink device name (e.g., PCI address or auxiliary device name).
+ * @param[in] enable
  *   The enable status to set.
  *
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
 int
-mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
-			int enable)
+mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *bus_name,
+			const char *dev_name, int enable)
 {
 	struct nlmsghdr *nlh;
 	struct genlmsghdr *genl;
@@ -1912,7 +1917,6 @@ mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
 		    NLMSG_ALIGN(MLX5_NL_MAX_ATTR_SIZE) * 6];
 	uint8_t cmode = DEVLINK_PARAM_CMODE_DRIVERINIT;
 	uint8_t ptype = NLA_FLAG;
-;
 
 	memset(buf, 0, sizeof(buf));
 	nlh = (struct nlmsghdr *)buf;
@@ -1923,8 +1927,8 @@ mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
 	nlh->nlmsg_len += sizeof(struct genlmsghdr);
 	genl->cmd = DEVLINK_CMD_PARAM_SET;
 	genl->version = DEVLINK_GENL_VERSION;
-	nl_attr_put(nlh, DEVLINK_ATTR_BUS_NAME, "pci", 4);
-	nl_attr_put(nlh, DEVLINK_ATTR_DEV_NAME, pci_addr, strlen(pci_addr) + 1);
+	nl_attr_put(nlh, DEVLINK_ATTR_BUS_NAME, bus_name, strlen(bus_name) + 1);
+	nl_attr_put(nlh, DEVLINK_ATTR_DEV_NAME, dev_name, strlen(dev_name) + 1);
 	nl_attr_put(nlh, DEVLINK_ATTR_PARAM_NAME, "enable_roce", 12);
 	nl_attr_put(nlh, DEVLINK_ATTR_PARAM_VALUE_CMODE, &cmode, sizeof(cmode));
 	nl_attr_put(nlh, DEVLINK_ATTR_PARAM_TYPE, &ptype, sizeof(ptype));
@@ -1934,14 +1938,14 @@ mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
 	if (ret >= 0)
 		ret = mlx5_nl_recv(nlsk_fd, sn, NULL, NULL);
 	if (ret < 0) {
-		DRV_LOG(DEBUG, "Failed to %sable ROCE for device %s by Netlink:"
-			" %d.", enable ? "en" : "dis", pci_addr, ret);
+		DRV_LOG(DEBUG, "Failed to %sable ROCE for device %s/%s by Netlink:"
+			" %d.", enable ? "en" : "dis", bus_name, dev_name, ret);
 		return ret;
 	}
-	DRV_LOG(DEBUG, "Device %s ROCE was %sabled by Netlink successfully.",
-		pci_addr, enable ? "en" : "dis");
+	DRV_LOG(DEBUG, "Device %s/%s ROCE was %sabled by Netlink successfully.",
+		bus_name, dev_name, enable ? "en" : "dis");
 	/* Now, need to reload the driver. */
-	return mlx5_nl_driver_reload(nlsk_fd, family_id, pci_addr);
+	return mlx5_nl_driver_reload(nlsk_fd, family_id, bus_name, dev_name);
 }
 
 /**
diff --git a/drivers/common/mlx5/linux/mlx5_nl.h b/drivers/common/mlx5/linux/mlx5_nl.h
index 3f79a73c85..6c9ec0462e 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.h
+++ b/drivers/common/mlx5/linux/mlx5_nl.h
@@ -96,10 +96,10 @@ uint32_t mlx5_nl_vlan_vmwa_create(struct mlx5_nl_vlan_vmwa_context *vmwa,
 
 __rte_internal
 int mlx5_nl_devlink_family_id_get(int nlsk_fd);
-int mlx5_nl_enable_roce_get(int nlsk_fd, int family_id, const char *pci_addr,
-			    int *enable);
-int mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
-			    int enable);
+int mlx5_nl_enable_roce_get(int nlsk_fd, int family_id, const char *bus_name,
+			    const char *dev_name, int *enable);
+int mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *bus_name,
+			    const char *dev_name, int enable);
 
 __rte_internal
 int mlx5_nl_read_events(int nlsk_fd, mlx5_nl_event_cb *cb, void *cb_arg);
-- 
2.52.0

