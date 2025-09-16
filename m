Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F025CAC598
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Sep 2025 10:09:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A566A40277;
	Tue, 16 Sep 2025 12:09:02 +0200 (CEST)
Received: from lf-1-14.ptr.blmpb.com (lf-1-14.ptr.blmpb.com [103.149.242.14])
 by mails.dpdk.org (Postfix) with ESMTP id 40BF640261
 for <dev@dpdk.org>; Tue, 16 Sep 2025 12:08:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1758017334; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JCRImEOfNMfS8ua3zLBzZUm+R0gr7dissT5mkBd2OMo=;
 b=McEHAenWrEWHOgLzadDLBWRzrziH++cbUOt02GW8MN9/IBn+d+3QyI2QdlmUsscR/CWVsC
 ToOzw+CIxyOJrm1n1WUYCnt5Dr8VSWZ4ZZenGdLcT376hxCYbHrn5HwmrgkTq/0Oaha5nT
 o0/tK22eO6iH/lXQusfsYDut/URuwkFNrlxKM4odXIPUcuV0l72z2NVvag6UhAsGCYG1Jg
 RY9xdGKzfHctDpYnNbxwFULK88Ry5sbc1mPuwBh2IGYOtLWqg4WBDvv9uUcX6ZNmg3lrba
 uCRae1UtUtgGku9oueJKZbFwx2qmprJ4e5tEcwo47spl15QKqLS7+5OBhf2h/Q==
X-Original-From: Renyong Wan <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
To: <dev@dpdk.org>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn
 with ESMTPS; Tue, 16 Sep 2025 18:08:51 +0800
Cc: <thomas@monjalon.net>, <stephen@networkplumber.org>, 
 <qianr@yunsilicon.com>, <nana@yunsilicon.com>, <zhangxx@yunsilicon.com>, 
 <xudw@yunsilicon.com>, <jacky@yunsilicon.com>, <weihg@yunsilicon.com>
Date: Tue, 16 Sep 2025 18:08:51 +0800
Message-Id: <20250916100850.226649-2-wanry@yunsilicon.com>
In-Reply-To: <20250916100850.226649-1-wanry@yunsilicon.com>
From: "Renyong Wan" <wanry@yunsilicon.com>
Subject: [PATCH 1/2] net/xsc: improve interrupt uninstall
X-Lms-Return-Path: <lba+268c93734+c6c398+dpdk.org+wanry@yunsilicon.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
References: <20250916100850.226649-1-wanry@yunsilicon.com>
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

Use synchronous callback unregister to ensure no callbacks
are running after interrupt uninstallation. This improves
stability and prevents potential use-after-free issues during
device teardown.

Signed-off-by: Rong Qian <qianr@yunsilicon.com>
Signed-off-by: Renyong Wan <wanry@yunsilicon.com>
---
 drivers/net/xsc/xsc_vfio.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/xsc/xsc_vfio.c b/drivers/net/xsc/xsc_vfio.c
index c233728c5f..cda21aa3f4 100644
--- a/drivers/net/xsc/xsc_vfio.c
+++ b/drivers/net/xsc/xsc_vfio.c
@@ -1113,11 +1113,11 @@ xsc_vfio_intr_handler_install(struct xsc_dev *xdev, rte_intr_callback_fn cb, voi
 static int
 xsc_vfio_intr_handler_uninstall(struct xsc_dev *xdev)
 {
-	if (rte_intr_fd_get(xdev->pci_dev->intr_handle) >= 0)
-		rte_intr_callback_unregister(xdev->pci_dev->intr_handle,
-					     xdev->intr_cb, xdev->intr_cb_arg);
-
-	rte_intr_instance_free(xdev->intr_handle);
+	if (rte_intr_fd_get(xdev->pci_dev->intr_handle) >= 0) {
+		rte_intr_disable(xdev->pci_dev->intr_handle);
+		rte_intr_callback_unregister_sync(xdev->pci_dev->intr_handle,
+						  xdev->intr_cb, xdev->intr_cb_arg);
+	}
 
 	return 0;
 }
-- 
2.25.1
