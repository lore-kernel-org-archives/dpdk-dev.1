Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE0CEF5858
	for <dpdk-dev@archiver.kernel.org>; Sat, 14 Feb 2026 23:48:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E285940655;
	Sun, 15 Feb 2026 00:47:50 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 73DD240652
 for <dev@dpdk.org>; Sun, 15 Feb 2026 00:47:47 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso14284175e9.0
 for <dev@dpdk.org>; Sat, 14 Feb 2026 15:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771112867;
 x=1771717667; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t63r/50P2d4dwom9Mdwficzn4RmHG/m113iYhwJva9I=;
 b=Y9XkzEDbC0e6aXkEzS/hhHpS5neNX3KAsnWUHqYMQQ8NPMJjjt4Co4PQQU63x+mfQE
 aWYlKee4XNn7qRxxfHSI5JPcefsNx5BMNxOGflvdTV5SAatglEMZz5UQOsE2FADQFsCs
 j2FhaiFOReFnJEVD4F4X55BtFrnB60b2e99kksmfN79CBmZazSGaPl/XFwAJyTZaFdzl
 WqVMUKMuqoXI1iz9iM/OAk26vnVfJWCRARzdoLIH/U2ajXDZAj3Qm68KtR2HC89DCmqH
 LaxgRUdSBcgGQyvpWVm5fazmj8pTgfYcpyQxE3s9vT+HRegq/xkN/ddui9GbBckFNm/F
 sJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771112867; x=1771717667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t63r/50P2d4dwom9Mdwficzn4RmHG/m113iYhwJva9I=;
 b=SHaFxzoGTy9YCK9N44827AzW/tp6CQDyxHCBoaZCTyQ5Ulw3JZ5s9PmuGhYl0BfC1+
 bCkTa3AasPAF+T/l0djH78dbOT7Csol5KmYV/LlMNe/3bpfPysHnBWNvJVsBZAbhWzn2
 hMs1HD1uUCeBTpyBs8icjXIeWpKXWXIdF3sUI9llmTerZ/P2Rb0bL9UNzRn9Bhug1kHs
 ErLVlBV791StoFfTW8JKVzpmpykQWP0bxlR0uhm9C4HBc06xEyXv08ZUs6aUFvQsAgFu
 AamIyZNCP6EX+hwkQd5t8hXKqwOtFxrGpBFHhJ5zLKRomUEKrwn5gnhWsPbUwV96DdyD
 p4kA==
X-Gm-Message-State: AOJu0YxmthwDj2dPx0rk7i1jaaxkRYAHIAyJ0L8jEhyenOjeNG11zbep
 +WabFr125NOQmiYSSHHb/zu2AEoLNs9/NIikfGDXDZk6NSSRHO/Xyd+/+pTplnDigIiMXl6qP28
 St+YE
X-Gm-Gg: AZuq6aLcsTp6lHRhQsjjfeafJWksswfTgKOXrnwX337L+zOsrDXrRenzYDfL30OVvdG
 7x3+4HBmO+TajH4gIhwMdNhe8u1X2pJpDELVhtqWjedNWGTc68Z8waoX34NFXsQfzS+r1DYSvf6
 RBJ4yhXWuCDLJ/X/alGLZGxk1xm/ZECjWu3tPF1SNags0xCJazihS5GdYWqo6++A5fml9FUUBjI
 G3EyqTnL5dTwaU0OIRqY26UjVE7TNRgDll+N6T4f/C2jNnTcZ3BrwkjcNgaQwHVnYCqk0xF/MBt
 iS4RWk45HgVzZjTulNAI84qDcaprOR02D17ZYVaDr4x3ntFPcx3bkJ3xuEchz03uiH4/g7JigzC
 r9oFQjVgaxgF6s//q1ekNEqxvPMzee1uRw/Nu3YOAT3Vk8QNTe0/7xgSsUhNzhs+37a34L60CiT
 7nl3MXIrkfMvMuNfEhy6Aj/OYYn7QV68MSxsrDVtw4mqfq1L4Dfd3HC2VaSHpOf3KhivDx4oOx/
 p8=
X-Received: by 2002:a05:600c:4e49:b0:477:54cd:200e with SMTP id
 5b1f17b1804b1-48373a08300mr99714105e9.1.1771112866890; 
 Sat, 14 Feb 2026 15:47:46 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5ebd1bsm394921485e9.6.2026.02.14.15.47.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 15:47:46 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 09/11] net/rtap: add Rx interrupt support
