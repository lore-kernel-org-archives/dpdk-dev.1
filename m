Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35C8C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 10:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7F32402E7;
	Fri, 18 Apr 2025 12:34:48 +0200 (CEST)
Received: from lf-2-34.ptr.blmpb.com (lf-2-34.ptr.blmpb.com [101.36.218.34])
 by mails.dpdk.org (Postfix) with ESMTP id 9668D400D6
 for <dev@dpdk.org>; Fri, 18 Apr 2025 12:34:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744972481; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ne/uMtY6ibjkCuuwVKWfMUtfguedRKZWTXbHljbabnY=;
 b=DJVc3ukpc79u45E8qyBiSWYr8u2n0m7s0AMO4nnOZO+61/QyesmlOjHZzvyPJFSALSCb5C
 z1A0QdzjCI22l7GdXRzKSWoarJAqpZlBPkYW5CrLf961j+jljt0xR1CGwk0yIihVaGPAXn
 HoRfnmeuPhj1qr5psLIBtNXdud4buAw0FHXN5fc4rLaMwJ7Wbwgwx77Bag0fVpbRy5Fe0H
 GKvvPgOdO3NnyTfDoOZgSxh8yCGHqx4hdfajHFrOziSKzIZNXQeJnGzMC8KBxz9dDBdVu5
 fldzwSqux71sGClYoYAQwwYxESRUEtNyH0iqRjymMykbthlPdbOujk1i0l5L8Q==
From: "Renyong Wan" <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
References: <20250418103434.2489377-1-wanry@yunsilicon.com>
X-Lms-Return-Path: <lba+268022abf+54edf0+dpdk.org+wanry@yunsilicon.com>
Subject: [PATCH 2/2] net/xsc: optimize release path
Date: Fri, 18 Apr 2025 18:34:38 +0800
Message-Id: <20250418103437.2489377-3-wanry@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Fri, 18 Apr 2025 18:34:38 +0800
In-Reply-To: <20250418103434.2489377-1-wanry@yunsilicon.com>
Content-Transfer-Encoding: 7bit
To: <dev@dpdk.org>
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>, 
 <zhenghy@yunsilicon.com>
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

Optimized the code of release path to prevent potential resource leaks.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_dev.c    |  5 ++++-
 drivers/net/xsc/xsc_ethdev.c | 12 ++++++++++--
 drivers/net/xsc/xsc_np.c     |  1 +
 drivers/net/xsc/xsc_vfio.c   |  1 +
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/xsc/xsc_dev.c b/drivers/net/xsc/xsc_dev.c
index 1e3dd493f9..fc9f1cddfc 100644
--- a/drivers/net/xsc/xsc_dev.c
+++ b/drivers/net/xsc/xsc_dev.c
@@ -150,7 +150,10 @@ int
 xsc_dev_close(struct xsc_dev *xdev, int repr_id)
 {
 	xsc_dev_clear_pct(xdev, repr_id);
-	return xdev->dev_ops->dev_close(xdev);
+
+	if (repr_id == xdev->num_repr_ports - 1)
+		return xdev->dev_ops->dev_close(xdev);
+	return 0;
 }
 
 int
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 28af9c5d15..3830c18c03 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -860,13 +860,21 @@ xsc_ethdev_init(struct rte_eth_dev *eth_dev)
 static int
 xsc_ethdev_uninit(struct rte_eth_dev *eth_dev)
 {
+	int ret = 0;
+	uint16_t port_id;
 	struct xsc_ethdev_priv *priv = TO_XSC_ETHDEV_PRIV(eth_dev);
 
 	PMD_INIT_FUNC_TRACE();
+	RTE_ETH_FOREACH_DEV_OF(port_id, eth_dev->device) {
+		if (port_id != eth_dev->data->port_id)
+			ret |= rte_eth_dev_close(port_id);
+	}
 
-	xsc_dev_uninit(priv->xdev);
+	ret |= xsc_ethdev_close(eth_dev);
+	xsc_dev_pct_uninit();
+	rte_free(priv->xdev);
 
-	return 0;
+	return ret == 0 ? 0 : -EIO;
 }
 
 static int
diff --git a/drivers/net/xsc/xsc_np.c b/drivers/net/xsc/xsc_np.c
index f96797b7a4..543e6dba95 100644
--- a/drivers/net/xsc/xsc_np.c
+++ b/drivers/net/xsc/xsc_np.c
@@ -383,6 +383,7 @@ void
 xsc_dev_pct_uninit(void)
 {
 	rte_free(xsc_pct_mgr.bmp_mem);
+	xsc_pct_mgr.bmp_mem = NULL;
 }
 
 int
diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index 8330483523..422d30efb9 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -178,6 +178,7 @@ xsc_vfio_dev_close(struct xsc_dev *xdev)
 	struct xsc_vfio_priv *vfio_priv = (struct xsc_vfio_priv *)xdev->dev_priv;
 
 	xsc_vfio_mbox_destroy(vfio_priv->cmdq);
+	rte_pci_unmap_device(xdev->pci_dev);
 	rte_free(vfio_priv);
 
 	return 0;
-- 
2.25.1
