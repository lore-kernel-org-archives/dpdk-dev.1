Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B17C02196
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 08:33:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAB81427CB;
	Fri,  7 Feb 2025 09:33:19 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id B2AFF427C9
 for <dev@dpdk.org>; Fri,  7 Feb 2025 09:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738917198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o03yEeznxmqnVcNpfukGCaghzNONrW1lwmKXBf18xog=;
 b=GLtnRs1N7W25GvLUiZRrryOOwruYIUNp5w+R042hw3PiiMrbCrtkOzPag2CYdO1uavagmy
 DNU4GJRWAWpshncXGngZVp9QNrHx5ze0KWzNl4DdGOJN1Tn//rGf2eIgF41iN7/4LiAkLi
 7bwE3MmFjbFXYNbJIC+ErwoTasV+1n4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-W57OD9v8P_KHPxoL4PiIig-1; Fri,
 07 Feb 2025 03:33:15 -0500
X-MC-Unique: W57OD9v8P_KHPxoL4PiIig-1
X-Mimecast-MFC-AGG-ID: W57OD9v8P_KHPxoL4PiIig
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8DA5195608E; Fri,  7 Feb 2025 08:33:12 +0000 (UTC)
Received: from dmarchan.com (unknown [10.45.224.27])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3FDE01800358; Fri,  7 Feb 2025 08:33:09 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andremue@linux.microsoft.com,
 Nagadheeraj Rottela <rnagadheeraj@marvell.com>,
 Srikanth Jampala <jsrikanth@marvell.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashish.gupta@marvell.com>
Subject: [RFC 03/10] drivers: remove weak symbols in Nitrox drivers
Date: Fri,  7 Feb 2025 09:32:43 +0100
Message-ID: <20250207083252.3131588-4-david.marchand@redhat.com>
In-Reply-To: <20250207083252.3131588-1-david.marchand@redhat.com>
References: <20250207083252.3131588-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Nx2zNbqRVeOulyTHe7wwEnYq7HUAEvLinLaF2_4Fw7Q_1738917193
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Make compress and crypto drivers register to the common driver.
Remove (unneeded) include_directories().

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/common/nitrox/meson.build     |  3 --
 drivers/common/nitrox/nitrox_device.c | 75 ++++++++++-----------------
 drivers/common/nitrox/nitrox_device.h | 16 ++++++
 drivers/common/nitrox/version.map     |  1 +
 drivers/compress/nitrox/meson.build   |  2 -
 drivers/compress/nitrox/nitrox_comp.c |  6 +++
 drivers/crypto/nitrox/meson.build     |  2 -
 drivers/crypto/nitrox/nitrox_sym.c    |  6 +++
 8 files changed, 57 insertions(+), 54 deletions(-)

diff --git a/drivers/common/nitrox/meson.build b/drivers/common/nitrox/meson.build
index f3cb42f006..115dd8de4d 100644
--- a/drivers/common/nitrox/meson.build
+++ b/drivers/common/nitrox/meson.build
@@ -14,6 +14,3 @@ sources += files(
         'nitrox_logs.c',
         'nitrox_qp.c',
 )
-
-includes += include_directories('../../crypto/nitrox')
-includes += include_directories('../../compress/nitrox')
diff --git a/drivers/common/nitrox/nitrox_device.c b/drivers/common/nitrox/nitrox_device.c
index 39edc440a7..6cd57faaa4 100644
--- a/drivers/common/nitrox/nitrox_device.c
+++ b/drivers/common/nitrox/nitrox_device.c
@@ -6,8 +6,6 @@
 
 #include "nitrox_device.h"
 #include "nitrox_hal.h"
-#include "nitrox_sym.h"
-#include "nitrox_comp.h"
 
 #define PCI_VENDOR_ID_CAVIUM	0x177d
 #define NITROX_V_PCI_VF_DEV_ID	0x13
