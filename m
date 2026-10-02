Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D201ECA5FD4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:18:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF8BE42DCD;
	Fri,  2 Oct 2026 11:18:29 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 05A964278A
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zqt7VmPNAky3Isx73AxgAakaOJZznulTqyNe+BSRNyk=;
 b=TrksQ+H0bk6xme4BMkOk8qqJmbeJgYSQzpd22ZISfftR7+l6TN/3o0bnOUKnaI5kYCHQwA
 ig4OoUYtL2h9y26xek2o9WX0AKj+oTyrh8fe9yKNiM9tkZ92LRNsczqJKrpYMMZB04hKom
 WjhqIE57jUfy8bhgy4PBb1k2ZDXv1oU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-488-41Ua-SDsNnybfeDec1Jf6Q-1; Fri,
 02 Oct 2026 05:18:25 -0400
X-MC-Unique: 41Ua-SDsNnybfeDec1Jf6Q-1
X-Mimecast-MFC-AGG-ID: 41Ua-SDsNnybfeDec1Jf6Q_1790932703
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5502A1954238; Fri,  2 Oct 2026 09:18:23 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16C44180049F; Fri,  2 Oct 2026 09:18:19 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Wei Hu <weh@microsoft.com>,
 Gaetan Rivet <grive@u256.net>, Jakub Grajciar <jgrajcia@cisco.com>,
 Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 3/5] interrupts: mark file descriptors invalid on allocation
Date: Fri,  2 Oct 2026 11:17:56 +0200
Message-ID: <20261002091758.2922227-4-david.marchand@redhat.com>
In-Reply-To: <20261002091758.2922227-1-david.marchand@redhat.com>
References: <20261002091758.2922227-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iFLKRp3JevHTY9ukL92yYPqWuzcR15fTnrkRTq6Z3gI_1790932703
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

Initialize fd, dev_fd, and all efds array elements as invalid in
rte_intr_instance_alloc().
This follows Unix convention, avoiding confusion with fd 0
which could result from zero-initialization.

Update the API documentation to reflect this behavior and add a
unit test check to verify the fd is invalid after allocation.

Update the FreeBSD PCI implementation that checked against a 0 FD.

Add a hack in the unit test to let the UIO simulated tests pass.

Remove now-redundant initialization calls that were setting the fd
invalid right after allocation.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v4:
- allowed use of internal API in unit test,

Changes since RFC v1:
- squashed FreeBSD PCI update,
- updated unit test,

---
 app/test/test_interrupts.c             | 14 ++++++++++++--
 doc/guides/rel_notes/release_26_11.rst |  5 +++++
 drivers/bus/cdx/cdx_vfio.c             |  6 ------
 drivers/bus/pci/bsd/pci.c              |  2 +-
 drivers/bus/pci/linux/pci_vfio.c       | 11 -----------
 drivers/bus/pci/pci_common_uio.c       |  6 ------
 drivers/bus/vmbus/vmbus_common_uio.c   |  6 ------
 drivers/net/failsafe/failsafe.c        |  3 ---
 drivers/net/mana/mana.c                |  4 ----
 drivers/net/memif/rte_eth_memif.c      |  6 ------
 drivers/net/mlx4/mlx4.c                |  3 ---
 drivers/net/tap/rte_eth_tap.c          |  1 -
 lib/eal/common/eal_common_interrupts.c |  6 ++++++
 lib/eal/freebsd/eal_alarm.c            |  3 ---
 lib/eal/include/rte_interrupts.h       |  2 ++
 lib/eal/linux/eal_dev.c                |  4 ----
 16 files changed, 26 insertions(+), 56 deletions(-)

diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
index 3a5be92cd7..74c725d916 100644
--- a/app/test/test_interrupts.c
+++ b/app/test/test_interrupts.c
@@ -2,6 +2,8 @@
  * Copyright(c) 2010-2014 Intel Corporation
  */
 
+#define ALLOW_INTERNAL_API
+
 #include <stdio.h>
 #include <stdint.h>
 #include <unistd.h>
@@ -73,11 +75,13 @@ test_interrupt_init(void)
 			rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
 		if (!intr_handles[i])
 			return -1;
