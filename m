Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D28CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:41:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39D0340B95;
	Wed, 14 Oct 2026 19:41:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 97A1B40E01
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:41:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791999666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SCLqS8Vi/vY20H3FnZ93FskANgZ2R0TItZmiJFZIKGQ=;
 b=E63/U7EE0b+KmCpH6vnm0B8EvRoxDpBhl/p5HFczjxK9bPwmVhKFo5Z+uA4LMFYmWm45Jz
 m2L1WzTzyM3bcCHi7x5zPg2FW1R27JCchRG7hK/CfFIrVWyS8+eBAlvlLVeem+R6vOTisL
 kXS6p/f6bF57wtwxrPbWGV991JGh2vY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-TBmG26ejM12sCYJRQl6XCg-1; Wed,
 14 Oct 2026 17:41:02 +0000
X-MC-Unique: TBmG26ejM12sCYJRQl6XCg-1
X-Mimecast-MFC-AGG-ID: TBmG26ejM12sCYJRQl6XCg_1791999661
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 847841955DD7; Wed, 14 Oct 2026 17:41:01 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8728D195608D; Wed, 14 Oct 2026 17:41:00 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 16/16] bus/fslmc: use generic cleanup
Date: Wed, 14 Oct 2026 19:39:59 +0200
Message-ID: <20261014174001.1830726-17-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z-CSsH-lhNWYn-X6kVJj0FR4q8fyDSViacVhfs-OZfY_1791999661
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
 drivers/bus/fslmc/fslmc_bus.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 962b4efac4..84c4f47e36 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -628,23 +628,25 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
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
 
@@ -766,7 +768,8 @@ fslmc_bus_unplug_device(struct rte_device *rte_dev)
 struct rte_bus rte_fslmc_bus = {
 	.scan = rte_fslmc_scan,
 	.probe = rte_fslmc_probe,
-	.cleanup = rte_fslmc_close,
+	.free_device = fslmc_free_device,
+	.cleanup = fslmc_cleanup,
 	.parse = rte_fslmc_parse,
 	.dev_compare = fslmc_dev_compare,
 	.find_device = rte_bus_generic_find_device,
-- 
2.54.0

