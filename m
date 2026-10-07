Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED896CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:33:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BE31D42E4C;
	Wed,  7 Oct 2026 09:33:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 65967402DF
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:33:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791358387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONRrhuT03doY7RYT1qMKA9Ux33Nf/AYa33tIo4CHnKM=;
 b=KetgfLvjjEVCKC05HYxt3eHYDfbscYc9gRF+9Yfp8PoSgzjGeH0Xmu0fAicY7sse/1uen9
 48YsMTpyHJIrySoTjzZKIJTM7Qekw8cUXvhWILFyMF4X8JRV4DB2IBId0eycsf/MYSaMUn
 vSh6A3a9kP655HmJxzI+y/GINiuzBC4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-mXn89miiM7q5CfzHW29VVg-1; Wed,
 07 Oct 2026 03:33:06 -0400
X-MC-Unique: mXn89miiM7q5CfzHW29VVg-1
X-Mimecast-MFC-AGG-ID: mXn89miiM7q5CfzHW29VVg_1791358385
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6E021800772; Wed,  7 Oct 2026 07:33:05 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0479C1800446; Wed,  7 Oct 2026 07:33:04 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v19 14/26] vdpa/nfp: use container device assignment API
Date: Wed,  7 Oct 2026 09:31:52 +0200
Message-ID: <20261007073206.567001-15-david.marchand@redhat.com>
In-Reply-To: <20261007073206.567001-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DUQlDYQQ4y4uUmAeiOWSnp5yiehRb7fzEYqTGUp0R9g_1791358385
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

From: Anatoly Burakov <anatoly.burakov@intel.com>

The NFP vDPA driver uses VFIO group bind/unbind functionality for container
device assignment purposes. Use the new container device assignment API
instead to provide clearer semantics. Since group API is no longer used
after these changes, remove its implementation.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/vdpa/nfp/nfp_vdpa.c | 37 +++++--------------------------------
 1 file changed, 5 insertions(+), 32 deletions(-)

diff --git a/drivers/vdpa/nfp/nfp_vdpa.c b/drivers/vdpa/nfp/nfp_vdpa.c
index 94740e768d..76d7d616a6 100644
--- a/drivers/vdpa/nfp/nfp_vdpa.c
+++ b/drivers/vdpa/nfp/nfp_vdpa.c
@@ -36,9 +36,7 @@ struct nfp_vdpa_dev {
 	struct nfp_vdpa_hw hw;
 
 	int vfio_container_fd;
-	int vfio_group_fd;
 	int vfio_dev_fd;
-	int iommu_group;
 
 	rte_thread_t tid;    /**< Thread for notify relay */
 	int epoll_fd;
@@ -120,33 +118,26 @@ nfp_vdpa_vfio_setup(struct nfp_vdpa_dev *device)
 	struct rte_pci_device *pci_dev = device->pci_dev;
 
 	rte_pci_device_name(&pci_dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
-	ret = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), dev_name,
-			&device->iommu_group);
-	if (ret <= 0)
-		return -1;
 
 	device->vfio_container_fd = dev_vfio_container_create();
 	if (device->vfio_container_fd < 0)
 		return -1;
 
-	device->vfio_group_fd = dev_vfio_container_group_bind(
-			device->vfio_container_fd, device->iommu_group);
-	if (device->vfio_group_fd < 0)
+	ret = dev_vfio_container_assign_device(device->vfio_container_fd,
+			rte_pci_get_sysfs_path(), dev_name);
+	if (ret < 0)
 		goto container_destroy;
 
-	DRV_VDPA_LOG(DEBUG, "The container_fd=%d, group_fd=%d.",
-			device->vfio_container_fd, device->vfio_group_fd);
+	DRV_VDPA_LOG(DEBUG, "container_fd=%d", device->vfio_container_fd);
 
 	ret = rte_pci_map_device(pci_dev);
 	if (ret != 0)
-		goto group_unbind;
+		goto container_destroy;
 
 	device->vfio_dev_fd = rte_intr_dev_fd_get(pci_dev->intr_handle);
 
 	return 0;
 
-group_unbind:
-	dev_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
 container_destroy:
 	dev_vfio_container_destroy(device->vfio_container_fd);
 
@@ -157,7 +148,6 @@ static void
 nfp_vdpa_vfio_teardown(struct nfp_vdpa_dev *device)
 {
 	rte_pci_unmap_device(device->pci_dev);
-	dev_vfio_container_group_unbind(device->vfio_container_fd, device->iommu_group);
 	dev_vfio_container_destroy(device->vfio_container_fd);
 }
 
@@ -1023,22 +1013,6 @@ nfp_vdpa_dev_close(int vid)
 	return 0;
 }
 
-static int
-nfp_vdpa_get_vfio_group_fd(int vid)
-{
-	struct rte_vdpa_device *vdev;
-	struct nfp_vdpa_dev_node *node;
-
-	vdev = rte_vhost_get_vdpa_device(vid);
-	node = nfp_vdpa_find_node_by_vdev(vdev);
-	if (node == NULL) {
-		DRV_VDPA_LOG(ERR, "Invalid vDPA device: %p.", vdev);
-		return -ENODEV;
-	}
-
-	return node->device->vfio_group_fd;
-}
-
 static int
 nfp_vdpa_get_vfio_device_fd(int vid)
 {
@@ -1190,7 +1164,6 @@ struct rte_vdpa_dev_ops nfp_vdpa_ops = {
 	.dev_close = nfp_vdpa_dev_close,
 	.set_vring_state = nfp_vdpa_set_vring_state,
 	.set_features = nfp_vdpa_set_features,
-	.get_vfio_group_fd = nfp_vdpa_get_vfio_group_fd,
 	.get_vfio_device_fd = nfp_vdpa_get_vfio_device_fd,
 	.get_notify_area = nfp_vdpa_get_notify_area,
 };
-- 
2.54.0

