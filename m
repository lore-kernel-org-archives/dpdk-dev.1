Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367AFCA0FF7
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 08:25:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 697D74067C;
	Fri, 29 Aug 2025 10:24:46 +0200 (CEST)
Received: from lf-2-38.ptr.blmpb.com (lf-2-38.ptr.blmpb.com [101.36.218.38])
 by mails.dpdk.org (Postfix) with ESMTP id 97A55402EF
 for <dev@dpdk.org>; Fri, 29 Aug 2025 10:24:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1756455878; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=tUWT3RKGZJwKzyLOTq30Z84FPf9Ebw11EsaUk1XdgM0=;
 b=MLE1Nw6TrUDuYFxHMuRSgU1/JrUFOmkH7JQk5cEQRtCL3FT/4xHUgxku1mwjoIRPakhLsE
 aP1bsVjYdFlQZqjfLYIxN8x01hjd/R8Je6lr7GOOvasGh2Is/Ytdrmr9ApkPh/tO8ansJN
 Pw5ZUCIGEoaZOrnGovvx+AX0tDrpt7MSkgGuKfqbVek7Oingqfe8sS2w4oSR3GC+tNVBrW
 6UYUS7DxBJIldIxUt2oeSvV2zPNhhWdRhAUgHrmB4h9Uc2hDLCdzLCJaHQEB67gFFSI1/7
 SJI3CQZhXqLAYzuA3ORUlybzPjIc4pGsUCs9bFv9A8qR+VSOEq9DokmC+1WBVg==
Date: Fri, 29 Aug 2025 16:24:33 +0800
To: <dev@dpdk.org>
From: "Renyong Wan" <wanry@yunsilicon.com>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+268b163c4+04356b+dpdk.org+wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
Subject: [PATCH 12/14] net/xsc: support per port for multi-process
Content-Type: text/plain; charset=UTF-8
References: <20250829082406.24369-1-wanry@yunsilicon.com>
Message-Id: <20250829082432.24369-13-wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 29 Aug 2025 16:24:33 +0800
In-Reply-To: <20250829082406.24369-1-wanry@yunsilicon.com>
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
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

Previously, the PCT manager was shared across all ports, which prevented
two ports from operating independently in separate DPDK processes. This
patch makes the PCT manager per-port, allowing each port to manage its
resources separately.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c    | 40 +++++++++++++++++++++--
 drivers/net/xsc/xsc_dev.h    |  4 +++
 drivers/net/xsc/xsc_ethdev.c |  2 +-
 drivers/net/xsc/xsc_np.c     | 61 +++++++++++++++++++++---------------
 drivers/net/xsc/xsc_np.h     | 10 +++---
 5 files changed, 83 insertions(+), 34 deletions(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 6b24ea98d0..b92bed3a40 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -324,7 +324,7 @@ void
 xsc_dev_uninit(struct xsc_dev *xdev)
 {
 	PMD_INIT_FUNC_TRACE();
-	xsc_dev_pct_uninit();
+	xsc_dev_pct_uninit(xdev);
 	xsc_dev_close(xdev, XSC_DEV_REPR_ID_INVALID);
 	rte_free(xdev);
 }
@@ -363,7 +363,11 @@ xsc_dev_init(struct rte_pci_device *pci_dev, struct xsc_dev **xdev)
 		goto hwinfo_init_fail;
 	}
 
-	ret = xsc_dev_pct_init();
+	ret = xsc_dev_mac_port_init(d);
+	if (ret)
+		goto hwinfo_init_fail;
+
+	ret = xsc_dev_pct_init(d);
 	if (ret) {
 		PMD_DRV_LOG(ERR, "Failed to init xsc pct");
 		ret = -EINVAL;
@@ -689,3 +693,35 @@ xsc_dev_fec_set(struct xsc_dev *xdev, uint32_t mode)
 
 	return 0;
 }
