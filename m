Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DABC531CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 23 Jul 2026 13:19:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 678D2409FA;
	Thu, 23 Jul 2026 15:19:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 72F7540A6F
 for <dev@dpdk.org>; Thu, 23 Jul 2026 15:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784812783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cRmrtUZdp1q8nqEJiigd86j6FX2P5txSZwJBuznC1Jk=;
 b=ClTIRlxlCduYb7JiJ3Q2iTZLRePoHakV10v/2HjhyboRUlwLKgdKmt4KFMA/FCWGA6h6sf
 b4dH4A5N9xgM53zL8H+fapHew55IAqnuJ0KJuDIRB++5MMOUzUKsXkNHCYIL7rOksYKjim
 7zKxPjQRP+4lRt/Kq3htkpEBxCUiYlo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-Ofd7SZbEMVuzOFrgpA9I8Q-1; Thu,
 23 Jul 2026 09:19:41 -0400
X-MC-Unique: Ofd7SZbEMVuzOFrgpA9I8Q-1
X-Mimecast-MFC-AGG-ID: Ofd7SZbEMVuzOFrgpA9I8Q_1784812778
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29A741955D87; Thu, 23 Jul 2026 13:19:38 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.48.202])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BE721180025A; Thu, 23 Jul 2026 13:19:34 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: hkalra@marvell.com, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>,
 Jakub Grajciar <jgrajcia@cisco.com>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 4/4] interrupts: close interrupt FDs
Date: Thu, 23 Jul 2026 15:19:07 +0200
Message-ID: <20260723131908.3313223-5-david.marchand@redhat.com>
In-Reply-To: <20260723131908.3313223-1-david.marchand@redhat.com>
References: <20260723131908.3313223-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: InZKqTSSfjyv8yl9A4auNQhdkQUuAssuMc8pRb41fyE_1784812778
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
 doc/guides/rel_notes/release_26_11.rst |  2 ++
 drivers/bus/pci/bsd/pci.c              |  7 ++-----
 drivers/bus/pci/linux/pci_uio.c        | 15 +++-----------
 drivers/bus/pci/linux/pci_vfio.c       | 18 +++++------------
 drivers/bus/pci/pci_common_uio.c       | 12 ++----------
 drivers/bus/vmbus/linux/vmbus_uio.c    | 13 +++----------
 drivers/bus/vmbus/vmbus_common_uio.c   | 11 ++---------
 drivers/net/mana/mana.c                |  1 +
 drivers/net/memif/memif_socket.c       | 13 +++----------
 drivers/net/mlx4/mlx4_intr.c           |  1 +
 drivers/net/tap/rte_eth_tap.c          |  1 +
 drivers/vdpa/mlx5/mlx5_vdpa_event.c    |  1 +
 drivers/vdpa/mlx5/mlx5_vdpa_virtq.c    |  1 +
 lib/eal/common/eal_common_interrupts.c | 23 ++++++++++++++++++++++
 lib/eal/include/rte_interrupts.h       | 27 ++++++++++++++++++++++++++
 lib/eal/linux/eal_dev.c                |  5 +----
 16 files changed, 78 insertions(+), 73 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 55368b95a6..221aea45d2 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -88,6 +88,8 @@ API Changes
 
   * ``rte_intr_instance_alloc()`` now initializes file descriptors
     to invalid values instead of zero.
+  * Added ``rte_intr_fd_close()`` and ``rte_intr_dev_fd_close()``
+    helpers to close file descriptors and reset them to -1.
 
 
 ABI Changes
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
index a92a0d86ec..b5f05e9f9f 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -354,10 +354,9 @@ pci_vfio_enable_notifier(struct rte_pci_device *dev, int vfio_dev_fd)
 
 	return 0;
 error:
-	close(fd);
-
-	rte_intr_fd_set(dev->vfio_req_intr_handle, -1);
+	rte_intr_fd_close(dev->vfio_req_intr_handle);
 	rte_intr_type_set(dev->vfio_req_intr_handle, RTE_INTR_HANDLE_UNKNOWN);