Date: Sat, 14 Feb 2026 15:44:18 -0800
Message-ID: <20260214234726.188947-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260214234726.188947-1-stephen@networkplumber.org>
References: <20241210212757.83490-1-stephen@networkplumber.org>
 <20260214234726.188947-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add support for the DPDK Rx interrupt mechanism, enabling
power-aware applications (e.g. l3fwd-power) to sleep until
packets arrive rather than busy-polling.

Each Rx queue creates an eventfd during queue setup and registers
it with its io_uring instance via io_uring_register_eventfd().
When the kernel posts a CQE (completing a read, i.e. a packet
arrived), it signals the eventfd. These per-queue eventfds are
wired into a VDEV interrupt handle during dev_start when the
application has set intr_conf.rxq.

The enable op drains the eventfd counter to re-arm notification;
disable is a no-op since the application simply stops polling.
The eventfd is always created unconditionally so it is available
if the application enables Rx interrupts later.

The Rx interrupt handle is kept separate from the existing LSC
netlink interrupt handle to avoid coupling the two mechanisms.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/rtap.ini |   1 +
 drivers/net/rtap/rtap.h           |   6 ++
 drivers/net/rtap/rtap_ethdev.c    |  26 +++++++
 drivers/net/rtap/rtap_intr.c      | 120 ++++++++++++++++++++++++++++++
 drivers/net/rtap/rtap_rxtx.c      |  31 +++++++-
 5 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/rtap.ini b/doc/guides/nics/features/rtap.ini
index fe0c88a8fc..48fe3f1b33 100644
--- a/doc/guides/nics/features/rtap.ini
+++ b/doc/guides/nics/features/rtap.ini
@@ -6,6 +6,7 @@
 [Features]
 Link status          = Y
 Link status event    = Y
+Rx interrupt         = Y
 MTU update           = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/drivers/net/rtap/rtap.h b/drivers/net/rtap/rtap.h
index 2cc55c9667..2c17117a80 100644
--- a/drivers/net/rtap/rtap.h
+++ b/drivers/net/rtap/rtap.h
@@ -38,6 +38,7 @@ extern int rtap_logtype;
 struct rtap_rx_queue {
 	struct rte_mempool *mb_pool;	/* rx buffer pool */
 	struct io_uring io_ring;	/* queue of posted read's */
+	int intr_fd;			/* eventfd for Rx interrupt */
 	uint16_t port_id;
 	uint16_t queue_id;
 
@@ -62,6 +63,7 @@ struct rtap_pmd {
 	int if_index;			/* interface index */
 	int nlsk_fd;			/* netlink control socket */
 	struct rte_intr_handle *intr_handle; /* LSC interrupt handle */
+	struct rte_intr_handle *rx_intr_handle; /* Rx queue interrupt handle */
 	struct rte_ether_addr eth_addr; /* address assigned by kernel */
 
 	uint64_t rx_drop_base;		/* value of rx_dropped when reset */
@@ -101,5 +103,9 @@ void rtap_tx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id);
 
 /* rtap_intr.c */
 int rtap_lsc_set(struct rte_eth_dev *dev, int set);
+int rtap_rx_intr_vec_install(struct rte_eth_dev *dev);
+void rtap_rx_intr_vec_uninstall(struct rte_eth_dev *dev);
+int rtap_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id);
+int rtap_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id);
 
 #endif /* _RTAP_H_ */
diff --git a/drivers/net/rtap/rtap_ethdev.c b/drivers/net/rtap/rtap_ethdev.c
index 9c23ca2f16..2cbb66b675 100644
--- a/drivers/net/rtap/rtap_ethdev.c
+++ b/drivers/net/rtap/rtap_ethdev.c
@@ -220,8 +220,18 @@ rtap_dev_start(struct rte_eth_dev *dev)
 	if (ret != 0)
 		return ret;
 
+	/* Install Rx interrupt vector if requested by application */
+	if (dev->data->dev_conf.intr_conf.rxq) {
+		ret = rtap_rx_intr_vec_install(dev);
+		if (ret != 0) {
+			rtap_lsc_set(dev, 0);
+			return ret;
+		}
+	}
+
 	ret = rtap_set_link_up(dev);
 	if (ret != 0) {
+		rtap_rx_intr_vec_uninstall(dev);
 		rtap_lsc_set(dev, 0);
 		return ret;
 	}
@@ -242,6 +252,7 @@ rtap_dev_stop(struct rte_eth_dev *dev)
 
 	dev->data->dev_link.link_status = RTE_ETH_LINK_DOWN;
 
+	rtap_rx_intr_vec_uninstall(dev);
 	rtap_lsc_set(dev, 0);
 	rtap_set_link_down(dev);
 
