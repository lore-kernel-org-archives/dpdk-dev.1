Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20230606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KhyOFxnl
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3690F40B91;
	Mon, 26 Oct 2026 19:11:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTPS id C51DB406FF
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:11:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qCtIe7U5Bf6fzVnGdR8o259hnUPMIZchukqS7HkiLBA=;
 b=KhyOFxnlns8/iEwCOx1IkXSh11QemZ7bjVN0vq2U8Sns4oyxZqFe/Euam6pYSqBP/sA+Ku
 Cupk6Y63JZcpY02rNsJsh8p19g4c3qtHJ7brLUzX8zcevcYv1gG6NFzyDcby4sTWEK29b0
 Jg59Q3R7snHyOJDwHCriWQLKvDlHA6A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-8-3zRWdHJJO3i2R5bpLjUqpg-1; Mon,
 26 Oct 2026 14:11:28 -0400
X-MC-Unique: 3zRWdHJJO3i2R5bpLjUqpg-1
X-Mimecast-MFC-AGG-ID: 3zRWdHJJO3i2R5bpLjUqpg_1793038287
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3FEF1955BCE; Mon, 26 Oct 2026 18:11:27 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C505D1956088; Mon, 26 Oct 2026 18:11:26 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 16/16] bus/fslmc: use generic cleanup
Date: Mon, 26 Oct 2026 19:10:30 +0100
Message-ID: <20261026181031.304100-17-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wQGWC_F2DBUzhPR9xJgvrmIOejNtyhqZygSHTIzyWSY_1793038287
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

Now that the probe and unplug callback behave like other buses, we can
call generic cleanup in addition to the special handling for IO devices.

Also cleanup any object left in the control devices list.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_bus.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index cf3cec246b..e40fe59c7c 100644
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

