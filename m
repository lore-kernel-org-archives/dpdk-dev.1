Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44093CC6B2D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 16:43:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D05040693;
	Wed, 14 Oct 2026 18:43:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A8D3640693
 for <dev@dpdk.org>; Wed, 14 Oct 2026 18:43:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791996233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SwMrVAPpcvYjt7lVQzhf4KBBxYCA+ArCYGVvJDumEEM=;
 b=fsU6F9nqWT11v3F3zyS5OhlRYsU359XLhsXxw6qjF4q6naAwe+GlRVPF3v4FU1o2uxTnBj
 GwRKM1DxnhqrrcR/5cOK/6yXGSAnXwcg8nsuq/Ut71hO/9ciJfvDZF15odojakQb505NPe
 XyxF/ko/jrknuSQ1DCjlMBJh1VE95SQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-5qlOfafVM1KjxvLljQervw-1; Wed,
 14 Oct 2026 16:43:49 +0000
X-MC-Unique: 5qlOfafVM1KjxvLljQervw-1
X-Mimecast-MFC-AGG-ID: 5qlOfafVM1KjxvLljQervw_1791996227
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E0411956079; Wed, 14 Oct 2026 16:43:47 +0000 (UTC)
Received: from dmarchan.redhat.corp
 (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF78A1800765; Wed, 14 Oct 2026 16:43:42 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org,
	hkalra@marvell.com
Cc: Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Chenbo Xia <chenbox@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Wei Hu <weh@microsoft.com>, Jie Liu <liujie5@linkdatatechnology.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Jakub Palider <jpalider@marvell.com>,
 Tomasz Duszynski <tduszynski@marvell.com>
Subject: [PATCH v2 5/5] interrupts: warn on leaked file descriptors
Date: Wed, 14 Oct 2026 18:43:12 +0200
Message-ID: <20261014164313.1755520-6-david.marchand@redhat.com>
In-Reply-To: <20261014164313.1755520-1-david.marchand@redhat.com>
References: <20261002091758.2922227-1-david.marchand@redhat.com>
 <20261014164313.1755520-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nqKzAMsPLI_FiWC1VqAcf82nRPkCJEJymlAqnMnCfMw_1791996227
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

Let's warn on interrupt handle that still reference what looks like a
valid file descriptor.

This will likely raise false positives, but it should help limiting FD
leaks on the long term.

Add missing reset to -1 in drivers, and document code.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
Changes since RFC v4:
- updated comment in net/tap,

Changes since RFC v2:
- split code comments added by patch 3 in the RFC v2,
- added a check on leftover FD in a interrupt handle,

---
 app/test/test_interrupts.c                       | 5 ++++-
 drivers/bus/cdx/cdx_vfio.c                       | 4 ++++
 drivers/bus/pci/linux/pci_vfio.c                 | 2 ++
 drivers/common/mlx5/linux/mlx5_common_os.c       | 6 +++++-
 drivers/net/mana/mana.c                          | 1 +
 drivers/net/mlx4/mlx4_intr.c                     | 1 +
 drivers/net/sxe2/sxe2_irq.c                      | 5 ++++-
 drivers/net/tap/rte_eth_tap.c                    | 1 +
 drivers/net/virtio/virtio_user/virtio_user_dev.c | 2 ++
 drivers/raw/cnxk_gpio/cnxk_gpio.c                | 3 +++
 drivers/vdpa/mlx5/mlx5_vdpa_event.c              | 1 +
 drivers/vdpa/mlx5/mlx5_vdpa_virtq.c              | 1 +
 lib/eal/common/eal_common_interrupts.c           | 6 ++++++
 13 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/app/test/test_interrupts.c b/app/test/test_interrupts.c
index 5ec2a725c5..2d63a2fd98 100644
--- a/app/test/test_interrupts.c
+++ b/app/test/test_interrupts.c
@@ -132,8 +132,11 @@ test_interrupt_deinit(void)
 {
 	int i;
 
-	for (i = 0; i < TEST_INTERRUPT_HANDLE_MAX; i++)
+	for (i = 0; i < TEST_INTERRUPT_HANDLE_MAX; i++) {
+		rte_intr_fd_set(intr_handles[i], -1);
+		rte_intr_dev_fd_set(intr_handles[i], -1);
 		rte_intr_instance_free(intr_handles[i]);
+	}
 	close(pfds.pipefd[0]);
 	close(pfds.pipefd[1]);
 
diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index b808c84691..7a554472c2 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -117,6 +117,8 @@ cdx_vfio_unmap_resource_primary(struct rte_cdx_device *dev)
 	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
 	if (vfio_dev_fd < 0)
 		return -1;
+	/* vfio_dev_fd is owned by VFIO, only clear reference here. */
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	ret = dev_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev->device.name,
 				      vfio_dev_fd);
@@ -151,6 +153,8 @@ cdx_vfio_unmap_resource_secondary(struct rte_cdx_device *dev)
 	vfio_dev_fd = rte_intr_dev_fd_get(dev->intr_handle);
 	if (vfio_dev_fd < 0)
 		return -1;
+	/* vfio_dev_fd is owned by VFIO, only clear reference here. */
+	rte_intr_dev_fd_set(dev->intr_handle, -1);
 
 	ret = dev_vfio_release_device(RTE_CDX_BUS_DEVICES_PATH, dev->device.name,
 				      vfio_dev_fd);
diff --git a/drivers/bus/pci/linux/pci_vfio.c b/drivers/bus/pci/linux/pci_vfio.c
index f36de41057..fb35bc1d49 100644
--- a/drivers/bus/pci/linux/pci_vfio.c
+++ b/drivers/bus/pci/linux/pci_vfio.c
@@ -357,6 +357,7 @@ pci_vfio_enable_notifier(struct rte_pci_device *dev, int vfio_dev_fd)
 error:
 	rte_intr_fd_close(dev->vfio_req_intr_handle);
 	rte_intr_type_set(dev->vfio_req_intr_handle, RTE_INTR_HANDLE_UNKNOWN);
+	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
 	rte_intr_dev_fd_set(dev->vfio_req_intr_handle, -1);
 
 	return -1;
@@ -384,6 +385,7 @@ pci_vfio_disable_notifier(struct rte_pci_device *dev)
 
 	rte_intr_fd_close(dev->vfio_req_intr_handle);
 	rte_intr_type_set(dev->vfio_req_intr_handle, RTE_INTR_HANDLE_UNKNOWN);
+	/* vfio_dev_fd is managed by VFIO layer, only clear reference here. */
 	rte_intr_dev_fd_set(dev->vfio_req_intr_handle, -1);
 
 	return 0;
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 11a4eb8eee..903963670d 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -1108,6 +1108,7 @@ mlx5_os_interrupt_handler_create(int mode, bool set_fd_nonblock, int fd,
 	}
 	return tmp_intr_handle;
 err:
+	rte_intr_fd_set(tmp_intr_handle, -1);
 	rte_intr_instance_free(tmp_intr_handle);
 	return NULL;
 }
