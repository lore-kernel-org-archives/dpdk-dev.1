Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6210C8303F
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:24:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4CFF40276;
	Fri, 29 Aug 2025 10:24:18 +0200 (CEST)
Received: from lf-2-40.ptr.blmpb.com (lf-2-40.ptr.blmpb.com [101.36.218.40])
 by mails.dpdk.org (Postfix) with ESMTP id EE36C40263
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455850; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=IaEoWbNCE+Zue3YEPfWOcvEz2diomtvj19d6ucpPKwU=;
 b=H4eHvtUFnTSflpfpnzHQEN9kspyZ9VwgC/Yt1ZoQpPTkRDG4xaG19i4WlOm/qO3tUIxsgL
 IgOGWduTv/gxEohmPmeWFOrohNVj4Vop3vFHikkMKDq3ZdgEMgpETibV3PV1SU3BkjMucv
 YpAea/3BDkM5Zz6VuVyTvG+Kvpv6L+XddW1vKQeEShg2Wi4TL0fMNb/nyHxFMw0tU2n1hl
 ZRo5KVY3EgHz6RjPtLOMedySoVd/g5wTOdOzfq8D+9QEGBF1wN0Ibqc0t74vqTS4mGu8LM
 8K0JXgat1Ad23x2ebujA3FpdmZYcOUJ9DCBiZL6lCDCc6pXtCDL36rEeyHv6OA==
Date: Fri, 29 Aug 2025 16:24:07 +0800
Message-Id: <20250829082406.24369-2-wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
X-Lms-Return-Path: <lba+268b163a8+b286a7+dpdk.org+wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 01/14] net/xsc: add FW version get support
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:07 +0800
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Mime-Version: 1.0
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

Add support for querying the firmware version of the xsc device.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 doc/guides/nics/features/xsc.ini |  1 +
 drivers/net/xsc/xsc_dev.c        | 13 +++++++++++++
 drivers/net/xsc/xsc_dev.h        |  4 ++++
 drivers/net/xsc/xsc_ethdev.c     |  9 +++++++++
 drivers/net/xsc/xsc_vfio.c       | 18 ++++++++++++++++++
 5 files changed, 45 insertions(+)

diff --git a/doc/guides/nics/features/xsc.ini b/doc/guides/nics/features/xsc.ini
index 8d5c292b7f..e0f7b0bc1f 100644
--- a/doc/guides/nics/features/xsc.ini
+++ b/doc/guides/nics/features/xsc.ini
@@ -14,6 +14,7 @@ Inner L3 checksum    = Y
 Inner L4 checksum    = Y
 Basic stats          = Y
 Stats per queue      = Y
+FW version           = Y
 Linux                = Y
 ARMv8                = Y
 x86-64               = Y
diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index fc9f1cddfc..66f98d2327 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -15,6 +15,7 @@
 #include <rte_kvargs.h>
 #include <rte_eal_paging.h>
 #include <rte_bitops.h>
+#include <rte_string_fns.h>
 
 #include "xsc_log.h"
 #include "xsc_defs.h"
@@ -398,3 +399,15 @@ xsc_dev_is_vf(struct xsc_dev *xdev)
 
 	return false;
 }
+
+int
+xsc_dev_fw_version_get(struct xsc_dev *xdev, char *fw_version, size_t fw_size)
+{
+	size_t size = strnlen(xdev->hwinfo.fw_ver, sizeof(xdev->hwinfo.fw_ver)) + 1;
+
+	if (fw_size < size)
+		return size;
+	rte_strlcpy(fw_version, xdev->hwinfo.fw_ver, fw_size);
+
+	return 0;
+}
diff --git a/drivers/net/xsc/xsc_dev.h b/drivers/net/xsc/xsc_dev.h
index cc5fa8aad8..274d6c6a2e 100644
--- a/drivers/net/xsc/xsc_dev.h
+++ b/drivers/net/xsc/xsc_dev.h
@@ -27,6 +27,8 @@
 #define XSC_DEV_PCT_IDX_INVALID	0xFFFFFFFF
 #define XSC_DEV_REPR_ID_INVALID	0x7FFFFFFF
 
