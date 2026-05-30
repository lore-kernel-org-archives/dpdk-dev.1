Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98BECD6E4A
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 07:53:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9643840650;
	Sat, 30 May 2026 09:53:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 18ABA4028C
 for <dev@dpdk.org>; Sat, 30 May 2026 09:53:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780127582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/3gaorrcxFHEEdG24asts0/HxCJaZ5ojdFLqib517I=;
 b=ZqSeFq4Kwg1yX9r8UXQQ3OZyhlB+VuUKK/3kg8kdZIZPfVvb3cKyuB/1GbAwHukRPejvft
 CuSd9cq1S/Dgu2UTqcpVPnQluawyjvXbLchg4LN/ld0nJLNPEeZQXdtrrhvwkLXu3VRCHg
 4L1f9sCNcXCowKkH4oHkq+dQ7XkMp20=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-288-Db76fl1RMYm881npk5nrWQ-1; Sat,
 30 May 2026 03:52:57 -0400
X-MC-Unique: Db76fl1RMYm881npk5nrWQ-1
X-Mimecast-MFC-AGG-ID: Db76fl1RMYm881npk5nrWQ_1780127573
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D76B7180035D; Sat, 30 May 2026 07:52:52 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E4D619560A3; Sat, 30 May 2026 07:52:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Parav Pandit <parav@nvidia.com>,
 Xueming Li <xuemingl@nvidia.com>, Rosen Xu <rosen.xu@altera.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v5 07/25] drivers/bus: remove device and driver checks in plug
Date: Sat, 30 May 2026 09:51:37 +0200
Message-ID: <20260530075201.869606-8-david.marchand@redhat.com>
In-Reply-To: <20260530075201.869606-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
 <20260530075201.869606-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Bm0sjd_S_fCN4_cp9eqaJjG485VKJEtpbAH6C1R-7kY_1780127573
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

The bus-specific device conversion macros all use container_of()
to convert from a generic rte_device pointer to a bus-specific
device structure.

A key property of container_of() is that it does NOT return NULL when
given a NULL pointer as input. Instead, it returns (NULL - offset),
which is a small non-NULL pointer value. This means NULL checks on
container_of() results cannot work as intended.

The device parameter passed to bus probe or plug operations cannot be NULL
as the caller already dereferenced the bus structure to invoke these
operations. Remove redundant NULL checks on the device parameter and
derived device pointers.

The driver reference in the bus-specific device cannot be NULL since
calling the .plug op is done after dereferencing this pointer.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 6 ------
 drivers/bus/ifpga/ifpga_bus.c            | 3 ---
 drivers/bus/platform/platform.c          | 8 +-------
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 1fe0cb4d78..314361643c 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -81,9 +81,6 @@ rte_auxiliary_probe_one_driver(struct rte_auxiliary_driver *drv,
 	enum rte_iova_mode iova_mode;
 	int ret;
 
-	if (drv == NULL || dev == NULL)
-		return -EINVAL;
-
 	/* Check if driver supports it. */
 	if (!auxiliary_match(drv, dev))
 		/* Match of device and driver failed */
@@ -174,9 +171,6 @@ auxiliary_probe_all_drivers(struct rte_auxiliary_device *dev)
 	struct rte_auxiliary_driver *drv;
 	int rc;
 
-	if (dev == NULL)
-		return -EINVAL;
-
 	FOREACH_DRIVER_ON_AUXILIARY_BUS(drv) {
 		if (!drv->match(dev->name))
 			continue;
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index fc5308b6f4..0f331fa6dd 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -302,9 +302,6 @@ ifpga_probe_all_drivers(struct rte_afu_device *afu_dev)
 	struct rte_afu_driver *drv = NULL;
 	int ret = 0;
 
-	if (afu_dev == NULL)
-		return -1;
-
 	/* Check if a driver is already loaded */
 	if (rte_dev_is_probed(&afu_dev->device)) {
 		IFPGA_BUS_DEBUG("Device %s is already probed",
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 0345f1daf7..5cc0d69209 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -458,19 +458,13 @@ platform_bus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp, cons
 static int
 platform_bus_plug(struct rte_device *dev)
 {
-	struct rte_platform_device *pdev;
-
 	if (rte_bus_device_is_ignored(&platform_bus.bus, dev->name))
 		return -EPERM;
 
 	if (!dev_is_bound_vfio_platform(dev->name))
 		return -EPERM;
 
-	pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
-	if (pdev == NULL)
-		return -EINVAL;
-
-	return device_attach(pdev);
+	return device_attach(RTE_DEV_TO_PLATFORM_DEV(dev));
 }
 
 static void
-- 
2.53.0

