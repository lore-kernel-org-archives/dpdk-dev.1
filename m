Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F0CA5FC4
	for <dpdk-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:18:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0849B4278A;
	Fri,  2 Oct 2026 11:18:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 0069342DE3
 for <dev@dpdk.org>; Fri,  2 Oct 2026 11:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790932716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTRhtr8FIl1/hADJEBOxTrxnnkuHWpin982KKTTra/k=;
 b=DbCXZH4gEU2kRAt/hl2osjZd6jvftGUYPlohLkGWS6zqdZXh5fiH4IxUuTnMifke53Xrss
 yaYzoO5656tJdGURf8qOvlTE7P1eynLbsP7sMFMR3Af8OE61FWT/Nh2mHGOMZJJogVseL9
 GwBPh3tlKPH3BpJW9csb6mXm5YHnbhg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-2jyu4seiOlWzrVGmMvx16Q-1; Fri,
 02 Oct 2026 05:18:31 -0400
X-MC-Unique: 2jyu4seiOlWzrVGmMvx16Q-1
X-Mimecast-MFC-AGG-ID: 2jyu4seiOlWzrVGmMvx16Q_1790932709
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03A4B184AE70; Fri,  2 Oct 2026 09:18:29 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D62541956095; Fri,  2 Oct 2026 09:18:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Chenbo Xia <chenbox@nvidia.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Wei Hu <weh@microsoft.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Kiran Kumar K <kirankumark@marvell.com>,
 Sunil Kumar Kori <skori@marvell.com>, Satha Rao <skoteshwar@marvell.com>,
 Jakub Grajciar <jgrajcia@cisco.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 4/5] interrupts: close interrupt FDs
Date: Fri,  2 Oct 2026 11:17:57 +0200
Message-ID: <20261002091758.2922227-5-david.marchand@redhat.com>
In-Reply-To: <20261002091758.2922227-1-david.marchand@redhat.com>
References: <20261002091758.2922227-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JBVVl4Wzi9YJ8VidQ2jLBTdkJx-QQJsP_mJhDsW7Cyo_1790932709
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

Add rte_intr_fd_close() and rte_intr_dev_fd_close() helpers to
encapsulate the common pattern of closing an interrupt handle's
file descriptor and resetting it to -1.

This simplifies code in multiple drivers that previously had to:
  if (rte_intr_fd_get(handle) >= 0) {
      close(rte_intr_fd_get(handle));
      rte_intr_fd_set(handle, -1);
  }

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v2:
- added unit test,
- converted bus/cdx and FreeBSD EAL interrupt code,
- added wrappers for common/cnxk,

---
 app/test/test_interrupts.c             | 72 ++++++++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst |  2 +
 drivers/bus/cdx/cdx_vfio.c             |  6 +--
 drivers/bus/pci/bsd/pci.c              |  7 +--
 drivers/bus/pci/linux/pci_uio.c        | 15 ++----
 drivers/bus/pci/linux/pci_vfio.c       | 16 ++----
 drivers/bus/pci/pci_common_uio.c       | 12 +----
 drivers/bus/vmbus/linux/vmbus_uio.c    | 13 ++---
 drivers/bus/vmbus/vmbus_common_uio.c   | 11 +---
 drivers/common/cnxk/roc_platform.h     |  2 +
 drivers/net/memif/memif_socket.c       | 13 ++---
 lib/eal/common/eal_common_interrupts.c | 23 ++++++++
 lib/eal/freebsd/eal_alarm.c            |  3 +-
 lib/eal/include/rte_interrupts.h       | 27 ++++++++++
 lib/eal/linux/eal_dev.c                |  5 +-
 15 files changed, 147 insertions(+), 80 deletions(-)

diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
index 74c725d916..5ec2a725c5 100644
--- a/app/test/test_interrupts.c
+++ b/app/test/test_interrupts.c
@@ -171,6 +171,65 @@ test_interrupt_handle_compare(struct rte_intr_handle *intr_handle_l,
 	return 0;
 }
 