@@ -1181,8 +1182,11 @@ void
 mlx5_os_interrupt_handler_destroy(struct rte_intr_handle *intr_handle,
 				  rte_intr_callback_fn cb, void *cb_arg)
 {
-	if (rte_intr_fd_get(intr_handle) >= 0)
+	if (rte_intr_fd_get(intr_handle) >= 0) {
 		mlx5_intr_callback_unregister(intr_handle, cb, cb_arg);
+		/* fd is not owned by the driver, only clear reference here. */
+		rte_intr_fd_set(intr_handle, -1);
+	}
 	rte_intr_instance_free(intr_handle);
 }
 
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index ff1745edff..30b0ce90d6 100644
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
diff --git a/drivers/net/sxe2/sxe2_irq.c b/drivers/net/sxe2/sxe2_irq.c
index 4c3a29900d..256949e74e 100644
--- a/drivers/net/sxe2/sxe2_irq.c
+++ b/drivers/net/sxe2/sxe2_irq.c
@@ -397,8 +397,11 @@ static void sxe2_intr_handler_destroy(struct rte_intr_handle *intr_handle,
 	if (!intr_handle)
 		return;
 
-	if (rte_intr_fd_get(intr_handle) >= 0)
+	if (rte_intr_fd_get(intr_handle) >= 0) {
 		(void)rte_intr_callback_unregister(intr_handle, cb, cb_arg);
+		/* fd is not owned by the driver, only clear reference here. */
+		rte_intr_fd_set(intr_handle, -1);
+	}
 	rte_intr_instance_free(intr_handle);
 }
 
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 75ee2bb533..1d2b71675a 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -1968,6 +1968,7 @@ tap_lsc_intr_handle_set(struct rte_eth_dev *dev, int set)
 
 	if (rte_intr_fd_get(pmd->intr_handle) >= 0) {
 		tap_nl_final(rte_intr_fd_get(pmd->intr_handle));
+		/* fd has been closed already, only clear reference here. */
 		rte_intr_fd_set(pmd->intr_handle, -1);
 	}
 