@@ -275,6 +286,16 @@ rtap_dev_configure(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
+	/*
+	 * LSC and Rx queue interrupts both need dev->intr_handle,
+	 * so they cannot be enabled simultaneously.
+	 */
+	if (dev->data->dev_conf.intr_conf.lsc &&
+	    dev->data->dev_conf.intr_conf.rxq) {
+		PMD_LOG(ERR, "LSC and Rx queue interrupts are mutually exclusive");
+		return -ENOTSUP;
+	}
+
 	/*
 	 * Set offload flags visible on the kernel network interface.
 	 * This controls whether kernel will use checksum offload etc.
@@ -444,6 +465,9 @@ rtap_dev_close(struct rte_eth_dev *dev)
 			pmd->nlsk_fd = -1;
 		}
 
+		rte_intr_instance_free(pmd->rx_intr_handle);
+		pmd->rx_intr_handle = NULL;
+
 		rte_intr_instance_free(pmd->intr_handle);
 		pmd->intr_handle = NULL;
 	}
@@ -521,6 +545,8 @@ static const struct eth_dev_ops rtap_ops = {
 	.rx_queue_release	= rtap_rx_queue_release,
 	.tx_queue_setup		= rtap_tx_queue_setup,
 	.tx_queue_release	= rtap_tx_queue_release,
+	.rx_queue_intr_enable	= rtap_rx_queue_intr_enable,
+	.rx_queue_intr_disable	= rtap_rx_queue_intr_disable,
 };
 
 static int
diff --git a/drivers/net/rtap/rtap_intr.c b/drivers/net/rtap/rtap_intr.c
index 6cdfb412c3..3704c425b8 100644
--- a/drivers/net/rtap/rtap_intr.c
+++ b/drivers/net/rtap/rtap_intr.c
@@ -85,3 +85,123 @@ rtap_lsc_set(struct rte_eth_dev *dev, int set)
 
 	return 0;
 }
+
+/*
+ * Install per-queue Rx interrupt vector.
+ *
+ * Each Rx queue has an eventfd registered with its io_uring instance.
+ * When a CQE is posted (packet received), the kernel signals the eventfd.
+ * This function wires those eventfds into an rte_intr_handle so that
+ * DPDK's interrupt framework (rte_epoll_wait) can poll them.
+ *
+ * Only called when dev_conf.intr_conf.rxq is set.
+ */
+int
+rtap_rx_intr_vec_install(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+	uint16_t nb_rx = dev->data->nb_rx_queues;
+
+	if (pmd->rx_intr_handle != NULL) {
+		PMD_LOG(DEBUG, "Rx interrupt vector already installed");
+		return 0;
+	}
+
+	pmd->rx_intr_handle = rte_intr_instance_alloc(RTE_INTR_INSTANCE_F_PRIVATE);
+	if (pmd->rx_intr_handle == NULL) {
+		PMD_LOG(ERR, "Failed to allocate Rx intr handle");
+		return -ENOMEM;
+	}
+
+	if (rte_intr_type_set(pmd->rx_intr_handle, RTE_INTR_HANDLE_VDEV) < 0)
+		goto error;
+
+	if (rte_intr_nb_efd_set(pmd->rx_intr_handle, nb_rx) < 0)
+		goto error;
+
+	if (rte_intr_max_intr_set(pmd->rx_intr_handle, nb_rx + 1) < 0)
+		goto error;
+
+	for (uint16_t i = 0; i < nb_rx; i++) {
+		struct rtap_rx_queue *rxq = dev->data->rx_queues[i];
+
+		if (rxq == NULL || rxq->intr_fd < 0) {
+			PMD_LOG(ERR, "Rx queue %u not ready for interrupts", i);
+			goto error;
+		}
+
+		if (rte_intr_efds_index_set(pmd->rx_intr_handle, i,
+					    rxq->intr_fd) < 0) {
+			PMD_LOG(ERR, "Failed to set efd for queue %u", i);
+			goto error;
+		}
+	}
+
+	dev->intr_handle = pmd->rx_intr_handle;
+	PMD_LOG(DEBUG, "Rx interrupt vector installed for %u queues", nb_rx);
+	return 0;
+
+error:
+	rte_intr_instance_free(pmd->rx_intr_handle);
+	pmd->rx_intr_handle = NULL;
+	return -1;
+}
+
+/*
+ * Remove per-queue Rx interrupt vector.
+ * Restores dev->intr_handle to the LSC handle.
+ */
+void
+rtap_rx_intr_vec_uninstall(struct rte_eth_dev *dev)
+{
+	struct rtap_pmd *pmd = dev->data->dev_private;
+
+	if (pmd->rx_intr_handle == NULL)
+		return;
+
+	/* Restore LSC handle as device interrupt handle */
+	dev->intr_handle = pmd->intr_handle;
+
+	rte_intr_instance_free(pmd->rx_intr_handle);
+	pmd->rx_intr_handle = NULL;
+
+	PMD_LOG(DEBUG, "Rx interrupt vector uninstalled");
+}
+
+/*
+ * Enable Rx interrupt for a queue.
+ *
+ * Drain any pending eventfd notification so the next CQE
+ * triggers a fresh wakeup in rte_epoll_wait().
+ */
+int
+rtap_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
+{
+	struct rtap_rx_queue *rxq = dev->data->rx_queues[queue_id];
+	uint64_t val;
+
+	if (rxq == NULL || rxq->intr_fd < 0)
+		return -EINVAL;
+
+	/* Drain the eventfd counter to re-arm notification */
+	if (read(rxq->intr_fd, &val, sizeof(val)) < 0 && errno != EAGAIN) {
+		PMD_LOG(ERR, "eventfd drain failed queue %u: %s",
+			queue_id, strerror(errno));
+		return -errno;
+	}
+
+	return 0;
+}
+
+/*
+ * Disable Rx interrupt for a queue.
+ *
+ * Nothing to do - the eventfd stays registered with io_uring
+ * but the application simply stops polling it.
+ */
+int
+rtap_rx_queue_intr_disable(struct rte_eth_dev *dev __rte_unused,
+			   uint16_t queue_id __rte_unused)
+{
+	return 0;
+}
diff --git a/drivers/net/rtap/rtap_rxtx.c b/drivers/net/rtap/rtap_rxtx.c
index 7826169751..cd9b4f0bac 100644
--- a/drivers/net/rtap/rtap_rxtx.c
+++ b/drivers/net/rtap/rtap_rxtx.c
@@ -10,6 +10,7 @@
 #include <stddef.h>
 #include <string.h>
 #include <liburing.h>
+#include <sys/eventfd.h>
 #include <sys/types.h>
 #include <sys/uio.h>
 #include <linux/virtio_net.h>
@@ -437,6 +438,7 @@ rtap_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_d
 	rxq->mb_pool = mb_pool;
 	rxq->port_id = dev->data->port_id;
 	rxq->queue_id = queue_id;
+	rxq->intr_fd = -1;
 	dev->data->rx_queues[queue_id] = rxq;
 
 	if (io_uring_queue_init(nb_rx_desc, &rxq->io_ring, 0) != 0) {
@@ -444,10 +446,26 @@ rtap_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_d
 		goto error_rxq_free;
 	}
 
+	/*
+	 * Create an eventfd for Rx interrupt notification.
+	 * io_uring will signal this fd whenever a CQE is posted,
+	 * enabling power-aware applications to sleep until packets arrive.
+	 */
+	rxq->intr_fd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+	if (rxq->intr_fd < 0) {
+		PMD_LOG(ERR, "eventfd failed: %s", strerror(errno));
+		goto error_iouring_exit;
+	}
+
+	if (io_uring_register_eventfd(&rxq->io_ring, rxq->intr_fd) < 0) {
+		PMD_LOG(ERR, "io_uring_register_eventfd failed: %s", strerror(errno));
+		goto error_eventfd_close;
+	}
+
 	mbufs = calloc(nb_rx_desc, sizeof(struct rte_mbuf *));
 	if (mbufs == NULL) {
 		PMD_LOG(ERR, "Rx mbuf pointer alloc failed");
-		goto error_iouring_exit;
+		goto error_eventfd_close;
 	}
 
 	/* open shared tap fd maybe already setup */
@@ -494,6 +512,11 @@ rtap_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_id, uint16_t nb_rx_d
 	rtap_cancel_all(&rxq->io_ring);
 	rtap_queue_close(dev, queue_id);
 	free(mbufs);
+error_eventfd_close:
+	if (rxq->intr_fd >= 0) {
+		close(rxq->intr_fd);
+		rxq->intr_fd = -1;
+	}
 error_iouring_exit:
 	io_uring_queue_exit(&rxq->io_ring);
 error_rxq_free:
@@ -509,6 +532,12 @@ rtap_rx_queue_release(struct rte_eth_dev *dev, uint16_t queue_id)
 	if (rxq == NULL)
 		return;
 
+	if (rxq->intr_fd >= 0) {
+		io_uring_unregister_eventfd(&rxq->io_ring);
+		close(rxq->intr_fd);
+		rxq->intr_fd = -1;
+	}
+
 	rtap_cancel_all(&rxq->io_ring);
 	io_uring_queue_exit(&rxq->io_ring);
 
-- 
2.51.0