+/**
+ * Tests for rte_intr_fd_close() and rte_intr_dev_fd_close().
+ */
+static int
+test_interrupt_close(void)
+{
+	struct rte_intr_handle *intr_handle;
+	int pipefd[2];
+
+	/* check with null intr_handle */
+	rte_intr_fd_close(NULL);
+	rte_intr_dev_fd_close(NULL);
+
+	intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (!intr_handle)
+		return -1;
+
+	if (pipe(pipefd) < 0) {
+		rte_intr_instance_free(intr_handle);
+		return -1;
+	}
+
+	if (rte_intr_fd_set(intr_handle, pipefd[0]) < 0 ||
+			rte_intr_dev_fd_set(intr_handle, pipefd[1]) < 0) {
+		close(pipefd[0]);
+		close(pipefd[1]);
+		rte_intr_instance_free(intr_handle);
+		return -1;
+	}
+
+	/* check rte_intr_fd_close */
+	rte_intr_fd_close(intr_handle);
+
+	if (rte_intr_fd_get(intr_handle) != -1) {
+		printf("fd not set to -1 after close\n");
+		close(pipefd[1]);
+		rte_intr_instance_free(intr_handle);
+		return -1;
+	}
+
+	/* calling again should be a noop */
+	rte_intr_fd_close(intr_handle);
+
+	/* check rte_intr_dev_fd_close */
+	rte_intr_dev_fd_close(intr_handle);
+
+	if (rte_intr_dev_fd_get(intr_handle) != -1) {
+		printf("dev_fd not set to -1 after close\n");
+		rte_intr_instance_free(intr_handle);
+		return -1;
+	}
+
+	/* calling again should be a noop */
+	rte_intr_dev_fd_close(intr_handle);
+
+	rte_intr_instance_free(intr_handle);
+	return 0;
+}
+
 #else
 /* to be implemented for bsd later */
 static inline int
@@ -208,6 +267,12 @@ test_interrupt_handle_compare(struct rte_intr_handle *intr_handle_l,
 
 	return 0;
 }