+	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
 	rte_intr_dev_fd_set(dev->vfio_req_intr_handle, -1);
 
 	return -1;
@@ -383,10 +382,9 @@ pci_vfio_disable_notifier(struct rte_pci_device *dev)
 		return -1;
 	}
 
-	close(rte_intr_fd_get(dev->vfio_req_intr_handle));
-
-	rte_intr_fd_set(dev->vfio_req_intr_handle, -1);
+	rte_intr_fd_close(dev->vfio_req_intr_handle);
 	rte_intr_type_set(dev->vfio_req_intr_handle, RTE_INTR_HANDLE_UNKNOWN);
+	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
 	rte_intr_dev_fd_set(dev->vfio_req_intr_handle, -1);
 
 	return 0;
@@ -1073,13 +1071,7 @@ pci_vfio_unmap_resource_primary(struct rte_pci_device *dev)
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
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 1864ba2a2b..f51598ea68 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -1964,6 +1964,7 @@ mana_intr_install(struct rte_eth_dev *eth_dev, struct mana_priv *priv)
 					 mana_intr_handler, priv);
 	if (ret) {
 		DRV_LOG(ERR, "Failed to register intr callback");
+		/* fd is owned by ibverbs, only clear reference here. */
 		rte_intr_fd_set(priv->intr_handle, -1);
 		goto free_intr;
 	}
diff --git a/drivers/net/memif/memif_socket.c b/drivers/net/memif/memif_socket.c
index 649f8d0e61..94cd70fb89 100644
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
diff --git a/drivers/net/mlx4/mlx4_intr.c b/drivers/net/mlx4/mlx4_intr.c
index 01057482ec..c278dd5ecc 100644
--- a/drivers/net/mlx4/mlx4_intr.c
+++ b/drivers/net/mlx4/mlx4_intr.c
@@ -265,6 +265,7 @@ mlx4_intr_uninstall(struct mlx4_priv *priv)
 					     (void (*)(void *))
 					     mlx4_interrupt_handler,
 					     priv);
+		/* fd is owned by ibverbs, only clear reference here. */
 		if (rte_intr_fd_set(priv->intr_handle, -1))
 			return -rte_errno;
 	}
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 13114edba5..8a186c4ee6 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1946,6 +1946,7 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 	} while (true);
 
 	if (rte_intr_fd_get(pmd->intr_handle) >= 0) {
+		/* Netlink socket closed via tap_nl_final(). */
 		tap_nl_final(rte_intr_fd_get(pmd->intr_handle));
 		rte_intr_fd_set(pmd->intr_handle, -1);
 	}
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_event.c b/drivers/vdpa/mlx5/mlx5_vdpa_event.c
index dee2ccc23d..d18cf7d7e5 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_event.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_event.c
@@ -487,6 +487,7 @@ mlx5_vdpa_err_event_unset(struct mlx5_vdpa_priv *priv)
 			rte_pause();
 		}
 	}
+	/* fd is owned by err_chnl, only clear reference here. */
 	rte_intr_fd_set(priv->err_intr_handle, -1);
 	if (priv->err_chnl) {
 #ifdef HAVE_IBV_DEVX_EVENT
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_virtq.c b/drivers/vdpa/mlx5/mlx5_vdpa_virtq.c
index 093cdd08d2..9cad7e1df4 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_virtq.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_virtq.c
@@ -96,6 +96,7 @@ mlx5_vdpa_virtq_unregister_intr_handle(struct mlx5_vdpa_virtq *virtq)
 				pthread_mutex_lock(&virtq->virtq_lock);
 			}
 		}
+		/* fd is owned by vhost, only clear reference here. */
 		(void)rte_intr_fd_set(virtq->intr_handle, -1);
 	}
 	rte_intr_instance_free(virtq->intr_handle);
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
index c78e565427..4f55dcc4e7 100644
--- a/lib/eal/linux/eal_dev.c
+++ b/lib/eal/linux/eal_dev.c
@@ -217,10 +217,7 @@ static void
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

