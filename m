Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67113CA601E
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 11:48:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F7FF4064C;
	Fri,  9 Oct 2026 13:48:40 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B44B640431
 for <dev@dpdk.org>; Fri,  9 Oct 2026 13:48:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791546519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S4orX7aOL1a7oBJkFHHus6tY4SY1k6NDg6iA5v7+ZcE=;
 b=STSX8Yz3OfGv6muBVwWvzyfNcc2stg/A+SzHwyPMmwWitNCspU5OttKxfs/P6+mqsu5A/x
 vQ1W6aFN6u3S5HKNSyXkC4W04X3JaupFGA6XsoRjKr6VE1UsetNXvcvnh2wfod4OWfBNMS
 /2uZ8AJKNaUTErscLgMJHs/m5bZbbAA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-xT4OnFAVPv6pSvwj2jrobQ-1; Fri,
 9 Oct 2026 11:48:38 +0000
X-MC-Unique: xT4OnFAVPv6pSvwj2jrobQ-1
X-Mimecast-MFC-AGG-ID: xT4OnFAVPv6pSvwj2jrobQ_1791546517
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2353D180255C; Fri,  9 Oct 2026 11:48:36 +0000 (UTC)
Received: from dmarchan.home (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3919118002B1; Fri,  9 Oct 2026 11:48:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Kevin Laatz <kevin.laatz@intel.com>, Conor Walsh <conor.walsh@intel.com>,
 Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH] drivers/dma: cleanup PCI probing in Intel drivers
Date: Fri,  9 Oct 2026 13:48:30 +0200
Message-ID: <20261009114830.3630886-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U3Ta5-u3p8ar8roVrRgIXc91z0fk0X6YzrPhNWpainA_1791546517
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

Drivers are not responsible for setting the rte_device driver reference
since this has been factorized in EAL.

Fixes: f282771a04ef ("bus: factorize driver reference")

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/dma/idxd/idxd_pci.c    | 3 +--
 drivers/dma/ioat/ioat_dmadev.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/idxd_pci.c b/drivers/dma/idxd/idxd_pci.c
index bc4a584495..2b35d77613 100644
--- a/drivers/dma/idxd/idxd_pci.c
+++ b/drivers/dma/idxd/idxd_pci.c
@@ -323,7 +323,7 @@ init_pci_device(struct rte_pci_device *dev, struct idxd_dmadev *idxd,
 }
 
 static int
-idxd_dmadev_probe_pci(struct rte_pci_driver *drv, struct rte_pci_device *dev)
+idxd_dmadev_probe_pci(struct rte_pci_driver *drv __rte_unused, struct rte_pci_device *dev)
 {
 	struct idxd_dmadev idxd = {0};
 	uint8_t nb_wqs;
@@ -333,7 +333,6 @@ idxd_dmadev_probe_pci(struct rte_pci_driver *drv, struct rte_pci_device *dev)
 
 	rte_pci_device_name(&dev->addr, name, sizeof(name));
 	IDXD_PMD_INFO("Init %s on NUMA node %d", name, dev->device.numa_node);
-	dev->device.driver = &drv->driver;
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
 		char qname[32];
diff --git a/drivers/dma/ioat/ioat_dmadev.c b/drivers/dma/ioat/ioat_dmadev.c
index 8b7ff5652f..594f44248c 100644
--- a/drivers/dma/ioat/ioat_dmadev.c
+++ b/drivers/dma/ioat/ioat_dmadev.c
@@ -714,14 +714,13 @@ ioat_dmadev_destroy(const char *name)
 
 /* Probe DMA device. */
 static int
-ioat_dmadev_probe(struct rte_pci_driver *drv, struct rte_pci_device *dev)
+ioat_dmadev_probe(struct rte_pci_driver *drv __rte_unused, struct rte_pci_device *dev)
 {
 	char name[32];
 
 	rte_pci_device_name(&dev->addr, name, sizeof(name));
 	IOAT_PMD_INFO("Init %s on NUMA node %d", name, dev->device.numa_node);
 
-	dev->device.driver = &drv->driver;
 	return ioat_dmadev_create(name, dev);
 }
 
-- 
2.54.0