@@ -63,11 +61,21 @@ ndev_release(struct nitrox_device *ndev)
 	rte_free(ndev);
 }
 
+TAILQ_HEAD(ndrv_list, nitrox_driver);
+static struct ndrv_list ndrv_list = TAILQ_HEAD_INITIALIZER(ndrv_list);
+
+void
+nitrox_register_driver(struct nitrox_driver *ndrv)
+{
+	TAILQ_INSERT_TAIL(&ndrv_list, ndrv, next);
+}
+
 static int
 nitrox_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		struct rte_pci_device *pdev)
 {
 	struct nitrox_device *ndev;
+	struct nitrox_driver *ndrv;
 	int err = -1;
 
 	/* Nitrox CSR space */
@@ -79,19 +87,21 @@ nitrox_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 		return -ENOMEM;
 
 	ndev_init(ndev, pdev);
-	err = nitrox_sym_pmd_create(ndev);
-	if (err)
-		goto sym_pmd_err;
-
-	err = nitrox_comp_pmd_create(ndev);
-	if (err)
-		goto comp_pmd_err;
+	TAILQ_FOREACH(ndrv, &ndrv_list, next) {
+		err = ndrv->create(ndev);
+		if (err)
+			goto drv_err;
+	}
 
 	return 0;
 
-comp_pmd_err:
-	nitrox_sym_pmd_destroy(ndev);
-sym_pmd_err:
+drv_err:
+	ndrv = TAILQ_PREV(ndrv, ndrv_list, next);
+	while (ndrv != NULL) {
+		ndrv->destroy(ndev);
+		ndrv = TAILQ_PREV(ndrv, ndrv_list, next);
+	}
+
 	ndev_release(ndev);
 	return err;
 }
