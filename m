Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29CAC982C1
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:51:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F12AD42E45;
	Thu, 17 Sep 2026 09:50:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 5E5FB400D5
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:50:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DY1JQHwLLLoJJTYrLL2x+HNz4PBi7oOtFM0nWoNTe+E=;
 b=Xuwn1sx6Iamb0hfhYVKCUShLy/0MHthp0RDMiKWYy0opE5dSmVpEg1L0YRdjfuam8rqtOT
 nIGRVnYi4gRaQgN9KXOcxdA/k+gjhpE8wDS8KGZN6cibw0LWo+KEm9iRi98GKxQOnHU/90
 p7BVRZWtCyTh/C3e0w2e8IMPlkQnb+Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-H_l5dPoFNuyj-dD99SWT-Q-1; Thu,
 17 Sep 2026 03:50:23 -0400
X-MC-Unique: H_l5dPoFNuyj-dD99SWT-Q-1
X-Mimecast-MFC-AGG-ID: H_l5dPoFNuyj-dD99SWT-Q_1789631422
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 23FDA1800598; Thu, 17 Sep 2026 07:50:22 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2A6BD214; Thu, 17 Sep 2026 07:50:20 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 16/16] bus/fslmc: use generic cleanup
Date: Thu, 17 Sep 2026 09:49:16 +0200
Message-ID: <20260917074917.595603-17-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qadEbWQXV6u0jw9Hy-3Ma1FOfkbSpXbSpZ51Ts-DWV0_1789631422
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

Now that the probe and unplug callback behave like other buses, we can
call generic cleanup in addition to the special handling for IO devices.

Also cleanup any object left in the control devices list.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- added a debug log on cleanup failure,

---
 drivers/bus/fslmc/fslmc_bus.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 909edb9124..361a123802 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -606,23 +606,25 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 }
 
 static int
-fslmc_bus_unplug_device(struct rte_device *rte_dev);
-
-static int
-rte_fslmc_close(struct rte_bus *bus)
+fslmc_cleanup(struct rte_bus *bus)
 {
-	struct rte_dpaa2_device *dev;
-	int ret = 0;
+	int ret;
 
-	RTE_BUS_FOREACH_DEV(dev, bus) {
-		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
-			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
-	}
+	ret = rte_bus_generic_cleanup(bus);
+	if (ret)
+		DPAA2_BUS_INFO("Unable to cleanup devices %d", ret);
 
 	ret = fslmc_vfio_close_group();
 	if (ret)
 		DPAA2_BUS_INFO("Unable to close devices %d", ret);
 
+	while (!TAILQ_EMPTY(&fslmc_control_devices)) {
+		struct rte_device *rte_dev = TAILQ_FIRST(&fslmc_control_devices);
+		struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
+
+		fslmc_remove_control_device(dev);
+	}
+
 	return 0;
 }
 
@@ -743,7 +745,8 @@ fslmc_bus_unplug_device(struct rte_device *rte_dev)
 struct rte_bus rte_fslmc_bus = {
 	.scan = rte_fslmc_scan,
 	.probe = rte_bus_generic_probe,
-	.cleanup = rte_fslmc_close,
+	.free_device = fslmc_free_device,
+	.cleanup = fslmc_cleanup,
 	.parse = rte_fslmc_parse,
 	.dev_compare = fslmc_dev_compare,
 	.find_device = rte_bus_generic_find_device,
-- 
2.54.0