diff --git a/drivers/net/virtio/virtio_user/virtio_user_dev.c b/drivers/net/virtio/virtio_user/virtio_user_dev.c
index f3df73c1f0..f89c871beb 100644
--- a/drivers/net/virtio/virtio_user/virtio_user_dev.c
+++ b/drivers/net/virtio/virtio_user/virtio_user_dev.c
@@ -858,6 +858,8 @@ virtio_user_dev_uninit(struct virtio_user_dev *dev)
 {
 	struct rte_eth_dev *eth_dev = &rte_eth_devices[dev->hw.port_id];
 
+	/* fd is not owned by the driver, only clear reference here. */
+	rte_intr_fd_set(eth_dev->intr_handle, -1);
 	rte_intr_instance_free(eth_dev->intr_handle);
 	eth_dev->intr_handle = NULL;
 
diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio.c b/drivers/raw/cnxk_gpio/cnxk_gpio.c
index e22fb7cf7b..8a5dda68dc 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio.c
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio.c
@@ -442,6 +442,8 @@ cnxk_gpio_unregister_irq(struct cnxk_gpio *gpio)
 	if (ret)
 		return ret;
 
+	/* fd is owned by gpio, only clear reference here. */
+	rte_intr_fd_set(gpio->intr.intr_handle, -1);
 	rte_intr_instance_free(gpio->intr.intr_handle);
 	gpio->intr.intr_handle = NULL;
 
@@ -635,6 +637,7 @@ cnxk_gpio_register_irq_compat(struct cnxk_gpio *gpio, struct cnxk_gpio_irq *irq,
 
 	return 0;
 out:
+	rte_intr_fd_set(intr_handle, -1);
 	rte_intr_instance_free(intr_handle);
 
 	return ret;
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
index 8176eb089a..6368ef1771 100644
--- a/lib/eal/common/eal_common_interrupts.c
+++ b/lib/eal/common/eal_common_interrupts.c
@@ -187,6 +187,12 @@ void rte_intr_instance_free(struct rte_intr_handle *intr_handle)
 {
 	if (intr_handle == NULL)
 		return;
+	if (rte_intr_fd_get(intr_handle) >= 0)
+		EAL_LOG(NOTICE, "Some interrupt handle is leaking a FD: %d",
+			rte_intr_fd_get(intr_handle));
+	if (rte_intr_dev_fd_get(intr_handle) >= 0)
+		EAL_LOG(NOTICE, "Some interrupt handle is leaking a device FD: %d",
+			rte_intr_dev_fd_get(intr_handle));
 	if (RTE_INTR_INSTANCE_USES_RTE_MEMORY(intr_handle->alloc_flags)) {
 		rte_free(intr_handle->efds);
 		rte_free(intr_handle->elist);
-- 
2.54.0

