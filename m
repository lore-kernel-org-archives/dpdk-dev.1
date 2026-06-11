Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E679FCD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 09:47:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F01842F7E;
	Thu, 11 Jun 2026 11:47:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 741B440041
 for <dev@dpdk.org>; Thu, 11 Jun 2026 11:47:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781171236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sk/k1uS0EuIO0oEVXN64hRt5UycRpP1dt0J3CzEDBHM=;
 b=YcCzMAH4+3fxWWzLnzMcqtT+otMDWSYktyK6Hd1rvBMI+V5jzaWLsKaF24mxB8svhq5Ugy
 SAo/CHZuUB9OTN3lW7AHXUQmhsQDwDRMxpfpdSHJ65WuAL57mFG1UKhGL7eRhIdEO3K9Bl
 UitygcudFnDZ1lgRvv4MhFems6+LYGk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-ahAcYPkjMOKNvJnWPo3ddg-1; Thu,
 11 Jun 2026 05:47:11 -0400
X-MC-Unique: ahAcYPkjMOKNvJnWPo3ddg-1
X-Mimecast-MFC-AGG-ID: ahAcYPkjMOKNvJnWPo3ddg_1781171230
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4A83B18005AB; Thu, 11 Jun 2026 09:47:10 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.28])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0FFD230001A7; Thu, 11 Jun 2026 09:47:07 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH 12/13] bus/vmbus: store name in bus specific device
Date: Thu, 11 Jun 2026 11:45:49 +0200
Message-ID: <20260611094551.1514962-13-david.marchand@redhat.com>
In-Reply-To: <20260611094551.1514962-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 8eOF61EIW9mIUeW4CbCYXpU3vLYTnBb8HFJUl68jfmQ_1781171230
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

The device name is allocated with strdup() during scan and freed in
several places. However, when this bus cleanup is converted to use the
EAL generic helper, freeing the device object will require a custom
helper to also free the device name (and for this, a cast will be
needed).

Instead, add an embedded name array to rte_vmbus_device structure
(char name[RTE_DEV_NAME_MAX_LEN]) which is sufficient for all VMBUS
device names (UUID format: 36 characters, or shorter legacy format).

This simplifies the device freeing to a simple free() call.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/vmbus/bus_vmbus_driver.h |  1 +
 drivers/bus/vmbus/linux/vmbus_bus.c  | 10 +++-------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index 888d856141..706ff1fcf5 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -38,6 +38,7 @@ enum hv_uio_map {
  */
 struct rte_vmbus_device {
 	struct rte_device device;              /**< Inherit core device */
+	char name[RTE_DEV_NAME_MAX_LEN];       /**< VMBUS device name */
 	rte_uuid_t device_id;		       /**< VMBUS device id */
 	rte_uuid_t class_id;		       /**< VMBUS device type */
 	uint32_t relid;			       /**< id for primary */
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index 77d904ad6d..779ea50b92 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -280,15 +280,14 @@ vmbus_scan_one(const char *name)
 	char filename[PATH_MAX];
 	char dirname[PATH_MAX];
 	unsigned long tmp;
-	char *dev_name;
 
 	dev = calloc(1, sizeof(*dev));
 	if (dev == NULL)
 		return -1;
 
-	dev->device.name = dev_name = strdup(name);
-	if (!dev->device.name)
+	if (rte_strscpy(dev->name, name, sizeof(dev->name)) < 0)
 		goto error;
+	dev->device.name = dev->name;
 
 	/* sysfs base directory
 	 *   /sys/bus/vmbus/devices/7a08391f-f5a0-4ac0-9802-d13fd964f8df
@@ -305,7 +304,6 @@ vmbus_scan_one(const char *name)
 
 	/* skip non-network devices */
 	if (rte_uuid_compare(dev->class_id, vmbus_nic_uuid) != 0) {
-		free(dev_name);
 		free(dev);
 		return 0;
 	}
@@ -330,7 +328,7 @@ vmbus_scan_one(const char *name)
 		dev->monitor_id = UINT8_MAX;
 	}
 
-	dev->device.devargs = rte_bus_find_devargs(&rte_vmbus_bus, dev_name);
+	dev->device.devargs = rte_bus_find_devargs(&rte_vmbus_bus, dev->name);
 
 	dev->device.numa_node = SOCKET_ID_ANY;
 	if (vmbus_use_numa(dev)) {
@@ -360,7 +358,6 @@ vmbus_scan_one(const char *name)
 		} else { /* already registered */
 			VMBUS_LOG(NOTICE,
 				"%s already registered", name);
-			free(dev_name);
 			free(dev);
 		}
 		return 0;
@@ -371,7 +368,6 @@ vmbus_scan_one(const char *name)
 error:
 	VMBUS_LOG(DEBUG, "failed");
 
-	free(dev_name);
 	free(dev);
 	return -1;
 }
-- 
2.53.0

