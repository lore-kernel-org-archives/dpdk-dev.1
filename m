Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC08C531CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:55:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C66CF40BA4;
	Thu, 23 Jul 2026 15:54:57 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1B0FD40A7D
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jWhXHNzH0P7cKaYd31cNOz3JloN23ah1Sp16Md0gNrE=;
 b=Z5x9TVWgUfrAqB2XnSgtW6AvpzLJ9JUwotNlTyO+UZul91L3rHp8IvnFtzKsYujXpuqGWS
 sI2GxPo2oquaZrgdpD1USSRyJifZAiJrooJ+nLJ1C7B6ZjuLPk85JHqIHjIHKGg0l7ekWi
 +hq8/qMxMqg6mK5SyBKtyAksoWSwpVQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-5Mrny764MAOi_RdQZYf5fQ-1; Thu,
 23 Jul 2026 09:54:54 -0400
X-MC-Unique: 5Mrny764MAOi_RdQZYf5fQ-1
X-Mimecast-MFC-AGG-ID: 5Mrny764MAOi_RdQZYf5fQ_1784814893
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F3C5195FE2B; Thu, 23 Jul 2026 13:54:53 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0315C1955BD6; Thu, 23 Jul 2026 13:54:51 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 11/11] bus/fslmc: use generic cleanup
Date: Thu, 23 Jul 2026 15:53:59 +0200
Message-ID: <20260723135400.3621271-12-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KuEtKhvQmzg6RKR7m0TkwHyspzkNsRbMpqQ8JJOfZY4_1784814893
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

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 39afdee9ee..49f5d0290e 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -504,23 +504,18 @@ fslmc_bus_match(const struct rte_driver *drv, const struct rte_device *dev)
 	return false;
 }
 
-static int
-fslmc_bus_unplug_device(struct rte_device *rte_dev);
+static void
+fslmc_free_device(struct rte_device *rte_dev)
+{
+	free(RTE_BUS_DEVICE(rte_dev, struct rte_dpaa2_device));
+}
 
 static int
-rte_fslmc_close(struct rte_bus *bus)
+fslmc_cleanup(struct rte_bus *bus)
 {
-	struct rte_dpaa2_device *dev;
-	int ret = 0;
+	int ret;
 
-	RTE_BUS_FOREACH_DEV(dev, bus) {
-		if (dev->dev_type != DPAA2_ETH &&
-		    dev->dev_type != DPAA2_CRYPTO &&
-		    dev->dev_type != DPAA2_QDMA)
-			continue;
-		if (rte_dev_is_probed(&dev->device) && fslmc_bus_unplug_device(&dev->device))
-			DPAA2_BUS_ERR("Unable to remove %s", dev->device.name);
-	}
+	rte_bus_generic_cleanup(bus);
 
 	ret = fslmc_vfio_close_group();
 	if (ret)
@@ -646,7 +641,8 @@ fslmc_bus_unplug_device(struct rte_device *rte_dev)
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

