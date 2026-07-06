Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0300C44500
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 15:06:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6C43402E9;
	Mon,  6 Jul 2026 17:06:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C5606402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 17:06:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783350393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Qw4AKwq+4ouDJA07HsT440a4VYbGBGI4yvunn4z54U=;
 b=FN9gFGyXLUHBTuPTJiZQM0J6unCn7HWhxL2TN5ggOpzUOWAMjMihC63VBkyddQ/VeyZkSd
 w7v9ZWiL7PuoXIQ5SVqp/qZeFoJcIC/p2fik0bJ5Rq3kFIgEPsGNFjfXrsoS9MVwQOrATn
 RfmYdo/Gn7EBVxsiAeDhbBRXBeyNdgY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-mLhL6ozWOjSqT_NPzpdr2Q-1; Mon,
 06 Jul 2026 11:06:30 -0400
X-MC-Unique: mLhL6ozWOjSqT_NPzpdr2Q-1
X-Mimecast-MFC-AGG-ID: mLhL6ozWOjSqT_NPzpdr2Q_1783350388
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B5A81955DE4; Mon,  6 Jul 2026 15:06:28 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DD56318005B5; Mon,  6 Jul 2026 15:06:24 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Chengwen Feng <fengchengwen@huawei.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] drivers/bus: remove blocklist evaluation when probing a device
Date: Mon,  6 Jul 2026 17:06:11 +0200
Message-ID: <20260706150611.839502-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NpjTQhlqD6oJQd8AEdDA0dqwxedaVkglv_P229De98M_1783350388
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

.probe_device is called from EAL, that already evaluated if the device
is blocklisted.

Fixes: be29c42523d8 ("bus: implement probe in EAL")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/auxiliary/auxiliary_common.c | 7 -------
 drivers/bus/fslmc/fslmc_bus.c            | 7 -------
 drivers/bus/pci/pci_common.c             | 7 -------
 drivers/bus/vmbus/vmbus_common.c         | 7 -------
 4 files changed, 28 deletions(-)

diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 80b90a4961..016d124f0b 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -84,13 +84,6 @@ auxiliary_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	if (!auxiliary_dev_exists(dev->name))
 		return -ENOENT;
 
-	/* No initialization when marked as blocked, return without error. */
-	if (aux_dev->device.devargs != NULL &&
-	    aux_dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-		AUXILIARY_LOG(INFO, "Device is blocked, not initializing");
-		return -1;
-	}
-
 	if (aux_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		AUXILIARY_LOG(INFO, "Device %s is not NUMA-aware", aux_dev->name);
 
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 1a0eca30b4..3626b12316 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -513,13 +513,6 @@ fslmc_bus_probe_device(struct rte_driver *driver, struct rte_device *rte_dev)
 	struct rte_dpaa2_driver *drv = RTE_BUS_DRIVER(driver, *drv);
 	int ret = 0;
 
-	if (dev->device.devargs &&
-	    dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-		DPAA2_BUS_DEBUG("%s Blocked, skipping",
-			      dev->device.name);
-		return 0;
-	}
-
 	/* FIXME: probe_device should allocate intr_handle */
 	ret = drv->probe(drv, dev);
 	if (ret != 0) {
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 0f635e1537..dc8db80d3b 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -193,13 +193,6 @@ pci_probe_device(struct rte_driver *drv, struct rte_device *dev)
 		loc->domain, loc->bus, loc->devid, loc->function,
 		pci_dev->device.numa_node);
 
-	/* no initialization when marked as blocked, return without error */
-	if (pci_dev->device.devargs != NULL &&
-		pci_dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-		PCI_LOG(INFO, "  Device is blocked, not initializing");
-		return 1;
-	}
-
 	if (pci_dev->device.numa_node < 0 && rte_socket_count() > 1)
 		PCI_LOG(INFO, "Device %s is not NUMA-aware", pci_dev->name);
 
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index cd6e851e4c..4c64856abb 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -93,13 +93,6 @@ vmbus_probe_device(struct rte_driver *drv, struct rte_device *dev)
 	VMBUS_LOG(INFO, "VMBUS device %s on NUMA socket %i",
 		  guid, vmbus_dev->device.numa_node);
 
-	/* no initialization when marked as blocked, return without error */
-	if (vmbus_dev->device.devargs != NULL &&
-		vmbus_dev->device.devargs->policy == RTE_DEV_BLOCKED) {
-		VMBUS_LOG(INFO, "  Device is blocked, not initializing");
-		return 1;
-	}
-
 	/* allocate interrupt handle instance */
 	vmbus_dev->intr_handle =
 		rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
-- 
2.54.0