@@ -100,19 +110,18 @@ static int
 nitrox_pci_remove(struct rte_pci_device *pdev)
 {
 	struct nitrox_device *ndev;
+	struct nitrox_driver *ndrv;
 	int err;
 
 	ndev = find_ndev(pdev);
 	if (!ndev)
 		return -ENODEV;
 
-	err = nitrox_sym_pmd_destroy(ndev);
-	if (err)
-		return err;
-
-	err = nitrox_comp_pmd_destroy(ndev);
-	if (err)
-		return err;
+	TAILQ_FOREACH(ndrv, &ndrv_list, next) {
+		err = ndrv->destroy(ndev);
+		if (err)
+			return err;
+	}
 
 	ndev_release(ndev);
 	return 0;
@@ -133,33 +142,5 @@ static struct rte_pci_driver nitrox_pmd = {
 	.remove         = nitrox_pci_remove,
 };
 
-__rte_weak int
-nitrox_sym_pmd_create(struct nitrox_device *ndev)
-{
-	RTE_SET_USED(ndev);
-	return 0;
-}
-
-__rte_weak int
-nitrox_sym_pmd_destroy(struct nitrox_device *ndev)
-{
-	RTE_SET_USED(ndev);
-	return 0;
-}
-
-__rte_weak int
-nitrox_comp_pmd_create(struct nitrox_device *ndev)
-{
-	RTE_SET_USED(ndev);
-	return 0;
-}
-
-__rte_weak int
-nitrox_comp_pmd_destroy(struct nitrox_device *ndev)
-{
-	RTE_SET_USED(ndev);
-	return 0;
-}
-
 RTE_PMD_REGISTER_PCI(nitrox, nitrox_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(nitrox, pci_id_nitrox_map);
diff --git a/drivers/common/nitrox/nitrox_device.h b/drivers/common/nitrox/nitrox_device.h
index 877bccb321..b74b71808e 100644
--- a/drivers/common/nitrox/nitrox_device.h
+++ b/drivers/common/nitrox/nitrox_device.h
@@ -6,6 +6,7 @@
 #define _NITROX_DEVICE_H_
 
 #include <bus_pci_driver.h>
+#include <rte_compat.h>
 
 struct nitrox_sym_device;
 struct nitrox_comp_device;
@@ -21,4 +22,19 @@ struct nitrox_device {
 	uint16_t nr_queues;
 };
 
+struct nitrox_driver {
+	TAILQ_ENTRY(nitrox_driver) next;
+	int (*create)(struct nitrox_device *ndev);
+	int (*destroy)(struct nitrox_device *ndev);
+};
+
+__rte_internal
+void nitrox_register_driver(struct nitrox_driver *ndrv);
+
+#define NITROX_REGISTER_DRIVER(ndrv) \
+RTE_INIT(ndrv ## _register) \
+{ \
+	nitrox_register_driver(&ndrv); \
+}
+
 #endif /* _NITROX_DEVICE_H_ */
diff --git a/drivers/common/nitrox/version.map b/drivers/common/nitrox/version.map
index 43295171e4..f58c044fc5 100644
--- a/drivers/common/nitrox/version.map
+++ b/drivers/common/nitrox/version.map
@@ -4,6 +4,7 @@ INTERNAL {
 	nitrox_logtype;
 	nitrox_qp_release;
 	nitrox_qp_setup;
+	nitrox_register_driver;
 
 	local: *;
 };
diff --git a/drivers/compress/nitrox/meson.build b/drivers/compress/nitrox/meson.build
index 1becc66912..5cecc2ad66 100644
--- a/drivers/compress/nitrox/meson.build
+++ b/drivers/compress/nitrox/meson.build
@@ -12,5 +12,3 @@ sources += files(
         'nitrox_comp.c',
         'nitrox_comp_reqmgr.c',
 )
-
-includes += include_directories('../../common/nitrox')
diff --git a/drivers/compress/nitrox/nitrox_comp.c b/drivers/compress/nitrox/nitrox_comp.c
index 1b2054c61a..41a3ee0de8 100644
--- a/drivers/compress/nitrox/nitrox_comp.c
+++ b/drivers/compress/nitrox/nitrox_comp.c
@@ -602,3 +602,9 @@ nitrox_comp_pmd_destroy(struct nitrox_device *ndev)
 	ndev->comp_dev = NULL;
 	return 0;
 }
+
+static struct nitrox_driver comp_drv = {
+	.create = nitrox_comp_pmd_create,
+	.destroy = nitrox_comp_pmd_destroy,
+};
+NITROX_REGISTER_DRIVER(comp_drv);
diff --git a/drivers/crypto/nitrox/meson.build b/drivers/crypto/nitrox/meson.build
index f8887713d2..cbe2b7d6dc 100644
--- a/drivers/crypto/nitrox/meson.build
+++ b/drivers/crypto/nitrox/meson.build
@@ -13,5 +13,3 @@ sources += files(
         'nitrox_sym_capabilities.c',
         'nitrox_sym_reqmgr.c',
 )
-
-includes += include_directories('../../common/nitrox')
diff --git a/drivers/crypto/nitrox/nitrox_sym.c b/drivers/crypto/nitrox/nitrox_sym.c
index da70121d91..7c2dc98a4b 100644
--- a/drivers/crypto/nitrox/nitrox_sym.c
+++ b/drivers/crypto/nitrox/nitrox_sym.c
@@ -798,6 +798,12 @@ nitrox_sym_pmd_destroy(struct nitrox_device *ndev)
 	return rte_cryptodev_pmd_destroy(ndev->sym_dev->cdev);
 }
 
+static struct nitrox_driver sym_drv = {
+	.create = nitrox_sym_pmd_create,
+	.destroy = nitrox_sym_pmd_destroy,
+};
+NITROX_REGISTER_DRIVER(sym_drv);
+
 static struct cryptodev_driver nitrox_crypto_drv;
 RTE_PMD_REGISTER_CRYPTO_DRIVER(nitrox_crypto_drv,
 		nitrox_rte_sym_drv,
-- 
2.48.1

