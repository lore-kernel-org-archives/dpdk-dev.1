Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41E1606A31F
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OnMs5aqY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9224402E8;
	Mon, 26 Oct 2026 19:11:07 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTPS id D1A0940151
 for <dev@dpdk.org>; Mon, 26 Oct 2026 19:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793038263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8rYYb+gS1xNZgmTeCh47Q2i39QedXCIWw9CQF2Dy01k=;
 b=OnMs5aqYgojHm7qaO3VIvuSRy66QYWr0tAODY1wynEJ0Tem9vbU1/ZUdqf+S7dqqo2ZUyR
 pETvRofwMsW1UTCgI8mofpIFPdY++syVTQREQqAj0JjMoLtgwp/XVYQ7+xZKv+M5QHENoJ
 RXT2W9d5KbRIR3rD35+fPgVr5V9j62E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-i6Dtni9XN1iHu5GVxS6knw-1; Mon,
 26 Oct 2026 14:11:00 -0400
X-MC-Unique: i6Dtni9XN1iHu5GVxS6knw-1
X-Mimecast-MFC-AGG-ID: i6Dtni9XN1iHu5GVxS6knw_1793038258
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AB011955F40; Mon, 26 Oct 2026 18:10:58 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F5751956088; Mon, 26 Oct 2026 18:10:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Subject: [PATCH v2 07/16] bus/fslmc: fix per type device count
Date: Mon, 26 Oct 2026 19:10:21 +0100
Message-ID: <20261026181031.304100-8-david.marchand@redhat.com>
In-Reply-To: <20261026181031.304100-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261026181031.304100-1-david.marchand@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AnDeOmTi9mfkMPDCMwWVn4va7ATKD9L8rvUTld2ePMo_1793038258
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

When blocklisting some device, the per type count was wrong.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- moved counter decrement to the free helper,

---
 drivers/bus/fslmc/fslmc_bus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 38dd8afe34..b032a64620 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -83,6 +83,9 @@ insert_in_device_list(struct rte_dpaa2_device *newdev)
 
 	if (!inserted)
 		rte_bus_add_device(&rte_fslmc_bus, &newdev->device);
+
+	if (newdev->dev_type < DPAA2_DEVTYPE_MAX)
+		fslmc_bus_device_count[newdev->dev_type]++;
 }
 
 static void
@@ -90,6 +93,8 @@ fslmc_free_device(struct rte_device *rte_dev)
 {
 	struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 
+	if (dev->dev_type < DPAA2_DEVTYPE_MAX)
+		fslmc_bus_device_count[dev->dev_type]--;
 	rte_intr_instance_free(dev->intr_handle);
 	free(dev);
 }
@@ -203,9 +208,6 @@ scan_one_fslmc_device(char *dev_name)
 	dev->device.name = dev->name;
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
 
-	/* Update the device found into the device_count table */
-	fslmc_bus_device_count[dev->dev_type]++;
-
 	/* Add device in the fslmc device list */
 	insert_in_device_list(dev);
 
-- 
2.54.0

