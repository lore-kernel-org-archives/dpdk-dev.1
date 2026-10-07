Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E357DCA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 07:33:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 969F142E1C;
	Wed,  7 Oct 2026 09:33:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 79C4142E1C
 for <dev@dpdk.org>; Wed,  7 Oct 2026 09:33:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791358384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dwUihTVukEk2xm4xc9yzKksx+Q6f9myaMsutVm/i/2M=;
 b=gwAmvQmt5oW/iF06xFXoA2xw1wGwozAv/HaesCIEd9JPIPK0+DabiCbOXWRuYprO/HaR8A
 aVQVaBBUJQIUDYh2d8Y16wJZBwAY5/W6nkVEIE/jOpG1t3dFOnH4lJhncgf0EIU+WsBjsI
 C11gZMr89JPkXsjIDSNRhIsZGEF2KmI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-ZAeBDEbIPiWEx6Y0ELmDnA-1; Wed,
 07 Oct 2026 03:33:00 -0400
X-MC-Unique: ZAeBDEbIPiWEx6Y0ELmDnA-1
X-Mimecast-MFC-AGG-ID: ZAeBDEbIPiWEx6Y0ELmDnA_1791358379
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 489241844BD3; Wed,  7 Oct 2026 07:32:59 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F0EE30000E6; Wed,  7 Oct 2026 07:32:57 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v19 12/26] net/ntnic: use container device assignment API
Date: Wed,  7 Oct 2026 09:31:50 +0200
Message-ID: <20261007073206.567001-13-david.marchand@redhat.com>
In-Reply-To: <20261007073206.567001-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007073206.567001-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EdyIqkWCMWSb7Ol0B0VUBL_g9OplfambLD_1DgYj7NE_1791358379
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

The NTNIC driver uses VFIO group bind/unbind functionality for container
device assignment purposes. Use the new container device assignment API
instead to provide clearer semantics.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/ntnic/ntnic_vfio.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_vfio.c b/drivers/net/ntnic/ntnic_vfio.c
index 8489a59859..cacd81643f 100644
--- a/drivers/net/ntnic/ntnic_vfio.c
+++ b/drivers/net/ntnic/ntnic_vfio.c
@@ -28,7 +28,6 @@ nt_vfio_vf_num(const struct rte_pci_device *pdev)
 /* Internal API */
 struct vfio_dev {
 	int container_fd;
-	int group_fd;
 	int dev_fd;
 	uint64_t iova_addr;
 };
@@ -50,7 +49,6 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 {
 	int ret;
 	char devname[RTE_DEV_NAME_MAX_LEN] = { 0 };
-	int iommu_group_num;
 	int vf_num;
 	struct vfio_dev *vfio;
 
@@ -66,14 +64,9 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 	}
 
 	vfio->dev_fd = -1;
-	vfio->group_fd = -1;
 	vfio->iova_addr = START_VF_IOVA;
 
 	rte_pci_device_name(&dev->addr, devname, RTE_DEV_NAME_MAX_LEN);
-	ret = dev_vfio_get_group_num(rte_pci_get_sysfs_path(), devname, &iommu_group_num);
-	if (ret <= 0)
-		return -1;
-
 	if (vf_num == 0) {
 		/* use default container for pf0 */
 		vfio->container_fd = DEV_VFIO_DEFAULT_CONTAINER_FD;
@@ -86,17 +79,14 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 				"VFIO device setup failed. VFIO container creation failed.");
 			return -1;
 		}
-	}
-
-	vfio->group_fd = dev_vfio_container_group_bind(vfio->container_fd, iommu_group_num);
-
-	if (vfio->group_fd < 0) {
-		NT_LOG(ERR, NTNIC,
-			"VFIO device setup failed. VFIO container group bind failed.");
-		goto err;
-	}
+		ret = dev_vfio_container_assign_device(vfio->container_fd,
+				rte_pci_get_sysfs_path(), devname);
+		if (ret < 0) {
+			NT_LOG(ERR, NTNIC,
+				"VFIO device setup failed. Assign device to container failed.");
+			goto err;
+		}
 
-	if (vf_num > 0) {
 		if (rte_pci_map_device(dev)) {
 			NT_LOG(ERR, NTNIC,
 				"Map VFIO device failed. is the vfio-pci driver loaded?");
@@ -106,10 +96,8 @@ nthw_vfio_setup(struct rte_pci_device *dev)
 
 	vfio->dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
 
-	NT_LOG(DBG, NTNIC,
-		"%s: VFIO id=%d, dev_fd=%d, container_fd=%d, group_fd=%d, iommu_group_num=%d",
-		dev->name, vf_num, vfio->dev_fd, vfio->container_fd, vfio->group_fd,
-		iommu_group_num);
+	NT_LOG(DBG, NTNIC, "%s: VFIO id=%d, dev_fd=%d, container_fd=%d",
+		dev->name, vf_num, vfio->dev_fd, vfio->container_fd);
 
 	return vf_num;
 
-- 
2.54.0