+
+int
+xsc_dev_mac_port_init(struct xsc_dev *xdev)
+{
+	uint32_t i;
+	uint8_t num = 0;
+	uint32_t mac_port = xdev->hwinfo.mac_phy_port;
+	uint8_t mac_bit = xdev->hwinfo.mac_bit;
+	uint8_t *mac_idx = &xdev->hwinfo.mac_port_idx;
+	uint8_t *mac_num = &xdev->hwinfo.mac_port_num;
+	uint8_t bit_sz = sizeof(mac_bit) * 8;
+
+	*mac_idx = 0xff;
+	for (i = 0; i < bit_sz; i++) {
+		if (mac_bit & (1U << i)) {
+			if (i == mac_port)
+				*mac_idx = num;
+			num++;
+		}
+	}
+	*mac_num = num;
+
+	if (*mac_num == 0 || *mac_idx == 0xff) {
+		PMD_DRV_LOG(ERR, "Failed to parse mac port %u index, mac bit 0x%x",
+			    mac_port, mac_bit);
+		return -1;
+	}
+
+	PMD_DRV_LOG(DEBUG, "Mac port num %u, mac port %u, mac index %u",
+		    *mac_num, mac_port, *mac_idx);
+	return 0;
+}
diff --git a/drivers/net/xsc/xsc_dev.h b/drivers/net/xsc/xsc_dev.h
index e058ffdc21..fc356375f1 100644
--- a/drivers/net/xsc/xsc_dev.h
+++ b/drivers/net/xsc/xsc_dev.h
@@ -124,6 +124,8 @@ struct xsc_hwinfo {
 	uint8_t pct_compress_vld;
 	uint8_t mac_bit;
 	uint8_t esw_mode;
+	uint8_t mac_port_idx;
+	uint8_t mac_port_num;
 	char fw_ver[XSC_FW_VERS_LEN];
 };
 
