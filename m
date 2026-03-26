Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4772A106F31D
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 10:25:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA24F42830;
	Thu, 26 Mar 2026 11:25:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 76999427E2
 for <dev@dpdk.org>; Thu, 26 Mar 2026 11:25:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774520705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubpxMqaAHuWMFfrQJxIAaF6V+WqZVZZAs68YRyc2cZc=;
 b=GCQUVtW7z4XF6OoU9VME0sKhWKVvVcTQTXWuYd/+QNnDkzhIXlF46N43VnTGeHD5QJfCNP
 Gfu5hqCEJrgw707faWXt7U/29BRfx+dPPF0kjn3DuwDg936qYPdZswvWOnYQyAUIMeXN26
 C3Yk3nL6XcRKaWy8Fnt8xjtsGSnzYtE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-cEli-XdBPbqfiMlPFfL0sw-1; Thu,
 26 Mar 2026 06:25:04 -0400
X-MC-Unique: cEli-XdBPbqfiMlPFfL0sw-1
X-Mimecast-MFC-AGG-ID: cEli-XdBPbqfiMlPFfL0sw_1774520703
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D25F5195609D; Thu, 26 Mar 2026 10:25:02 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D2F301955D84; Thu, 26 Mar 2026 10:25:00 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Maxime Leroy <maxime@leroys.fr>, Sachin Saxena <sachin.saxena@nxp.com>,
 Rohit Raj <rohit.raj@nxp.com>
Subject: [PATCH v2 2/7] bus/fslmc: fix bus cleanup
Date: Thu, 26 Mar 2026 11:24:18 +0100
Message-ID: <20260326102424.2361945-3-david.marchand@redhat.com>
In-Reply-To: <20260326102424.2361945-1-david.marchand@redhat.com>
References: <20260323105306.1531689-1-david.marchand@redhat.com>
 <20260326102424.2361945-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8_OmEp5XQVJpIGCrl4KWMQj7XQ8gaEgenH3J77y8t5Q_1774520703
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

The close operation was never closing probed devices.

Taking a step back, reevaluating the devargs makes no sense during the
close step, as a probed device must have passed the allow/block list
evaluation initially.

Since the device contains a reference to the driver that probed it,
simply call this driver remove op.

Fixes: 274fd921ff7f ("bus/fslmc: support close operation")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/bus/fslmc/fslmc_vfio.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 550d4e0e8d..7daa18d850 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -1393,7 +1393,7 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 {
 	struct rte_dpaa2_object *object = NULL;
 	struct rte_dpaa2_driver *drv;
-	int ret, probe_all;
+	int ret;
 
 	switch (dev->dev_type) {
 	case DPAA2_IO:
@@ -1411,22 +1411,9 @@ fslmc_close_iodevices(struct rte_dpaa2_device *dev,
 	case DPAA2_ETH:
 	case DPAA2_CRYPTO:
 	case DPAA2_QDMA:
-		probe_all = rte_fslmc_bus.bus.conf.scan_mode !=
-			    RTE_BUS_SCAN_ALLOWLIST;
-		TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
-			if (drv->drv_type != dev->dev_type)
-				continue;
-			if (rte_dev_is_probed(&dev->device))
-				continue;
-			if (probe_all ||
-			    (dev->device.devargs &&
-			     dev->device.devargs->policy ==
-			     RTE_DEV_ALLOWED)) {
-				ret = drv->remove(dev);
-				if (ret)
-					DPAA2_BUS_ERR("Unable to remove");
-			}
-		}
+		drv = dev->driver;
+		if (drv && drv->remove && drv->remove(dev))
+			DPAA2_BUS_ERR("Unable to remove");
 		break;
 	default:
 		break;
-- 
2.53.0

