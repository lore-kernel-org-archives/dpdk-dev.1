Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6652C982D3
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 07:50:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60A2242D0C;
	Thu, 17 Sep 2026 09:49:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 087B142D7D
 for <dev@dpdk.org>; Thu, 17 Sep 2026 09:49:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789631397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p8ziifpkz43I0f9Mi58eTQ8laJRq9ZtZ1Bx6+j0DKiE=;
 b=B6mxUsRcHANSBN482dPiriQgYtJbTvsSQEHHJTRp3lo4whFNLjNle/HgE9FZVm/ODy2BtW
 ChHxCqFJtu3vx6Vx+FNIqsvY6jnEwZcyilD7rAl8sF/RRtjlIGfJC2r75DkE8v1Ohj70FY
 +CdyfKpCSKhxipA8Tp/DULC952g/TmE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-9UcEnoYUNZqSucAqL1A5BA-1; Thu,
 17 Sep 2026 03:49:51 -0400
X-MC-Unique: 9UcEnoYUNZqSucAqL1A5BA-1
X-Mimecast-MFC-AGG-ID: 9UcEnoYUNZqSucAqL1A5BA_1789631390
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7A31800EFE; Thu, 17 Sep 2026 07:49:50 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64FF41956089; Thu, 17 Sep 2026 07:49:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 07/16] bus/fslmc: fix per type device count
Date: Thu, 17 Sep 2026 09:49:07 +0200
Message-ID: <20260917074917.595603-8-david.marchand@redhat.com>
In-Reply-To: <20260917074917.595603-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20260917074917.595603-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vB7uCi8ddvsAVMCuO33PdtNIjJrntjdIOQxMJx93Gx4_1789631390
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

When blocklisting some device, the per type count was wrong.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v1:
- moved counter decrement to the free helper,

---
 drivers/bus/fslmc/fslmc_bus.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 322b023652..e4aed1bb1a 100644
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

