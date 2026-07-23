Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3651CC531CF
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:54:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93F4F40679;
	Thu, 23 Jul 2026 15:54:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 474BE40678
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:54:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784814873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBfPtFwLLnM81bI5w1iXrxIjXlvDa+ZEP7vsQwaLhyI=;
 b=OMCoMfON8Q9LLkOodDxhMWyS2XKvIJk/e6JihcZnc1NxC5nhn0rwJZdWQvz1XnB/o0iv6Q
 1tAPQtZfBgW5zlb/talDU7trBfuCtKmc5fjSBzMyKkYkwxmD9V3XJ4IK83+zCjW+ogUPVd
 p8C7nW0wmpXuRiFUsCPK+lo6oDkRFAs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-2wGV4wMvPy-TlnBBLEknhw-1; Thu,
 23 Jul 2026 09:54:30 -0400
X-MC-Unique: 2wGV4wMvPy-TlnBBLEknhw-1
X-Mimecast-MFC-AGG-ID: 2wGV4wMvPy-TlnBBLEknhw_1784814869
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4134A1954126; Thu, 23 Jul 2026 13:54:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F171218005B8; Thu, 23 Jul 2026 13:54:27 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: hemant.agrawal@nxp.com,
	dev@dpdk.org
Cc: Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC 05/11] bus/fslmc: fix per type device count
Date: Thu, 23 Jul 2026 15:53:53 +0200
Message-ID: <20260723135400.3621271-6-david.marchand@redhat.com>
In-Reply-To: <20260723135400.3621271-1-david.marchand@redhat.com>
References: <20260723135400.3621271-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YVMpHKEI9MFLGoYh2zSSF6J0QjjPpfkhg5gkDJA25xI_1784814869
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
 drivers/bus/fslmc/fslmc_bus.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 94685a0f5a..a7ac59173f 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -83,11 +83,17 @@ insert_in_device_list(struct rte_dpaa2_device *newdev)
 
 	if (!inserted)
 		rte_bus_add_device(&rte_fslmc_bus, &newdev->device);
+
+	if (newdev->dev_type < DPAA2_DEVTYPE_MAX)
+		fslmc_bus_device_count[newdev->dev_type]++;
 }
 
 void
 fslmc_bus_remove_device(struct rte_dpaa2_device *dev)
 {
+	if (dev->dev_type < DPAA2_DEVTYPE_MAX)
+		fslmc_bus_device_count[dev->dev_type]--;
+
 	rte_bus_remove_device(&rte_fslmc_bus, &dev->device);
 	rte_intr_instance_free(dev->intr_handle);
 	free(dev);
@@ -195,9 +201,6 @@ scan_one_fslmc_device(char *dev_name)
 	}
 	dev->device.devargs = rte_bus_find_devargs(&rte_fslmc_bus, dev_name);
 
-	/* Update the device found into the device_count table */
-	fslmc_bus_device_count[dev->dev_type]++;
-
 	/* Add device in the fslmc device list */
 	insert_in_device_list(dev);
 
-- 
2.54.0

