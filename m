Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126EB606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LQZ5th/b
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE65B40A82;
	Mon, 26 Oct 2026 19:11:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id E4D0E4067A
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:11:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISY1fiRhgOhmV85mL0pzY0CkpaogQkYe16y5ro1rcOc=;
 b=LQZ5th/bluJoEOsG40A1hJZfege6BdYDA6vWLd3G6b5nwgs+QnM6SfMtJn1na2FVt3KGXT
 TA6iGvf6wovZvkDS77ek4a4K65PoQfWhQ2u/lskAEn0g6WP1+ElPKsgONmPm2BRhw7Nhvj
 RXwHmv7uKNlOhgVtpkZ/e3X1rlGjZGs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-mu7QQJ7iOTWuQKcrBHuOJg-1; Mon,
 26 Oct 2026 14:11:18 -0400
X-MC-Unique: mu7QQJ7iOTWuQKcrBHuOJg-1
X-Mimecast-MFC-AGG-ID: mu7QQJ7iOTWuQKcrBHuOJg_1793038277
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F2311955F0D; Mon, 26 Oct 2026 18:11:17 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 970E130000E7; Mon, 26 Oct 2026 18:11:16 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 13/16] bus/fslmc: move unplug for some device out of VFIO
Date: Mon, 26 Oct 2026 19:10:27 +0100
Message-ID: <20261026181031.304100-14-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bPnwJVI9fO337zmg2tMyrt0ZL8Cy7dszNtJEoRsXSh4_1793038277
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

