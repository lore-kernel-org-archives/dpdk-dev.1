Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3576CCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:41:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 25F4440A79;
	Wed, 14 Oct 2026 19:40:56 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0D8A44068E
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:40:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791999653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISY1fiRhgOhmV85mL0pzY0CkpaogQkYe16y5ro1rcOc=;
 b=gl3T4KH2ZZ4TptXzPkEVvK7lX52sc3kSbyrWRHRyi5NNH54Mb4+Q1S4vY5Tj2uxvU7U1XY
 Dec212QUD6jTaM/HtOCMlZJmiMf3FdHxzs3tsa9o4tmXwrnylLhdB5aKWj6YK3uJJXo31K
 2OSg9Qsxdpcw9DUgEGVTBbVogmr2f40=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-wkm1AZ0ANni4esyp7R-UFw-1; Wed,
 14 Oct 2026 17:40:52 +0000
X-MC-Unique: wkm1AZ0ANni4esyp7R-UFw-1
X-Mimecast-MFC-AGG-ID: wkm1AZ0ANni4esyp7R-UFw_1791999651
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A4981800BEB; Wed, 14 Oct 2026 17:40:51 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4E6487C6; Wed, 14 Oct 2026 17:40:50 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 13/16] bus/fslmc: move unplug for some device out of VFIO
Date: Wed, 14 Oct 2026 19:39:56 +0200
Message-ID: <20261014174001.1830726-14-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2IMvjek-fdXXEgseUW2VSvn81Do4QQit1GJwzGKxx3o_1791999651
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

Move device unplug out of the code dealing with VFIO, interrupts and
IO devices.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- simplified the loop over devices since only devices for ethdev, dma or
  crypto are in the bus device list,

---
 drivers/bus/fslmc/fslmc_bus.c  | 11 ++++++++++-
 drivers/bus/fslmc/fslmc_vfio.c | 13 -------------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 41c4fd4d17..54a74dc889 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -642,10 +642,19 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 }
 
 static int
-rte_fslmc_close(struct rte_bus *bus __rte_unused)
+fslmc_bus_unplug_device(struct rte_device *rte_dev);
+
+static int
+rte_fslmc_close(struct rte_bus *bus)
 {
+	struct rte_dpaa2_device *dev;
 	int ret = 0;
 
+	RTE_BUS_FOREACH_DEV(dev, bus) {
+		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
+			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
+	}
+
 	ret = fslmc_vfio_close_group();
 	if (ret)
 		DPAA2_BUS_INFO("Unable to close devices %d", ret);
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index e45a909441..b09e08854a 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1460,7 +1460,6 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 	int vfio_fd)
 {
 	struct rte_dpaa2_object *object = NULL;
-	const struct rte_dpaa2_driver *drv;
 	int ret;
 
 	switch (dev->dev_type) {
@@ -1476,15 +1475,6 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 				continue;
 		}
 		break;
-	case DPAA2_ETH:
-	case DPAA2_CRYPTO:
-	case DPAA2_QDMA:
-		if (dev->device.driver != NULL) {
-			drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
-			if (drv->remove && drv->remove(dev))
-				DPAA2_BUS_ERR("Unable to remove");
-		}
-		break;
 	default:
 		break;
 	}
@@ -1628,9 +1618,6 @@ fslmc_vfio_close_group(void)
 		fslmc_close_iodevices(dev, vfio_group_fd);
 	}
 
-	RTE_BUS_FOREACH_DEV(dev, &rte_fslmc_bus)
-		fslmc_close_iodevices(dev, vfio_group_fd);
-
 	fslmc_vfio_clear_group(vfio_group_fd);
 
 	return 0;
-- 
2.54.0