@@ -185,6 +187,7 @@ struct xsc_dev {
 	int ctrl_fd;
 	rte_intr_callback_fn intr_cb;
 	void *intr_cb_arg;
+	struct xsc_dev_pct_mgr pct_mgr;
 };
 
 struct xsc_module_eeprom_query_params {
@@ -278,5 +281,6 @@ int xsc_dev_intr_handler_install(struct xsc_dev *xdev, rte_intr_callback_fn cb,
 int xsc_dev_intr_handler_uninstall(struct xsc_dev *xdev);
 int xsc_dev_fec_get(struct xsc_dev *xdev, uint32_t *fec_capa);
 int xsc_dev_fec_set(struct xsc_dev *xdev, uint32_t mode);
+int xsc_dev_mac_port_init(struct xsc_dev *xdev);
 
 #endif /* _XSC_DEV_H_ */
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 70417b2d5b..6102c158e8 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -1091,7 +1091,7 @@ xsc_ethdev_uninit(struct rte_eth_dev *eth_dev)
 	}
 
 	ret |= xsc_ethdev_close(eth_dev);
-	xsc_dev_pct_uninit();
+	xsc_dev_pct_uninit(priv->xdev);
 	rte_free(priv->xdev);
 
 	return ret == 0 ? 0 : -EIO;
diff --git a/drivers/net/xsc/xsc_np.c b/drivers/net/xsc/xsc_np.c
index 2b85fd93f8..4f872daec1 100644
--- a/drivers/net/xsc/xsc_np.c
+++ b/drivers/net/xsc/xsc_np.c
@@ -15,10 +15,8 @@
 #define XSC_LOGIC_PORT_MASK		0x07FF
 
 #define XSC_DEV_DEF_PCT_IDX_MIN		128
-#define XSC_DEV_DEF_PCT_IDX_MAX		138
-
-/* Each board has a PCT manager*/
-static struct xsc_dev_pct_mgr xsc_pct_mgr;
+#define XSC_DEV_DEF_PCT_IDX_MAX		191
+#define XSC_DEV_DEF_PCT_NUM		(XSC_DEV_DEF_PCT_IDX_MAX - XSC_DEV_DEF_PCT_IDX_MIN + 1)
 
 enum xsc_np_type {
 	XSC_NP_IPAT		= 0,
@@ -207,13 +205,13 @@ xsc_dev_create_pct(struct xsc_dev *xdev, int repr_id,
 	add.key.logical_in_port = logical_in_port & XSC_LOGIC_PORT_MASK;
 	add.mask.logical_in_port = XSC_LOGIC_PORT_MASK;
 	add.action.dst_info = dst_info;
-	add.pct_idx = xsc_dev_pct_idx_alloc();
+	add.pct_idx = xsc_dev_pct_idx_alloc(xdev);
 	if (add.pct_idx == XSC_DEV_PCT_IDX_INVALID)
 		return -1;
 
 	ret = xsc_dev_np_exec(xdev, &add, sizeof(add), XSC_NP_PCT_V4, XSC_NP_OP_ADD);
 	if (unlikely(ret != 0)) {
-		xsc_dev_pct_idx_free(add.pct_idx);
+		xsc_dev_pct_idx_free(xdev, add.pct_idx);
 		return -1;
 	}
 
@@ -248,7 +246,7 @@ xsc_dev_clear_pct(struct xsc_dev *xdev, int repr_id)
 
 	while ((pct_entry = xsc_dev_pct_first_get(pct_list)) != NULL) {
 		xsc_dev_destroy_pct(xdev, pct_entry->logic_port, pct_entry->pct_idx);
-		xsc_dev_pct_entry_remove(pct_entry);
+		xsc_dev_pct_entry_remove(xdev, pct_entry);
 	}
 }
 
@@ -404,23 +402,23 @@ xsc_dev_create_vfos_baselp(struct xsc_dev *xdev)
 }
 
 void
-xsc_dev_pct_uninit(void)
+xsc_dev_pct_uninit(struct xsc_dev *xdev)
 {
-	rte_free(xsc_pct_mgr.bmp_mem);
-	xsc_pct_mgr.bmp_mem = NULL;
+	rte_free(xdev->pct_mgr.bmp_mem);
+	xdev->pct_mgr.bmp_mem = NULL;
 }
 
 int
-xsc_dev_pct_init(void)
+xsc_dev_pct_init(struct xsc_dev *xdev)
 {
 	int ret;
 	uint8_t *bmp_mem;
 	uint32_t pos, pct_sz, bmp_sz;
 
-	if (xsc_pct_mgr.bmp_mem != NULL)
+	if (xdev->pct_mgr.bmp_mem != NULL)
 		return 0;
 
-	pct_sz = XSC_DEV_DEF_PCT_IDX_MAX - XSC_DEV_DEF_PCT_IDX_MIN + 1;
+	pct_sz = XSC_DEV_DEF_PCT_NUM / xdev->hwinfo.mac_port_num;
 	bmp_sz = rte_bitmap_get_memory_footprint(pct_sz);
 	bmp_mem = rte_zmalloc(NULL, bmp_sz, RTE_CACHE_LINE_SIZE);
 	if (bmp_mem == NULL) {
@@ -429,9 +427,9 @@ xsc_dev_pct_init(void)
 		goto pct_init_fail;
 	}
 
-	xsc_pct_mgr.bmp_mem = bmp_mem;
-	xsc_pct_mgr.bmp_pct = rte_bitmap_init(pct_sz, bmp_mem, bmp_sz);
-	if (xsc_pct_mgr.bmp_pct == NULL) {
+	xdev->pct_mgr.bmp_mem = bmp_mem;
+	xdev->pct_mgr.bmp_pct = rte_bitmap_init(pct_sz, bmp_mem, bmp_sz);
+	if (xdev->pct_mgr.bmp_pct == NULL) {
 		PMD_DRV_LOG(ERR, "Failed to init pct bitmap");
 		ret = -EINVAL;
 		goto pct_init_fail;
@@ -439,27 +437,32 @@ xsc_dev_pct_init(void)
 
 	/* Mark all pct bitmap available */
 	for (pos = 0; pos < pct_sz; pos++)
-		rte_bitmap_set(xsc_pct_mgr.bmp_pct, pos);
+		rte_bitmap_set(xdev->pct_mgr.bmp_pct, pos);
 
 	return 0;
 
 pct_init_fail:
-	xsc_dev_pct_uninit();
+	xsc_dev_pct_uninit(xdev);
 	return ret;
 }
 
 uint32_t
-xsc_dev_pct_idx_alloc(void)
+xsc_dev_pct_idx_alloc(struct xsc_dev *xdev)
 {
 	int ret;
 	uint64_t slab = 0;
 	uint32_t pos = 0;
+	uint8_t mac_num = xdev->hwinfo.mac_port_num;
+	uint8_t mac_idx = xdev->hwinfo.mac_port_idx;
+	struct rte_bitmap *bmp_pct = xdev->pct_mgr.bmp_pct;
+	uint32_t pct_range = XSC_DEV_DEF_PCT_NUM / mac_num;
+	uint32_t pct_base = XSC_DEV_DEF_PCT_IDX_MIN + mac_idx * pct_range;
 
-	ret = rte_bitmap_scan(xsc_pct_mgr.bmp_pct, &pos, &slab);
+	ret = rte_bitmap_scan(bmp_pct, &pos, &slab);
 	if (ret != 0) {
 		pos += rte_bsf64(slab);
-		rte_bitmap_clear(xsc_pct_mgr.bmp_pct, pos);
-		return (pos + XSC_DEV_DEF_PCT_IDX_MIN);
+		rte_bitmap_clear(bmp_pct, pos);
+		return (pos + pct_base);
 	}
 
 	PMD_DRV_LOG(ERR, "Failed to alloc xsc pct idx");
@@ -467,9 +470,15 @@ xsc_dev_pct_idx_alloc(void)
 }
 
 void
-xsc_dev_pct_idx_free(uint32_t pct_idx)
+xsc_dev_pct_idx_free(struct xsc_dev *xdev, uint32_t pct_idx)
 {
-	rte_bitmap_set(xsc_pct_mgr.bmp_pct, pct_idx - XSC_DEV_DEF_PCT_IDX_MIN);
+	uint8_t mac_num = xdev->hwinfo.mac_port_num;
+	uint8_t mac_idx = xdev->hwinfo.mac_port_idx;
+	struct rte_bitmap *bmp_pct = xdev->pct_mgr.bmp_pct;
+	uint32_t pct_range = XSC_DEV_DEF_PCT_NUM / mac_num;
+	uint32_t pct_base = XSC_DEV_DEF_PCT_IDX_MIN + mac_idx * pct_range;
+
+	rte_bitmap_set(bmp_pct, pct_idx - pct_base);
 }
 
 int
@@ -501,12 +510,12 @@ xsc_dev_pct_first_get(struct xsc_dev_pct_list *pct_list)
 }
 
 int
-xsc_dev_pct_entry_remove(struct xsc_dev_pct_entry *pct_entry)
+xsc_dev_pct_entry_remove(struct xsc_dev *xdev, struct xsc_dev_pct_entry *pct_entry)
 {
 	if (pct_entry == NULL)
 		return -1;
 
-	xsc_dev_pct_idx_free(pct_entry->pct_idx);
+	xsc_dev_pct_idx_free(xdev, pct_entry->pct_idx);
 	LIST_REMOVE(pct_entry, next);
 	rte_free(pct_entry);
 
diff --git a/drivers/net/xsc/xsc_np.h b/drivers/net/xsc/xsc_np.h
index ca185c0a59..dadb24be46 100644
--- a/drivers/net/xsc/xsc_np.h
+++ b/drivers/net/xsc/xsc_np.h
@@ -148,13 +148,13 @@ int xsc_dev_modify_epat_mac_filter(struct xsc_dev *xdev, uint16_t dst_info,
 int xsc_dev_destroy_epat(struct xsc_dev *xdev, uint16_t dst_info);
 int xsc_dev_set_qpsetid(struct xsc_dev *xdev, uint32_t txqpn, uint16_t qp_set_id);
 int xsc_dev_create_vfos_baselp(struct xsc_dev *xdev);
-void xsc_dev_pct_uninit(void);
-int xsc_dev_pct_init(void);
-uint32_t xsc_dev_pct_idx_alloc(void);
-void xsc_dev_pct_idx_free(uint32_t pct_idx);
+void xsc_dev_pct_uninit(struct xsc_dev *xdev);
+int xsc_dev_pct_init(struct xsc_dev *xdev);
+uint32_t xsc_dev_pct_idx_alloc(struct xsc_dev *xdev);
+void xsc_dev_pct_idx_free(struct xsc_dev *xdev, uint32_t pct_idx);
 int xsc_dev_pct_entry_insert(struct xsc_dev_pct_list *pct_list,
 			     uint32_t logic_port, uint32_t pct_idx);
 struct xsc_dev_pct_entry *xsc_dev_pct_first_get(struct xsc_dev_pct_list *pct_list);
-int xsc_dev_pct_entry_remove(struct xsc_dev_pct_entry *pct_entry);
+int xsc_dev_pct_entry_remove(struct xsc_dev *xdev, struct xsc_dev_pct_entry *pct_entry);
 
 #endif /* _XSC_NP_H_ */
-- 
2.25.1
