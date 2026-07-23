Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC51C531D1
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:55:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB1224068E;
	Thu, 23 Jul 2026 15:54:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1C51D4067D
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLoG5v56dUPPdivLsSyrmVqstZGUnpxjkpFsAVftJFs=;
 b=Jsha1QpP8OlaMYxp5Ql+yaltzCAk4L/kXEQf/dx869X3x6aDk9aVjOz3Q6YCgIyns6kX7+
 ha0dwCImbq9mX3AA5MUUPSP/XBvtX20WR4lGcJ4mYFXUktD5C+T0sTb28Bfj7+oRjhTZxE
 Zt+t4cK/Z05VTpoPZ7dAH1xIa6RlFnA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-wVo_n88iPO2sPejAaH6svg-1; Thu,
 23 Jul 2026 09:54:43 -0400
X-MC-Unique: wVo_n88iPO2sPejAaH6svg-1
X-Mimecast-MFC-AGG-ID: wVo_n88iPO2sPejAaH6svg_1784814881
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BF691800848; Thu, 23 Jul 2026 13:54:41 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31EAD1956053; Thu, 23 Jul 2026 13:54:39 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 08/11] bus/fslmc: move unplug for some device out of VFIO
Date: Thu, 23 Jul 2026 15:53:56 +0200
Message-ID: <20260723135400.3621271-9-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2dLF96oRrWnAjzW7NFBd5WNLF8AkoBXhm0OiEsTBP_A_1784814881
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
 drivers/bus/fslmc/fslmc_bus.c  | 15 ++++++++++++++-
 drivers/bus/fslmc/fslmc_vfio.c | 10 ----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 4b80948aee..a03ef6051a 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -519,10 +519,23 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
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
+		if (dev->dev_type != DPAA2_ETH &&
+		    dev->dev_type != DPAA2_CRYPTO &&
+		    dev->dev_type != DPAA2_QDMA)
+			continue;
+		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
+			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
+	}
+
 	ret = fslmc_vfio_close_group();
 	if (ret)
 		DPAA2_BUS_INFO("Unable to close devices %d", ret);
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index d67232c31b..5720f366db 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1392,7 +1392,6 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 	int vfio_fd)
 {
 	struct rte_dpaa2_object *object = NULL;
-	const struct rte_dpaa2_driver *drv;
 	int ret;
 
 	switch (dev->dev_type) {
@@ -1408,15 +1407,6 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
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
-- 
2.54.0

