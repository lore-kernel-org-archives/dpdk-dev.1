Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD963CA5FFF
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 Oct 2026 08:11:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 170AB42E96;
	Wed,  7 Oct 2026 10:11:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id D06FF427C8
 for <dev@dpdk.org>; Wed,  7 Oct 2026 10:11:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791360680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SZg1pCfQJ/5LVIl76ECo7+scNMokZ5WhjGIXJL24IEk=;
 b=gQsfynqmCFLxdlLgbx5lDG0ZoCJd3yRLmWNrIA2ZDn2ZxOmL9onVDwwMr1hOt13Z++RaaH
 sYtVdj7bItBi3OPpOY0xuMyc1H3oPWn5NKpQnuBD9O5mBaZFziwRqGfCeStYz80tWi7MdB
 g9ZVrhvZ+mZuAfCG62/GjFz3/Yo+O0w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-YmsmC3ZlOpOjENQfznigCQ-1; Wed,
 07 Oct 2026 04:11:17 -0400
X-MC-Unique: YmsmC3ZlOpOjENQfznigCQ-1
X-Mimecast-MFC-AGG-ID: YmsmC3ZlOpOjENQfznigCQ_1791360676
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E87CA195398C; Wed,  7 Oct 2026 08:11:15 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D7611956044; Wed,  7 Oct 2026 08:11:14 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Anatoly Burakov <anatoly.burakov@intel.com>,
 Dimon Zhao <dimon.zhao@nebula-matrix.com>,
 Leon Yu <leon.yu@nebula-matrix.com>, Sam Chen <sam.chen@nebula-matrix.com>
Subject: [RESEND][PATCH v19 11/26] net/nbl: do not use VFIO group bind API
Date: Wed,  7 Oct 2026 10:10:08 +0200
Message-ID: <20261007081026.574382-12-david.marchand@redhat.com>
In-Reply-To: <20261007081026.574382-1-david.marchand@redhat.com>
References: <cover.1763141462.git.anatoly.burakov@intel.com>
 <20261007081026.574382-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XgFwdtpJfTajWsnM5CRVcbdbARoCV-kzj9g0iCPUXgU_1791360676
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

The NBL driver currently uses group bind API, but it is using it only to
get group fd and nothing else. In context of NBL driver, this is the only
usage of VFIO API's in the driver, and it is not necessary to use it for
what NBL driver is trying to accomplish.

Use a direct `open()` call instead, store the group fd in common structure,
and find group fd's opened earlier to prevent us from opening the same
group fd twice.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/nbl/nbl_common/nbl_userdev.c  | 63 +++++++++++++++++------
 drivers/net/nbl/nbl_common/nbl_userdev.h  |  1 +
 drivers/net/nbl/nbl_include/nbl_include.h |  1 +
 3 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.c b/drivers/net/nbl/nbl_common/nbl_userdev.c
index 261bb8a4c1..91b7c8006f 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.c
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.c
@@ -388,6 +388,28 @@ nbl_userdev_mem_event_callback(enum rte_mem_event type, const void *addr, size_t
 	}
 }
 