+
+static int
+test_interrupt_close(void)
+{
+	return 0;
+}
 #endif /* RTE_EXEC_ENV_LINUX */
 
 /**
@@ -568,6 +633,13 @@ test_interrupt(void)
 	}
 	rte_delay_ms(TEST_INTERRUPT_CHECK_INTERVAL);
 
+	printf("start interrupt close test\n");
+	if (test_interrupt_close() < 0) {
+		printf("fail to check interrupt close\n");
+		goto out;
+	}
+	rte_delay_ms(TEST_INTERRUPT_CHECK_INTERVAL);
+
 	ret = 0;
 
 out:
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 780899edc3..bbe14e3a43 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -217,6 +217,8 @@ API Changes
 
   * ``rte_intr_instance_alloc()`` now initializes file descriptors
     to invalid values instead of zero.
+  * Added ``rte_intr_fd_close()`` and ``rte_intr_dev_fd_close()``
+    helpers to close file descriptors and reset them to -1.
 
 * ethdev: Updated VMDq related API.
 
diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 0e4af4e940..8d67058bfe 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -110,11 +110,7 @@ cdx_vfio_unmap_resource_primary(struct rte_cdx_device *dev)
 			CDX_BUS_ERR("Error when disabling bus master for %s",
 				    dev->device.name);
 
-		if (close(rte_intr_fd_get(dev->intr_handle)) < 0) {
-			CDX_BUS_ERR("Error when closing eventfd file descriptor for %s",
-				dev->device.name);
-			return -1;
-		}
+		rte_intr_fd_close(dev->intr_handle);
 	}
 
 	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index bbe08605af..f1012bb91b 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -93,11 +93,8 @@ pci_uio_free_resource(struct rte_pci_device *dev,
 {
 	rte_free(uio_res);
 
-	if (rte_intr_fd_get(dev->intr_handle) >= 0) {
-		close(rte_intr_fd_get(dev->intr_handle));
-		rte_intr_fd_set(dev->intr_handle, -1);
-		rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
-	}
+	rte_intr_fd_close(dev->intr_handle);
+	rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
 }
 
 int
diff --git a/drivers/bus/pci/linux/pci_uio.c b/drivers/bus/pci/linux/pci_uio.c
index 40e96b1c67..0983474994 100644
--- a/drivers/bus/pci/linux/pci_uio.c
+++ b/drivers/bus/pci/linux/pci_uio.c
@@ -197,20 +197,11 @@ void
 pci_uio_free_resource(struct rte_pci_device *dev,
 		struct mapped_pci_resource *uio_res)
 {
-	int uio_cfg_fd = rte_intr_dev_fd_get(dev->intr_handle);
-
 	rte_free(uio_res);
 
-	if (uio_cfg_fd >= 0) {
-		close(uio_cfg_fd);
-		rte_intr_dev_fd_set(dev->intr_handle, -1);
-	}
-
-	if (rte_intr_fd_get(dev->intr_handle) >= 0) {
-		close(rte_intr_fd_get(dev->intr_handle));
-		rte_intr_fd_set(dev->intr_handle, -1);
-		rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
-	}
+	rte_intr_dev_fd_close(dev->intr_handle);
+	rte_intr_fd_close(dev->intr_handle);
+	rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
 }
 
 int
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index a92a0d86ec..84c338c68e 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -354,9 +354,7 @@ pci_vfio_enable_notifier(struct rte_pci_device *dev, int vfio_dev_fd)
 
 	return 0;
 error:
-	close(fd);
-
-	rte_intr_fd_set(dev->vfio_req_intr_handle, -1);
+	rte_intr_fd_close(dev->vfio_req_intr_handle);
 	rte_intr_type_set(dev->vfio_req_intr_handle, RTE_INTR_HANDLE_UNKNOWN);
 	rte_intr_dev_fd_set(dev->vfio_req_intr_handle, -1);
 
@@ -383,9 +381,7 @@ pci_vfio_disable_notifier(struct rte_pci_device *dev)
 		return -1;
 	}
 
-	close(rte_intr_fd_get(dev->vfio_req_intr_handle));
-
-	rte_intr_fd_set(dev->vfio_req_intr_handle, -1);
+	rte_intr_fd_close(dev->vfio_req_intr_handle);
 	rte_intr_type_set(dev->vfio_req_intr_handle, RTE_INTR_HANDLE_UNKNOWN);
 	rte_intr_dev_fd_set(dev->vfio_req_intr_handle, -1);
 
@@ -1073,13 +1069,7 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
 		return -1;
 	}
 
-	if (rte_intr_fd_get(dev->intr_handle) < 0)
-		return -1;
-
-	if (close(rte_intr_fd_get(dev->intr_handle)) < 0) {
-		PCI_LOG(INFO, "Error when closing eventfd file descriptor for %s", pci_addr);
-		return -1;
-	}
+	rte_intr_fd_close(dev->intr_handle);
 
 	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
 	if (vfio_dev_fd < 0)
diff --git a/drivers/bus/pci/pci_common_uio.c b/drivers/bus/pci/pci_common_uio.c
index 47d50721dc..52a10f806a 100644
--- a/drivers/bus/pci/pci_common_uio.c
+++ b/drivers/bus/pci/pci_common_uio.c
@@ -211,7 +211,6 @@ pci_uio_unmap_resource(struct rte_pci_device *dev)
 	struct mapped_pci_resource *uio_res;
 	struct mapped_pci_res_list *uio_res_list =
 			RTE_TAILQ_CAST(rte_uio_tailq.head, mapped_pci_res_list);
-	int uio_cfg_fd;
 
 	if (dev == NULL)
 		return;
@@ -222,15 +221,8 @@ pci_uio_unmap_resource(struct rte_pci_device *dev)
 		return;
 
 	/* close fd */
-	if (rte_intr_fd_get(dev->intr_handle) >= 0)
-		close(rte_intr_fd_get(dev->intr_handle));
-	uio_cfg_fd = rte_intr_dev_fd_get(dev->intr_handle);
-	if (uio_cfg_fd >= 0) {
-		close(uio_cfg_fd);
-		rte_intr_dev_fd_set(dev->intr_handle, -1);
-	}
-
-	rte_intr_fd_set(dev->intr_handle, -1);
+	rte_intr_fd_close(dev->intr_handle);
+	rte_intr_dev_fd_close(dev->intr_handle);
 	rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
 
 	/* secondary processes - just free maps */
diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index fbafc5027d..c52d6738a5 100644
--- a/drivers/bus/vmbus/linux/vmbus_uio.c
+++ b/drivers/bus/vmbus/linux/vmbus_uio.c
@@ -67,16 +67,9 @@ vmbus_uio_free_resource(struct rte_vmbus_device *dev,
 {
 	rte_free(uio_res);
 
-	if (rte_intr_dev_fd_get(dev->intr_handle) >= 0) {
-		close(rte_intr_dev_fd_get(dev->intr_handle));
-		rte_intr_dev_fd_set(dev->intr_handle, -1);
-	}
-
-	if (rte_intr_fd_get(dev->intr_handle) >= 0) {
-		close(rte_intr_fd_get(dev->intr_handle));
-		rte_intr_fd_set(dev->intr_handle, -1);
-		rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
-	}
+	rte_intr_dev_fd_close(dev->intr_handle);
+	rte_intr_fd_close(dev->intr_handle);
+	rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
 }
 
 int
diff --git a/drivers/bus/vmbus/vmbus_common_uio.c b/drivers/bus/vmbus/vmbus_common_uio.c
index 7459f4ea7a..9765f5f609 100644
--- a/drivers/bus/vmbus/vmbus_common_uio.c
+++ b/drivers/bus/vmbus/vmbus_common_uio.c
@@ -254,14 +254,7 @@ vmbus_uio_unmap_resource(struct rte_vmbus_device *dev)
 	rte_free(uio_res);
 
 	/* close fd */
-	if (rte_intr_fd_get(dev->intr_handle) >= 0)
-		close(rte_intr_fd_get(dev->intr_handle));
-
-	if (rte_intr_dev_fd_get(dev->intr_handle) >= 0) {
-		close(rte_intr_dev_fd_get(dev->intr_handle));
-		rte_intr_dev_fd_set(dev->intr_handle, -1);
-	}
-
-	rte_intr_fd_set(dev->intr_handle, -1);
+	rte_intr_fd_close(dev->intr_handle);
+	rte_intr_dev_fd_close(dev->intr_handle);
 	rte_intr_type_set(dev->intr_handle, RTE_INTR_HANDLE_UNKNOWN);
 }
diff --git a/drivers/common/cnxk/roc_platform.h b/drivers/common/cnxk/roc_platform.h
index ac4f76473f..aba9782023 100644
--- a/drivers/common/cnxk/roc_platform.h
+++ b/drivers/common/cnxk/roc_platform.h
@@ -171,8 +171,10 @@ plt_thread_is_valid(plt_thread_t thr)
 #define plt_intr_vec_list_free		rte_intr_vec_list_free
 #define plt_intr_fd_set			rte_intr_fd_set
 #define plt_intr_fd_get			rte_intr_fd_get
+#define plt_intr_fd_close		rte_intr_fd_close
 #define plt_intr_dev_fd_get		rte_intr_dev_fd_get
 #define plt_intr_dev_fd_set		rte_intr_dev_fd_set
+#define plt_intr_dev_fd_close		rte_intr_dev_fd_close
 #define plt_intr_type_get		rte_intr_type_get
 #define plt_intr_type_set		rte_intr_type_set
 #define plt_intr_instance_alloc		rte_intr_instance_alloc
diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 898ad75fa6..71139f2313 100644
--- a/drivers/net/memif/memif_socket.c
+++ b/drivers/net/memif/memif_socket.c
@@ -510,8 +510,7 @@ memif_intr_unregister_handler(struct rte_intr_handle *intr_handle, void *arg)
 	struct memif_control_channel *cc = arg;
 
 	/* close control channel fd */
-	if (rte_intr_fd_get(intr_handle) >= 0)
-		close(rte_intr_fd_get(intr_handle));
+	rte_intr_fd_close(intr_handle);
 	/* clear message queue */
 	while ((elt = TAILQ_FIRST(&cc->msg_queue)) != NULL) {
 		TAILQ_REMOVE(&cc->msg_queue, elt, next);
@@ -596,10 +595,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
-		if (rte_intr_fd_get(mq->intr_handle) > 0) {
-			close(rte_intr_fd_get(mq->intr_handle));
-			rte_intr_fd_set(mq->intr_handle, -1);
-		}
+		rte_intr_fd_close(mq->intr_handle);
 	}
 	for (i = 0; i < pmd->cfg.num_s2c_rings; i++) {
 		if (pmd->role == MEMIF_ROLE_SERVER) {
@@ -614,10 +610,7 @@ memif_disconnect(struct rte_eth_dev *dev)
 				continue;
 		}
 
-		if (rte_intr_fd_get(mq->intr_handle) > 0) {
-			close(rte_intr_fd_get(mq->intr_handle));
-			rte_intr_fd_set(mq->intr_handle, -1);
-		}
+		rte_intr_fd_close(mq->intr_handle);
 	}
 
 	memif_free_regions(dev);
