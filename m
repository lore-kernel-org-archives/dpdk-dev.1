Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8397CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:47:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D4E742FCB;
	Thu, 11 Jun 2026 11:46:52 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7F6D642FC3
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:46:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bB5zFek+25sueGg8tgPlh+rwEkil5icnLw4w+ujNBU=;
 b=iaStpoh92Q+Fap/rqCqlcKerF8h0mQz8IXKbdXlo32hqp9Eo1rd56vEVD2O/RRmzxBbPZi
 VFbCYSBMS75YN7LjZnCSVnH1miKTFnbwL1i2VkDkOnrPtS3A0cdxjTcZtduNIvwZHr7hVb
 xw5b34TKZHLlB4bDiRATnewdOptGXUI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-x1Hon7z1OrKlrKyWiubaoA-1; Thu,
 11 Jun 2026 05:46:46 -0400
X-MC-Unique: x1Hon7z1OrKlrKyWiubaoA-1
X-Mimecast-MFC-AGG-ID: x1Hon7z1OrKlrKyWiubaoA_1781171205
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7230180034A; Thu, 11 Jun 2026 09:46:45 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40B19180058D; Thu, 11 Jun 2026 09:46:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH 08/13] bus/vmbus: allocate interrupt during probing
Date: Thu, 11 Jun 2026 11:45:45 +0200
Message-ID: <20260611094551.1514962-9-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _WMglsQOefQ_mDAzT_0uMXVF8_E3PsH1V0dOTiSK2mY_1781171205
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

Allocating the interrupt handle is a waste of memory if no device is
probed later (like for example, if a allowlist is passed).
Instead, allocate this handle at the time probe_device is called.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/vmbus/linux/vmbus_bus.c |  6 ------
 drivers/bus/vmbus/vmbus_common.c    | 18 +++++++++++++++++-
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 0af10f6a69..77d904ad6d 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -345,12 +345,6 @@ vmbus_scan_one(const char *name)
 		}
 	}
 
-	/* Allocate interrupt handle instance */
-	dev->intr_handle =
-		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-	if (dev->intr_handle == NULL)
-		goto error;
-
 	/* device is valid, add in list (sorted) */
 	VMBUS_LOG(DEBUG, "Adding vmbus device %s", name);
 
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index 74c1ddff69..b6ae82915f 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -108,11 +108,27 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (vmbus_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		VMBUS_LOG(INFO, "Device %s is not NUMA-aware", guid);
 
+	/* Allocate interrupt handle instance */
+	vmbus_dev->intr_handle =
+		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (vmbus_dev->intr_handle == NULL) {
+		ret = -ENOMEM;
+		goto unmap;
+	}
+
 	/* call the driver probe() function */
 	VMBUS_LOG(INFO, "  probe driver: %s", vmbus_drv->driver.name);
 	ret = vmbus_drv->probe(vmbus_drv, vmbus_dev);
 	if (ret != 0)
-		rte_vmbus_unmap_device(vmbus_dev);
+		goto free_intr;
+
+	return 0;
+
+free_intr:
+	rte_intr_instance_free(vmbus_dev->intr_handle);
+	vmbus_dev->intr_handle = NULL;
+unmap:
+	rte_vmbus_unmap_device(vmbus_dev);
 
 	return ret;
 }
-- 
2.53.0

