Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE89CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:40:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8820940A67;
	Wed, 14 Oct 2026 19:40:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 381A040615
 for <dev@dpdk.org>; Wed, 14 Oct 2026 19:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791999634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8rYYb+gS1xNZgmTeCh47Q2i39QedXCIWw9CQF2Dy01k=;
 b=UeaP/14r91NyURWcxj19UtXv8dSz65yeisk/yhyO+ecbNyBDuau6y6Qlag20MMo94nB5PF
 DsFDVR0WEERoPmYSnZEhB7zz8RbVO6ZxQkXmKzJhXpWfsR/pkP5akJtqPxc8/k3b4dTN0i
 rmTgaljDYnw6+9BgW9x1aVaCasc1eVw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-v3eSGduUNSmCk_0sJ_ysOg-1; Wed,
 14 Oct 2026 17:40:31 +0000
X-MC-Unique: v3eSGduUNSmCk_0sJ_ysOg-1
X-Mimecast-MFC-AGG-ID: v3eSGduUNSmCk_0sJ_ysOg_1791999630
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BCE61955DC5; Wed, 14 Oct 2026 17:40:30 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A239B1800495; Wed, 14 Oct 2026 17:40:29 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 07/16] bus/fslmc: fix per type device count
Date: Wed, 14 Oct 2026 19:39:50 +0200
Message-ID: <20261014174001.1830726-8-david.marchand@redhat.com>
In-Reply-To: <20261014174001.1830726-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
 <20261014174001.1830726-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zSy7L481O-h5u9XE7M3DLJZwsCXmT9JxWUH8xXwh8fk_1791999630
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