+static int
+nbl_open_group_fd(int iommu_group_num)
+{
+	char path[PATH_MAX];
+
+	snprintf(path, sizeof(path), DEV_VFIO_GROUP_FMT, iommu_group_num);
+	return open(path, O_RDWR);
+}
+
+static int
+nbl_find_group_fd(int iommu_group_num)
+{
+	struct nbl_adapter *adapter;
+
+	TAILQ_FOREACH(adapter, &nbl_adapter_list, next) {
+		if (adapter->common.iommu_group_num == iommu_group_num)
+			return adapter->common.groupfd;
+	}
+
+	return -1;
+}
+
 static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 {
 	const struct rte_pci_device *pci_dev = adapter->pci_dev;
@@ -401,6 +423,7 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	u64 dma_limit = NBL_USERDEV_DMA_LIMIT;
 	int ret, container_create = 0, container_set = 0;
 	int vfio_group_fd, container = nbl_default_container;
+	bool new_group = false;
 
 	rte_pci_device_name(&pci_dev->addr, dev_name, RTE_DEV_NAME_MAX_LEN);
 	snprintf(pathname, sizeof(pathname),
@@ -425,11 +448,18 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 	}
 
 	NBL_LOG(DEBUG, "nbl vfio container %d", container);
-	vfio_group_fd = dev_vfio_container_group_bind(container, common->iommu_group_num);
+	rte_mcfg_mem_read_lock();
+	vfio_group_fd = nbl_find_group_fd(common->iommu_group_num);
+	rte_mcfg_mem_read_unlock();
+	if (vfio_group_fd < 0) {
+		vfio_group_fd = nbl_open_group_fd(common->iommu_group_num);
+		new_group = true;
+	}
 	if (vfio_group_fd < 0) {
 		NBL_LOG(ERR, "nbl vfio group bind failed, %d", vfio_group_fd);
 		goto free_container;
 	}
+	common->groupfd = vfio_group_fd;
 
 	/* check if the group is viable */
 	ret = ioctl(vfio_group_fd, VFIO_GROUP_GET_STATUS, &group_status);
@@ -518,13 +548,13 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 close_fd:
 	close(common->devfd);
 unregister_mem_event:
-	if (nbl_group_count == 1) {
+	if (container_set && nbl_group_count == 1) {
 		rte_mcfg_mem_read_lock();
 		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
 		rte_mcfg_mem_read_unlock();
 	}
 free_dma_map:
-	if (nbl_group_count == 1) {
+	if (container_set && nbl_group_count == 1) {
 		rte_mcfg_mem_read_lock();
 		nbl_userdev_dma_free();
 		rte_mcfg_mem_read_unlock();
@@ -535,8 +565,8 @@ static int nbl_mdev_map_device(struct nbl_adapter *adapter)
 		nbl_group_count--;
 	}
 free_group:
-	close(vfio_group_fd);
-	dev_vfio_clear_group(vfio_group_fd);
+	if (new_group)
+		close(vfio_group_fd);
 free_container:
 	if (container_create)
 		dev_vfio_container_destroy(container);
@@ -547,21 +577,24 @@ static int nbl_mdev_unmap_device(struct nbl_adapter *adapter)
 {
 	struct nbl_common_info *common = &adapter->common;
 	int vfio_group_fd, ret;
+	bool last_group_user;
 
 	rte_mcfg_mem_read_lock();
 	TAILQ_REMOVE(&nbl_adapter_list, adapter, next);
 	close(common->devfd);
-	vfio_group_fd = dev_vfio_container_group_bind(nbl_default_container,
-						      common->iommu_group_num);
+	common->devfd = -1;
+	vfio_group_fd = common->groupfd;
+	last_group_user = nbl_find_group_fd(common->iommu_group_num) < 0;
 	NBL_LOG(DEBUG, "close vfio_group_fd %d", vfio_group_fd);
-	ret = ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &nbl_default_container);
-	if (ret)
-		NBL_LOG(ERR, "unset container, error %i (%s) %d",
-			errno, strerror(errno), ret);
-	nbl_group_count--;
-	ret = dev_vfio_container_group_unbind(nbl_default_container, common->iommu_group_num);
-	if (ret)
-		NBL_LOG(ERR, "vfio container group unbind failed %d", ret);
+	if (last_group_user) {
+		ret = ioctl(vfio_group_fd, VFIO_GROUP_UNSET_CONTAINER, &nbl_default_container);
+		if (ret)
+			NBL_LOG(ERR, "unset container, error %i (%s) %d",
+				errno, strerror(errno), ret);
+		nbl_group_count--;
+		close(vfio_group_fd);
+		common->groupfd = -1;
+	}
 	if (!nbl_group_count) {
 		rte_mem_event_callback_unregister(NBL_USERDEV_EVENT_CLB_NAME, NULL);
 		nbl_userdev_dma_free();
diff --git a/drivers/net/nbl/nbl_common/nbl_userdev.h b/drivers/net/nbl/nbl_common/nbl_userdev.h
index 2221e19c67..1ebc86baf6 100644
--- a/drivers/net/nbl/nbl_common/nbl_userdev.h
+++ b/drivers/net/nbl/nbl_common/nbl_userdev.h
@@ -11,6 +11,7 @@
 #define NBL_USERDEV_INIT_COMMON(common) do {		\
 	typeof(common) _comm = (common);		\
 	_comm->devfd = -1;				\
+	_comm->groupfd = -1;				\
 	_comm->eventfd = -1;				\
 	_comm->specific_dma = false;			\
 	_comm->dma_set_msb = false;			\
diff --git a/drivers/net/nbl/nbl_include/nbl_include.h b/drivers/net/nbl/nbl_include/nbl_include.h
index eeae6a3301..ba99b9f8e7 100644
--- a/drivers/net/nbl/nbl_include/nbl_include.h
+++ b/drivers/net/nbl/nbl_include/nbl_include.h
@@ -132,6 +132,7 @@ struct nbl_common_info {
 	u16 vsi_id;
 	u16 instance_id;
 	int devfd;
+	int groupfd;
 	int eventfd;
 	int ifindex;
 	int iommu_group_num;
-- 
2.54.0