+		if (rte_intr_fd_get(intr_handles[i]) != -1)
+			return -1;
+		if (rte_intr_dev_fd_get(intr_handles[i]) != -1)
+			return -1;
 	}
 
 	test_intr_handle = intr_handles[TEST_INTERRUPT_HANDLE_INVALID];
-	if (rte_intr_fd_set(test_intr_handle, -1))
-		return -1;
 	if (rte_intr_type_set(test_intr_handle, RTE_INTR_HANDLE_UNKNOWN))
 		return -1;
 
@@ -90,6 +94,9 @@ test_interrupt_init(void)
 	test_intr_handle = intr_handles[TEST_INTERRUPT_HANDLE_VALID_UIO];
 	if (rte_intr_fd_set(test_intr_handle, pfds.readfd))
 		return -1;
+	/* HACK: UIO type does not require a device FD, but a valid handle should contain one */
+	if (rte_intr_dev_fd_set(test_intr_handle, INT_MAX))
+		return -1;
 	if (rte_intr_type_set(test_intr_handle, RTE_INTR_HANDLE_UIO))
 		return -1;
 
@@ -108,6 +115,9 @@ test_interrupt_init(void)
 	test_intr_handle = intr_handles[TEST_INTERRUPT_HANDLE_CASE1];
 	if (rte_intr_fd_set(test_intr_handle, pfds.writefd))
 		return -1;
+	/* HACK: UIO type does not require a device FD, but a valid handle should contain one */
+	if (rte_intr_dev_fd_set(test_intr_handle, INT_MAX))
+		return -1;
 	if (rte_intr_type_set(test_intr_handle, RTE_INTR_HANDLE_UIO))
 		return -1;
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 030bd84cea..780899edc3 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -213,6 +213,11 @@ API Changes
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* interrupts: Updated interrupt handle file descriptor management.
+
+  * ``rte_intr_instance_alloc()`` now initializes file descriptors
+    to invalid values instead of zero.
+
 * ethdev: Updated VMDq related API.
 
   * At port configuration time, the number of VMDq pools advertised by a driver
diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 11fe3265d2..0e4af4e940 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -397,9 +397,6 @@ cdx_vfio_map_resource_primary(struct rte_cdx_device *dev)
 	struct cdx_map *maps;
 	int vfio_dev_fd, i, ret;
 
-	if (rte_intr_fd_set(dev->intr_handle, -1))
-		return -1;
-
 	ret = rte_vfio_setup_device(RTE_CDX_BUS_DEVICES_PATH, dev_name,
 				    &vfio_dev_fd, &device_info);
 	if (ret)
@@ -493,9 +490,6 @@ cdx_vfio_map_resource_secondary(struct rte_cdx_device *dev)
 	const char *dev_name = dev->device.name;
 	struct cdx_map *maps;
 