diff --git a/lib/eal/common/eal_common_interrupts.c b/lib/eal/common/eal_common_interrupts.c
index 4e31a71319..8176eb089a 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -4,6 +4,7 @@
 
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 
 #include <rte_errno.h>
 #include <rte_interrupts.h>
@@ -219,6 +220,17 @@ int rte_intr_fd_get(const struct rte_intr_handle *intr_handle)
 	return -1;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_intr_fd_close, 26.11)
+void rte_intr_fd_close(struct rte_intr_handle *intr_handle)
+{
+	int fd = rte_intr_fd_get(intr_handle);
+
+	if (fd >= 0) {
+		close(fd);
+		rte_intr_fd_set(intr_handle, -1);
+	}
+}
+
 RTE_EXPORT_SYMBOL(rte_intr_type_set)
 int rte_intr_type_set(struct rte_intr_handle *intr_handle,
 	enum rte_intr_handle_type type)
@@ -265,6 +277,17 @@ int rte_intr_dev_fd_get(const struct rte_intr_handle *intr_handle)
 	return -1;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_dev_fd_close)
+void rte_intr_dev_fd_close(struct rte_intr_handle *intr_handle)
+{
+	int fd = rte_intr_dev_fd_get(intr_handle);
+
+	if (fd >= 0) {
+		close(fd);
+		rte_intr_dev_fd_set(intr_handle, -1);
+	}
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_intr_max_intr_set)
 int rte_intr_max_intr_set(struct rte_intr_handle *intr_handle,
 				 int max_intr)
diff --git a/lib/eal/freebsd/eal_alarm.c b/lib/eal/freebsd/eal_alarm.c
index 65d0af9aaa..ee4a961f9f 100644
--- a/lib/eal/freebsd/eal_alarm.c
+++ b/lib/eal/freebsd/eal_alarm.c
@@ -55,8 +55,7 @@ rte_eal_alarm_cleanup(void)
 	int ret = rte_intr_callback_unregister_sync(intr_handle,
 			eal_alarm_callback, (void *)-1);
 	if (ret >= 0) {
-		close(rte_intr_fd_get(intr_handle));
-		rte_intr_fd_set(intr_handle, -1);
+		rte_intr_fd_close(intr_handle);
 		rte_intr_instance_free(intr_handle);
 		intr_handle = NULL;
 	}
diff --git a/lib/eal/include/rte_interrupts.h b/lib/eal/include/rte_interrupts.h
index 1cfb9d3f8e..d04c0c7b15 100644
--- a/lib/eal/include/rte_interrupts.h
+++ b/lib/eal/include/rte_interrupts.h
@@ -279,6 +279,19 @@ rte_intr_fd_set(struct rte_intr_handle *intr_handle, int fd);
 int
 rte_intr_fd_get(const struct rte_intr_handle *intr_handle);
 
+/**
+ * Close the FD of the given interrupt handle instance,
+ * and set FD to -1.
+ *
+ * If FD is not valid (< 0), nothing is done.
+ *
+ * @param intr_handle
+ *  pointer to the interrupt handle.
+ */
+__rte_experimental
+void
+rte_intr_fd_close(struct rte_intr_handle *intr_handle);
+
 /**
  * Set the type field of interrupt handle with user provided
  * interrupt type.
@@ -467,6 +480,20 @@ __rte_internal
 int
 rte_intr_dev_fd_get(const struct rte_intr_handle *intr_handle);
 
+/**
+ * @internal
+ * Close the device FD of the given interrupt handle instance,
+ * and set device FD to -1.
+ *
+ * If device FD is not valid (< 0), nothing is done.
+ *
+ * @param intr_handle
+ *  pointer to the interrupt handle.
+ */
+__rte_internal
+void
+rte_intr_dev_fd_close(struct rte_intr_handle *intr_handle);
+
 /**
  * @internal
  * Set the max intr field of interrupt handle with user
diff --git a/lib/eal/linux/eal_dev.c b/lib/eal/linux/eal_dev.c
index 267b5a9493..35223b6b26 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -242,10 +242,7 @@ static void
 dev_delayed_unregister(void *param)
 {
 	rte_intr_callback_unregister(intr_handle, dev_uev_handler, param);
-	if (rte_intr_fd_get(intr_handle) >= 0) {
-		close(rte_intr_fd_get(intr_handle));
-		rte_intr_fd_set(intr_handle, -1);
-	}
+	rte_intr_fd_close(intr_handle);
 }
 
 static void
-- 
2.54.0