+#define XSC_FW_VERS_LEN			64
+
 enum xsc_queue_type {
 	XSC_QUEUE_TYPE_RDMA_RC		= 0,
 	XSC_QUEUE_TYPE_RDMA_MAD		= 1,
@@ -68,6 +70,7 @@ struct xsc_hwinfo {
 	uint8_t pct_compress_vld;
 	uint8_t mac_bit;
 	uint8_t esw_mode;
+	char fw_ver[XSC_FW_VERS_LEN];
 };
 
 struct xsc_devargs {
@@ -180,5 +183,6 @@ bool xsc_dev_is_vf(struct xsc_dev *xdev);
 int xsc_dev_qp_set_id_get(struct xsc_dev *xdev, int repr_id);
 int xsc_dev_set_mtu(struct xsc_dev *xdev, uint16_t mtu);
 int xsc_dev_get_mac(struct xsc_dev *xdev, uint8_t *mac);
+int xsc_dev_fw_version_get(struct xsc_dev *xdev, char *fw_version, size_t fw_size);
 
 #endif /* _XSC_DEV_H_ */
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 3830c18c03..79c4e13cd4 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -674,6 +674,14 @@ xsc_ethdev_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *mac, uin
 	return 0;
 }
 
+static int
+xsc_ethdev_fw_version_get(struct rte_eth_dev *dev, char *fw_version, size_t fw_size)
+{
+	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(dev);
+
+	return xsc_dev_fw_version_get(priv->xdev, fw_version, fw_size);
+}
+
 const struct eth_dev_ops xsc_eth_dev_ops = {
 	.dev_configure = xsc_ethdev_configure,
 	.dev_start = xsc_ethdev_start,
@@ -692,6 +700,7 @@ const struct eth_dev_ops xsc_eth_dev_ops = {
 	.mtu_set = xsc_ethdev_set_mtu,
 	.rss_hash_update = xsc_ethdev_rss_hash_update,
 	.rss_hash_conf_get = xsc_ethdev_rss_hash_conf_get,
+	.fw_version_get = xsc_ethdev_fw_version_get,
 };
 
 static int
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 422d30efb9..857fa449f0 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -61,6 +61,23 @@ xsc_vfio_pcie_no_init(struct xsc_hwinfo *hwinfo)
 		hwinfo->pcie_no = XSC_SOC_PCIE_NO_DEFAULT;
 }
 
+static void
+xsc_vfio_fw_version_init(char *hw_fw_ver, struct xsc_cmd_fw_version *cmd_fw_ver)
+{
+	uint16_t patch = rte_be_to_cpu_16(cmd_fw_ver->patch);
+	uint32_t tweak = rte_be_to_cpu_32(cmd_fw_ver->tweak);
+
+	if (tweak == 0) {
+		snprintf(hw_fw_ver, XSC_FW_VERS_LEN, "v%hhu.%hhu.%hu",
+			 cmd_fw_ver->major, cmd_fw_ver->minor,
+			 patch);
+	} else {
+		snprintf(hw_fw_ver, XSC_FW_VERS_LEN, "v%hhu.%hhu.%hu+%u",
+			 cmd_fw_ver->major, cmd_fw_ver->minor,
+			 patch, tweak);
+	}
+}
+
 static int
 xsc_vfio_hwinfo_init(struct xsc_dev *xdev)
 {
@@ -126,6 +143,7 @@ xsc_vfio_hwinfo_init(struct xsc_dev *xdev)
 	xdev->hwinfo.hca_core_clock = rte_be_to_cpu_32(hca_cap->hca_core_clock);
 	xdev->hwinfo.mac_bit = hca_cap->mac_bit;
 	xsc_vfio_pcie_no_init(&xdev->hwinfo);
+	xsc_vfio_fw_version_init(xdev->hwinfo.fw_ver, &hca_cap->fw_ver);
 
 exit:
 	free(cmd_buf);
-- 
2.25.1