-	if (rte_intr_fd_set(dev->intr_handle, -1))
-		return -1;
-
 	/* if we're in a secondary process, just find our tailq entry */
 	TAILQ_FOREACH(vfio_res, vfio_res_list, next) {
 		if (strcmp(vfio_res->name, dev_name))
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index c6df31d486..bbe08605af 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -93,7 +93,7 @@ pci_uio_free_resource(struct rte_pci_device *dev,
 {
 	rte_free(uio_res);
 
-	if (rte_intr_fd_get(dev->intr_handle)) {
+	if (rte_intr_fd_get(dev->intr_handle) >= 0) {
 		close(rte_intr_fd_get(dev->intr_handle));
 		rte_intr_fd_set(dev->intr_handle, -1);
 		rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index bc5c5c2499..a92a0d86ec 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -742,12 +742,6 @@ pci_vfio_map_resource_primary(struct rte_pci_device *dev)
 
 	struct pci_map *maps;
 
-	if (rte_intr_fd_set(dev->intr_handle, -1))
-		return -1;
-
-	if (rte_intr_fd_set(dev->vfio_req_intr_handle, -1))
-		return -1;
-
 	/* store PCI address string */
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
 			loc->domain, loc->bus, loc->devid, loc->function);
@@ -939,11 +933,6 @@ pci_vfio_map_resource_secondary(struct rte_pci_device *dev)
 
 	struct pci_map *maps;
 
-	if (rte_intr_fd_set(dev->intr_handle, -1))
-		return -1;
-	if (rte_intr_fd_set(dev->vfio_req_intr_handle, -1))
-		return -1;
-
 	/* store PCI address string */
 	snprintf(pci_addr, sizeof(pci_addr), PCI_PRI_FMT,
 			loc->domain, loc->bus, loc->devid, loc->function);
diff --git a/drivers/bus/pci/pci_common_uio.c b/drivers/bus/pci/pci_common_uio.c
index 71974e9f56..47d50721dc 100644
--- a/drivers/bus/pci/pci_common_uio.c
+++ b/drivers/bus/pci/pci_common_uio.c
@@ -101,12 +101,6 @@ pci_uio_map_resource(struct rte_pci_device *dev)
 	struct mapped_pci_res_list *uio_res_list =
 		RTE_TAILQ_CAST(rte_uio_tailq.head, mapped_pci_res_list);
 
-	if (rte_intr_fd_set(dev->intr_handle, -1))
-		return -1;
-
-	if (rte_intr_dev_fd_set(dev->intr_handle, -1))
-		return -1;
-
 	/* allocate uio resource */
 	ret = pci_uio_alloc_resource(dev, &uio_res);
 	if (ret)
diff --git a/drivers/bus/vmbus/vmbus_common_uio.c b/drivers/bus/vmbus/vmbus_common_uio.c
index c6e7e07302..7459f4ea7a 100644
--- a/drivers/bus/vmbus/vmbus_common_uio.c
+++ b/drivers/bus/vmbus/vmbus_common_uio.c
@@ -173,12 +173,6 @@ vmbus_uio_map_resource(struct rte_vmbus_device *dev)
 	int ret;
 
 	/* TODO: handle rescind */
-	if (rte_intr_fd_set(dev->intr_handle, -1))
-		return -1;
-
-	if (rte_intr_dev_fd_set(dev->intr_handle, -1))
-		return -1;
-
 	if (rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN))
 		return -1;
 
diff --git a/drivers/net/failsafe/failsafe.c b/drivers/net/failsafe/failsafe.c
index aa3fe53b22..3ba143924d 100644
--- a/drivers/net/failsafe/failsafe.c
+++ b/drivers/net/failsafe/failsafe.c
@@ -279,9 +279,6 @@ fs_eth_dev_create(struct rte_vdev_device *vdev)
 		goto cancel_alarm;
 	}
 
-	if (rte_intr_fd_set(PRIV(dev)->intr_handle, -1))
-		goto cancel_alarm;
-
 	if (rte_intr_type_set(PRIV(dev)->intr_handle, RTE_INTR_HANDLE_EXT))
 		goto cancel_alarm;
 
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 72c8501d3c..ff1745edff 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -1946,10 +1946,6 @@ mana_intr_install(struct rte_eth_dev *eth_dev, struct mana_priv *priv)
 		return -ENOMEM;
 	}
 
-	ret = rte_intr_fd_set(priv->intr_handle, -1);
-	if (ret)
-		goto free_intr;
-
 	ret = mana_fd_set_non_blocking(ctx->async_fd);
 	if (ret) {
 		DRV_LOG(ERR, "Failed to change async_fd to NONBLOCK");
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 1c8dc1d5ec..b41edbe8ff 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -1496,9 +1496,6 @@ memif_tx_queue_setup(struct rte_eth_dev *dev,
 	mq->n_pkts = 0;
 	mq->n_bytes = 0;
 
-	if (rte_intr_fd_set(mq->intr_handle, -1))
-		return -rte_errno;
-
 	if (rte_intr_type_set(mq->intr_handle, RTE_INTR_HANDLE_EXT))
 		return -rte_errno;
 
@@ -1536,9 +1533,6 @@ memif_rx_queue_setup(struct rte_eth_dev *dev,
 	mq->n_pkts = 0;
 	mq->n_bytes = 0;
 
-	if (rte_intr_fd_set(mq->intr_handle, -1))
-		return -rte_errno;
-
 	if (rte_intr_type_set(mq->intr_handle, RTE_INTR_HANDLE_EXT))
 		return -rte_errno;
 
diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index 28f1116891..dbcd98d49f 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -1062,9 +1062,6 @@ mlx4_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			goto port_error;
 		}
 
-		if (rte_intr_fd_set(priv->intr_handle, -1))
-			goto port_error;
-
 		if (rte_intr_type_set(priv->intr_handle, RTE_INTR_HANDLE_EXT))
 			goto port_error;
 
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index f23c23b465..aaa7f87af6 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2214,7 +2214,6 @@ eth_dev_tap_create(struct rte_vdev_device *vdev, const char *tap_name,
 	dev->tx_pkt_burst = pmd_tx_burst;
 
 	rte_intr_type_set(pmd->intr_handle, RTE_INTR_HANDLE_EXT);
-	rte_intr_fd_set(pmd->intr_handle, -1);
 	dev->intr_handle = pmd->intr_handle;
 
 	/* Presetup the fds to -1 as being not valid */
diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index a2a310750a..4e31a71319 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -68,6 +68,8 @@ struct rte_intr_handle *rte_intr_instance_alloc(uint32_t flags)
 		rte_errno = ENOMEM;
 		goto fail;
 	}
+	for (int i = 0; i < RTE_MAX_RXTX_INTR_VEC_ID; i++)
+		intr_handle->efds[i] = -1;
 
 	if (uses_rte_memory) {
 		intr_handle->elist = rte_zmalloc(NULL,
@@ -83,6 +85,8 @@ struct rte_intr_handle *rte_intr_instance_alloc(uint32_t flags)
 		goto fail;
 	}
 
+	intr_handle->fd = -1;
+	intr_handle->dev_fd = -1;
 	intr_handle->alloc_flags = flags;
 	intr_handle->nb_intr = RTE_MAX_RXTX_INTR_VEC_ID;
 
@@ -153,6 +157,8 @@ int rte_intr_event_list_update(struct rte_intr_handle *intr_handle, int size)
 		goto fail;
 	}
 	intr_handle->efds = tmp_efds;
+	for (int i = intr_handle->nb_intr; i < size; i++)
+		intr_handle->efds[i] = -1;
 
 	if (uses_rte_memory) {
 		tmp_elist = rte_realloc(intr_handle->elist,
diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
index 8544fe8d03..65d0af9aaa 100644
--- a/lib/eal/freebsd/eal_alarm.c
+++ b/lib/eal/freebsd/eal_alarm.c
@@ -76,9 +76,6 @@ rte_eal_alarm_init(void)
 	if (rte_intr_type_set(intr_handle, RTE_INTR_HANDLE_ALARM))
 		goto error;
 
-	if (rte_intr_fd_set(intr_handle, -1))
-		goto error;
-
 	/* on FreeBSD, timers don't use fd's, and their identifiers are stored
 	 * in separate namespace from fd's, so using any value is OK. however,
 	 * EAL interrupts handler expects fd's to be unique, so use an actual fd
diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
index 0ae16bbe19..1cfb9d3f8e 100644
--- a/lib/eal/include/rte_interrupts.h
+++ b/lib/eal/include/rte_interrupts.h
@@ -225,6 +225,8 @@ uint32_t rte_intr_active_events_flags(void);
  * can be realloced later based on size of MSIX interrupts supported by a PCI
  * device.
  *
+ * All file descriptors (fd, dev_fd, efds) are initialized to -1.
+ *
  * This function should be called from application or driver, before calling
  * any of the interrupt APIs.
  *
diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index 92fbd04a6a..267b5a9493 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -360,10 +360,6 @@ rte_dev_event_monitor_start(void)
 	if (ret)
 		goto exit;
 
-	ret = rte_intr_fd_set(intr_handle, -1);
-	if (ret)
-		goto exit;
-
 	ret = dev_uev_socket_fd_create();
 	if (ret) {
 		EAL_LOG(ERR, "error create device event fd.");
-- 
2.54.0

