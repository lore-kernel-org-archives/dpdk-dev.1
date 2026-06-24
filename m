Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141A6CDB47C
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 10:44:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E44240659;
	Wed, 24 Jun 2026 12:44:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id E903640687
 for <dev@dpdk.org>; Wed, 24 Jun 2026 12:44:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782297842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Km7QTxlDCim6Dx+b9p3Yph0Ov6XnJgpukqvoQn8pTBU=;
 b=gjbxQEq5BI+X0t/77zmDZWxY1279lW7Teg3JboxcPo7Cv3fc3Su2f5Zu2qLEOqMRYBZY00
 E8rJNQHyNwgzYUi40QsMzzEKsWFCEMDh5pqh49/1hYWA+YK574LDl+dEzdFuvI+yYQgo5f
 CDIxuf373cnVhIMF/syFgOT5TLOu+pU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-Vw6itwRpOKSkgXSCB8Jcsw-1; Wed,
 24 Jun 2026 06:43:57 -0400
X-MC-Unique: Vw6itwRpOKSkgXSCB8Jcsw-1
X-Mimecast-MFC-AGG-ID: Vw6itwRpOKSkgXSCB8Jcsw_1782297835
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CCEC19560AA; Wed, 24 Jun 2026 10:43:54 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 281811800370; Wed, 24 Jun 2026 10:43:49 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, fengchengwen@huawei.com, longli@microsoft.com,
 hemant.agrawal@nxp.com, stable@dpdk.org,
 Chaoyong He <chaoyong.he@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>, Long Wu <long.wu@corigine.com>,
 Shujing Dong <shujing.dong@corigine.com>
Subject: [PATCH v4 04/12] vdpa/nfp: fix double PCI unmap on unplug
Date: Wed, 24 Jun 2026 12:43:15 +0200
Message-ID: <20260624104324.3576408-5-david.marchand@redhat.com>
In-Reply-To: <20260624104324.3576408-1-david.marchand@redhat.com>
References: <20260611094551.1514962-1-david.marchand@redhat.com>
 <20260624104324.3576408-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XTjNEs49Y5INfqGcR468H_nVwMzSaEDHD4C6GdZVsss_1782297835
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

This driver uses its own VFIO container and handles mapping/unmapping
itself. It should not use RTE_PCI_DRV_NEED_MAPPING flag, which causes
the PCI bus to also attempt unmapping, resulting in double free.

Fixes: 7b2a1228c59d ("vdpa/nfp: add remap PCI memory")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/vdpa/nfp/nfp_vdpa.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index f4fd5c92ec..4c0ab3ff30 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -119,8 +119,6 @@ nfp_vdpa_vfio_setup(struct nfp_vdpa_dev *device)
 	char dev_name[RTE_DEV_NAME_MAX_LEN] = {0};
 	struct rte_pci_device *pci_dev = device->pci_dev;
 
-	rte_pci_unmap_device(pci_dev);
-
 	rte_pci_device_name(&pci_dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
 	ret = rte_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
 			&device->iommu_group);
@@ -1301,7 +1299,7 @@ static struct nfp_class_driver nfp_vdpa = {
 	.drv_class = NFP_CLASS_VDPA,
 	.name = RTE_STR(NFP_VDPA_DRIVER_NAME),
 	.id_table = pci_id_nfp_vdpa_map,
-	.drv_flags =  RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
+	.drv_flags = RTE_PCI_DRV_INTR_LSC,
 	.probe = nfp_vdpa_pci_probe,
 	.remove = nfp_vdpa_pci_remove,
 };
-- 
2.54.0

